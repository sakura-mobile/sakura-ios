#import <Foundation/Foundation.h>

#include <netinet/in.h>

#include <QtCore/QString>
#include <QtCore/QDebug>

#include "reachabilityhelper.h"

static void ReachabilityCallback(SCNetworkReachabilityRef target, SCNetworkReachabilityFlags flags, void *info)
{
    Q_UNUSED(target)

    ((ReachabilityHelper *)info)->analyzeFlags(flags);
}

ReachabilityHelper::ReachabilityHelper(QObject *parent) : QObject(parent)
{
    Initialized       = false;
    InternetAvailable = false;
    InternetConnected = false;
    ReachabilityRef   = NULL;
}

ReachabilityHelper::~ReachabilityHelper()
{
    if (Initialized) {
        SCNetworkReachabilitySetCallback(ReachabilityRef, NULL, NULL);
        SCNetworkReachabilitySetDispatchQueue(ReachabilityRef, NULL);

        CFRelease(ReachabilityRef);
    }
}

bool ReachabilityHelper::internetAvailable() const
{
    return InternetAvailable;
}

bool ReachabilityHelper::internetConnected() const
{
    return InternetConnected;
}

void ReachabilityHelper::initialize()
{
    if (!Initialized) {
        struct sockaddr_in           address;
        SCNetworkReachabilityContext context = { 0, NULL, NULL, NULL, NULL };

        bzero(&address, sizeof(address));

        address.sin_len    = sizeof(address);
        address.sin_family = AF_INET;

        context.info = this;

        ReachabilityRef = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr *)&address);

        if (SCNetworkReachabilitySetCallback(ReachabilityRef, ReachabilityCallback, &context)) {
            dispatch_queue_t queue = dispatch_queue_create(NULL, NULL);

            if (SCNetworkReachabilitySetDispatchQueue(ReachabilityRef, queue)) {
                SCNetworkReachabilityFlags flags;

                if (SCNetworkReachabilityGetFlags(ReachabilityRef, &flags)) {
                    analyzeFlags(flags);
                }
            } else {
                qWarning() << QString("SCNetworkReachabilitySetDispatchQueue() failed: %1").arg(SCErrorString(SCError()));

                SCNetworkReachabilitySetCallback(ReachabilityRef, NULL, NULL);
            }

            dispatch_release(queue);
        } else {
            qWarning() << QString("SCNetworkReachabilitySetCallback() failed: %1").arg(SCErrorString(SCError()));
        }

        Initialized = true;
    }
}

void ReachabilityHelper::analyzeFlags(SCNetworkReachabilityFlags flags)
{
    if (flags & kSCNetworkReachabilityFlagsReachable) {
        InternetAvailable = true;

        if (flags & kSCNetworkReachabilityFlagsConnectionRequired) {
            InternetConnected = false;
        } else {
            InternetConnected = true;
        }
    } else {
        InternetAvailable = false;
        InternetConnected = false;
    }

    emit internetAvailableChanged(InternetAvailable);
    emit internetConnectedChanged(InternetConnected);
}

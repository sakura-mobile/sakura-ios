#import <Foundation/Foundation.h>

#include <netinet/in.h>

#include <QtCore/QString>
#include <QtCore/QDebug>

#include "reachabilityhelper.h"

static void ReachabilityCallback(SCNetworkReachabilityRef target, SCNetworkReachabilityFlags flags, void *info)
{
    Q_UNUSED(target)

    (static_cast<ReachabilityHelper *>(info))->analyzeFlags(flags);
}

ReachabilityHelper::ReachabilityHelper(QObject *parent) : QObject(parent)
{
    InternetAvailable = false;
    InternetConnected = false;

    struct sockaddr_in           address;
    SCNetworkReachabilityContext context = { 0, nullptr, nullptr, nullptr, nullptr };

    bzero(&address, sizeof(address));

    address.sin_len    = sizeof(address);
    address.sin_family = AF_INET;

    context.info = this;

    ReachabilityRef = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, reinterpret_cast<const struct sockaddr *>(&address));

    if (SCNetworkReachabilitySetCallback(ReachabilityRef, ReachabilityCallback, &context)) {
        dispatch_queue_t queue = dispatch_queue_create(nullptr, nullptr);

        if (SCNetworkReachabilitySetDispatchQueue(ReachabilityRef, queue)) {
            SCNetworkReachabilityFlags flags;

            if (SCNetworkReachabilityGetFlags(ReachabilityRef, &flags)) {
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
            }
        } else {
            qWarning() << QString("SCNetworkReachabilitySetDispatchQueue() failed: %1").arg(SCErrorString(SCError()));

            SCNetworkReachabilitySetCallback(ReachabilityRef, nullptr, nullptr);
        }

        dispatch_release(queue);
    } else {
        qWarning() << QString("SCNetworkReachabilitySetCallback() failed: %1").arg(SCErrorString(SCError()));
    }
}

ReachabilityHelper::~ReachabilityHelper()
{
    SCNetworkReachabilitySetCallback(ReachabilityRef, nullptr, nullptr);
    SCNetworkReachabilitySetDispatchQueue(ReachabilityRef, nullptr);

    CFRelease(ReachabilityRef);
}

bool ReachabilityHelper::internetAvailable() const
{
    return InternetAvailable;
}

bool ReachabilityHelper::internetConnected() const
{
    return InternetConnected;
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

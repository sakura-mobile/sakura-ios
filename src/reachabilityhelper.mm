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

    struct sockaddr_in           address = {};
    SCNetworkReachabilityContext context = {};

    address.sin_len    = sizeof(address);
    address.sin_family = AF_INET;

    context.info = this;

    ReachabilityRef = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, reinterpret_cast<const struct sockaddr *>(&address));

    if (ReachabilityRef != nullptr && ReachabilityRef != nil) {
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
                qWarning() << QStringLiteral("SCNetworkReachabilitySetDispatchQueue() failed: %1").arg(QString::fromUtf8(SCErrorString(SCError())));

                SCNetworkReachabilitySetCallback(ReachabilityRef, nullptr, nullptr);
            }

            dispatch_release(queue);
        } else {
            qWarning() << QStringLiteral("SCNetworkReachabilitySetCallback() failed: %1").arg(QString::fromUtf8(SCErrorString(SCError())));
        }
    } else {
        qWarning() << QStringLiteral("SCNetworkReachabilityCreateWithAddress() failed: %1").arg(QString::fromUtf8(SCErrorString(SCError())));
    }
}

ReachabilityHelper::~ReachabilityHelper() noexcept
{
    if (ReachabilityRef != nullptr && ReachabilityRef != nil) {
        SCNetworkReachabilitySetCallback(ReachabilityRef, nullptr, nullptr);
        SCNetworkReachabilitySetDispatchQueue(ReachabilityRef, nullptr);

        CFRelease(ReachabilityRef);
    }
}

ReachabilityHelper &ReachabilityHelper::GetInstance()
{
    static ReachabilityHelper instance;

    return instance;
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
    bool internet_available, internet_connected;

    if (flags & kSCNetworkReachabilityFlagsReachable) {
        internet_available = true;

        if (flags & kSCNetworkReachabilityFlagsConnectionRequired) {
            internet_connected = false;
        } else {
            internet_connected = true;
        }
    } else {
        internet_available = false;
        internet_connected = false;
    }

    if (InternetAvailable != internet_available) {
        InternetAvailable = internet_available;

        emit internetAvailableChanged(InternetAvailable);
    }

    if (InternetConnected != internet_connected) {
        InternetConnected = internet_connected;

        emit internetConnectedChanged(InternetConnected);
    }
}

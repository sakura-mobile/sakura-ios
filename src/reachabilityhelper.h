#ifndef REACHABILITYHELPER_H
#define REACHABILITYHELPER_H

#include <SystemConfiguration/SystemConfiguration.h>

#include <QtCore/QObject>

class ReachabilityHelper : public QObject
{
    Q_OBJECT

    Q_PROPERTY(bool internetAvailable READ internetAvailable NOTIFY internetAvailableChanged)
    Q_PROPERTY(bool internetConnected READ internetConnected NOTIFY internetConnectedChanged)

public:
    explicit ReachabilityHelper(QObject *parent = nullptr);

    ReachabilityHelper(const ReachabilityHelper&) = delete;
    ReachabilityHelper(ReachabilityHelper&&) noexcept = delete;

    ReachabilityHelper& operator=(const ReachabilityHelper&) = delete;
    ReachabilityHelper& operator=(ReachabilityHelper&&) noexcept = delete;

    ~ReachabilityHelper() noexcept override;

    bool internetAvailable() const;
    bool internetConnected() const;

    void analyzeFlags(SCNetworkReachabilityFlags flags);

signals:
    void internetAvailableChanged(bool available);
    void internetConnectedChanged(bool connected);

private:
    bool                     InternetAvailable, InternetConnected;
    SCNetworkReachabilityRef ReachabilityRef;
};

#endif // REACHABILITYHELPER_H

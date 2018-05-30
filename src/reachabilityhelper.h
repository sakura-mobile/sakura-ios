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
    explicit ReachabilityHelper(QObject *parent = 0);
    virtual ~ReachabilityHelper();

    bool internetAvailable() const;
    bool internetConnected() const;

    Q_INVOKABLE void initialize();

    void analyzeFlags(SCNetworkReachabilityFlags flags);

signals:
    void internetAvailableChanged(bool available);
    void internetConnectedChanged(bool connected);

private:
    bool                     Initialized, InternetAvailable, InternetConnected;
    SCNetworkReachabilityRef ReachabilityRef;
};

#endif // REACHABILITYHELPER_H

#ifndef FBHELPER_H
#define FBHELPER_H

#include <QtCore/QObject>
#include <QtCore/QString>

#ifdef __OBJC__
@class FBDelegate;
#endif

class FBHelper : public QObject
{
    Q_OBJECT

public:
    explicit FBHelper(QObject *parent = 0);
    virtual ~FBHelper();

    Q_INVOKABLE void initialize();
    Q_INVOKABLE void showGameRequest(const QString &title, const QString &message);
    Q_INVOKABLE void logout();

    static void notifyGameRequestCompleted();

signals:
    void gameRequestCompleted();

private:
    bool             Initialized;
    static FBHelper *Instance;
#ifdef __OBJC__
    FBDelegate      *FBDelegateInstance;
#else
    void            *FBDelegateInstance;
#endif
};

#endif // FBHELPER_H

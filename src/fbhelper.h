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
    explicit FBHelper(QObject *parent = nullptr);
    ~FBHelper() override;

    Q_INVOKABLE void showGameRequest(const QString &title, const QString &message);
    Q_INVOKABLE void logout();

    static void notifyGameRequestCompleted(int recipients_count);

signals:
    void gameRequestCompleted(int recipientsCount);

private:
    static FBHelper *Instance;
#ifdef __OBJC__
    FBDelegate      *FBDelegateInstance;
#else
    void            *FBDelegateInstance;
#endif
};

#endif // FBHELPER_H

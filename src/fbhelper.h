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

private:
    explicit FBHelper(QObject *parent = nullptr);
    ~FBHelper() noexcept override;

public:
    FBHelper(const FBHelper&) = delete;
    FBHelper(FBHelper&&) noexcept = delete;

    FBHelper &operator=(const FBHelper&) = delete;
    FBHelper &operator=(FBHelper&&) noexcept = delete;

    static FBHelper &GetInstance();

    Q_INVOKABLE void showGameRequest(const QString &title, const QString &message);
    Q_INVOKABLE void logout();

    static void notifyGameRequestCompleted(int recipients_count);

signals:
    void gameRequestCompleted(int recipientsCount);

private:
#ifdef __OBJC__
    FBDelegate *FBDelegateInstance;
#else
    void       *FBDelegateInstance;
#endif
};

#endif // FBHELPER_H

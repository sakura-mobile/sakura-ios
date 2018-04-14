#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

#include <QtCore/QDebug>

#include "fbhelper.h"

FBHelper *FBHelper::Instance = NULL;

@interface FBDelegate : NSObject<FBSDKGameRequestDialogDelegate>

- (id)init;
- (void)dealloc;
- (void)showGameRequestWithTitle:(NSString *)title withMessage:(NSString *)message;
- (void)logout;

@end

@implementation FBDelegate

- (id)init
{
    self = [super init];

    if (self) {
    }

    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)showGameRequestWithTitle:(NSString *)title withMessage:(NSString *)message
{
    if ([FBSDKAccessToken currentAccessToken] != nil) {
        FBSDKGameRequestContent *request_content = [[FBSDKGameRequestContent new] autorelease];

        request_content.filters = FBSDKGameRequestFilterAppNonUsers;
        request_content.title   = title;
        request_content.message = message;

        [FBSDKGameRequestDialog showWithContent:request_content delegate:self];
    } else {
        UIViewController * __block root_view_controller = nil;

        [[[UIApplication sharedApplication] windows] enumerateObjectsUsingBlock:^(UIWindow * _Nonnull window, NSUInteger, BOOL * _Nonnull stop) {
            root_view_controller = [window rootViewController];

            *stop = (root_view_controller != nil);
        }];

        FBSDKLoginManager *login_manager = [[FBSDKLoginManager alloc] init];

        [login_manager logInWithReadPermissions:@[] fromViewController:root_view_controller handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
            if (error != nil) {
                qWarning() << QString::fromNSString([error localizedDescription]);
            } else if (!result.isCancelled) {
                FBSDKGameRequestContent *request_content = [[FBSDKGameRequestContent new] autorelease];

                request_content.filters = FBSDKGameRequestFilterAppNonUsers;
                request_content.title   = title;
                request_content.message = message;

                [FBSDKGameRequestDialog showWithContent:request_content delegate:self];
            }

            [login_manager autorelease];
        }];
    }
}

- (void)logout
{
    FBSDKLoginManager *login_manager = [[FBSDKLoginManager alloc] init];

    [login_manager logOut];

    [login_manager release];
}

- (void)gameRequestDialog:(FBSDKGameRequestDialog *)gameRequestDialog didCompleteWithResults:(NSDictionary *)results
{
    Q_UNUSED(gameRequestDialog)

    if (results != nil && [results objectForKey:@"to"] != nil) {
        FBHelper::notifyGameRequestCompleted();
    }
}

- (void)gameRequestDialogDidCancel:(FBSDKGameRequestDialog *)gameRequestDialog
{
    Q_UNUSED(gameRequestDialog)
}

- (void)gameRequestDialog:(FBSDKGameRequestDialog *)gameRequestDialog didFailWithError:(NSError *)error
{
    Q_UNUSED(gameRequestDialog)

    qWarning() << QString::fromNSString([error localizedDescription]);
}

@end

FBHelper::FBHelper(QObject *parent) : QObject(parent)
{
    Initialized        = false;
    Instance           = this;
    FBDelegateInstance = NULL;
}

FBHelper::~FBHelper()
{
    if (Initialized) {
        [FBDelegateInstance release];
    }
}

void FBHelper::initialize()
{
    if (!Initialized) {
        FBDelegateInstance = [[FBDelegate alloc] init];

        Initialized = true;
    }
}

void FBHelper::showGameRequest(const QString &title, const QString &message)
{
    if (Initialized) {
        [FBDelegateInstance showGameRequestWithTitle:title.toNSString() withMessage:message.toNSString()];
    }
}

void FBHelper::logout()
{
    if (Initialized) {
        [FBDelegateInstance logout];
    }
}

void FBHelper::notifyGameRequestCompleted()
{
    emit Instance->gameRequestCompleted();
}

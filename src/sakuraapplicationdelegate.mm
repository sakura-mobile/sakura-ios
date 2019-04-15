#import <UIKit/UIKit.h>

#import <FBSDKCoreKit/FBSDKCoreKit.h>

#include <QtCore/QtGlobal>

#include "sakuraapplicationdelegate.h"

@interface QIOSApplicationDelegate : UIResponder<UIApplicationDelegate>
@end

@interface QIOSApplicationDelegate (QIOSApplicationDelegateSakuraCategory)
@end

@implementation QIOSApplicationDelegate (QIOSApplicationDelegateSakuraCategory)

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];

    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    Q_UNUSED(application)

    [FBSDKAppEvents activateApp];
}

@end

@interface SakuraApplicationDelegate : QIOSApplicationDelegate
@end

@implementation SakuraApplicationDelegate

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    if (@available(iOS 9, *)) {
        return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                          sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                                          annotation:options[UIApplicationOpenURLOptionsAnnotationKey]] ||
               [super application:application openURL:url options:options];
    } else {
        assert(0);
    }
}

@end

static SakuraApplicationDelegate *SakuraApplicationDelegateInstance = nil;

void InitializeSakuraApplicationDelegate()
{
    SakuraApplicationDelegateInstance = [[SakuraApplicationDelegate alloc] init];

    UIApplication.sharedApplication.delegate = SakuraApplicationDelegateInstance;
}

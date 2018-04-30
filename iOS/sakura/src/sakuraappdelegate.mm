#import <UIKit/UIKit.h>

#import <FBSDKCoreKit/FBSDKCoreKit.h>

#include <QtCore/QtGlobal>

@interface QIOSApplicationDelegate : UIResponder <UIApplicationDelegate>
@end

@interface QIOSApplicationDelegate (SakuraAppDelegate)
@end

@implementation QIOSApplicationDelegate (SakuraAppDelegate)

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

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                      openURL:url
                                                      sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                                      annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
}

@end

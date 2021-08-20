//
//  BEEAppDelegate.m
//  BEENavigationBar
//
//  Created by liuxc123 on 08/18/2021.
//  Copyright (c) 2021 liuxc123. All rights reserved.
//

#import "BEEAppDelegate.h"
#import "BEEViewController.h"
#import <BEENavigationBar/BEENavigationBarHeader.h>

@implementation BEEAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    // 初始化window

    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    window.backgroundColor = [UIColor whiteColor];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController: [BEEViewController new]];
    
    // config
    nav.navigation_configuration.isEnabled = YES;
    nav.navigation_configuration.barTintColor = UIColor.yellowColor;
    nav.navigation_configuration.tintColor = UIColor.whiteColor;
    nav.navigation_configuration.backItem = [[BEEBackItem alloc] initWithImage:[UIImage imageNamed:@"back"] tintColor:UIColor.blackColor];

    if (@available(iOS 11.0, *)) {
        nav.navigation_configuration.prefersLargeTitles = YES;
        nav.navigation_configuration.largeTitle.displayMode = UINavigationItemLargeTitleDisplayModeNever;
    }
    
    window.rootViewController = nav;
    [window makeKeyAndVisible];
    self.window = window;
    
    return YES;
}

@end

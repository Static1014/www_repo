//
//  AppDelegate.m
//  WWW
//
//  Created by XiongJian on 2014/05/28.
//  Copyright (c) 2014年 tci. All rights reserved.
//

#import "AppDelegate.h"
#import "OneViewController.h"
#import "ThreeViewController.h"
#import "MyUncaughtExceptionHandler.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]]autorelease];

    [MyUncaughtExceptionHandler setDefaultHandler];

    OneViewController *one = [[OneViewController alloc]initWithNibName:@"OneViewController" bundle:nil];
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:one];
    navc.navigationBar.translucent = NO;

    ThreeViewController *three = [[ThreeViewController alloc]initWithNibName:@"ThreeViewController" bundle:nil];

    UITabBarController *tabBar = [[UITabBarController alloc]init];
    tabBar.viewControllers = [NSArray arrayWithObjects:navc,three,nil];
    UITabBarItem *left = [[UITabBarItem alloc]initWithTitle:@"One" image:[UIImage imageNamed:@"item.png"] selectedImage:[UIImage imageNamed:@"item.png"]];
    UITabBarItem *right = [[UITabBarItem alloc]initWithTitle:@"three" image:[UIImage imageNamed:@"item.png"] selectedImage:[UIImage imageNamed:@"item.png"]];
    [tabBar.tabBar addSubview:left];
    [tabBar.tabBar addSubview:left];

    self.window.rootViewController = tabBar;
    [one release];
    [navc release];
    [three release];
    [tabBar release];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

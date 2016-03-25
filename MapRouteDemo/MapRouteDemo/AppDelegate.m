//
//  AppDelegate.m
//  MapRouteDemo
//
//  Created by Aigerim Yessenbayeva on 02/01/2014.
//  Copyright (c) 2014 Aigerim Yessenbayeva. All rights reserved.
//
#import "AppDelegate.h"

#import "ViewController.h"
#import "KMLViewerViewController.h"
#import "SaintFirstViewController.h"
#import "SaintSecondViewController.h"
#import "SaintThirdViewController.h"
#import "SaintDef.h"
#import <CoreLocation/CoreLocation.h>


@implementation AppDelegate
{
     id services_;
}
@synthesize window = _window;
@synthesize tabBarController = _tabBarController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [GMSServices provideAPIKey:@"AIzaSyAF1RozOoZBrNUIBDZrI351LA2X3sFu0wM"];
    services_ = [GMSServices sharedServices];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    [self observeNotify];
    
    
    //first item controller(MAP item on app)
    UIViewController *viewController1 = [[KMLViewerViewController alloc] initWithNibName:@"KMLViewerViewController" bundle:nil busnumber:0];
    
    //second item controller(BUS item on app)
    UIViewController *viewController2 = [[SaintFirstViewController alloc] initWithNibName:@"ZHUFirstViewController" bundle:nil];
    
    //third item controller(BUS STOP item on app)
    UIViewController *viewController3 = [[SaintSecondViewController alloc] initWithNibName:@"ZHUSecondViewController" bundle:nil];
    
     //fourth item controller(SETTINGS item on app)
    UIViewController *viewController4 = [[SaintThirdViewController alloc] initWithNibName:@"ZHUThirdViewController" bundle:nil];

    
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:viewController1];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:viewController2];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:viewController3];
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:viewController4];

// first itme navigaion bar
    nav1.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"MAP", @"Home")
                                                    image:[UIImage imageNamed:@"tb_home"]
                                                      tag:0];
    [nav1.tabBarItem setSelectedImg:[UIImage imageNamed:@"tb_home_highlighted"]];
    
    
 // second itme navigaion bar
    nav2.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"BUS", @"	")
                                                    image:[UIImage imageNamed:@"tb_favorites"]
                                                      tag:1];
    [nav2.tabBarItem setSelectedImg:[UIImage imageNamed:@"tb_favorites_highlighted"]];
    
    
    
  // third itme navigaion bar
    nav3.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"BUS STOP", @"Favorites")
                                                    image:[UIImage imageNamed:@"station_unprees"]
                                                      tag:1];
    [nav3.tabBarItem setSelectedImg:[UIImage imageNamed:@"station_press"]];
    
    
 // fourth itme navigaion bar      
    nav4.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"SETTINGS", @"Discover")
                                                    image:[UIImage imageNamed:@"setting_unpress"]
                                                      tag:1];
    [nav4.tabBarItem setSelectedImg:[UIImage imageNamed:@"setting_press"]];
    
    self.tabBarController = [[SaintTabBarViewController alloc] init];
    self.tabBarController.delegate = self;
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:nav1, nav2, nav3,nav4, nil];
    self.window.rootViewController = self.tabBarController;
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

- (void)observeNotify {
    
}

#pragma - UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSLog(@"did select viewController name %@", viewController.tabBarItem.title);
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if ([viewController.tabBarItem.title isEqualToString:NSLocalizedString(@"Favorites", @"Second")]) {
        NSLog(@"should not select ViewController %@", viewController.tabBarItem.title);
        return NO;
    }
    return YES;
}

@end

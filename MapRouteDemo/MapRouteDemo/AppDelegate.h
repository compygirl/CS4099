//
//  AppDelegate.h
//  MapRouteDemo
//
//  Created by Aigerim Yessenbayeva on 02/01/2014.
//  Copyright (c) 2014 Aigerim Yessenbayeva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SaintTabBarViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) SaintTabBarViewController *tabBarController;

@end

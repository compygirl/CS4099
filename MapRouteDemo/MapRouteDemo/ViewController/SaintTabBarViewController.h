//
//  SaintTabBarViewController.h
//  ViewController
//
//  Created by Aigerim Yessenbayeva on 02/01/2014.
//  Copyright (c) 2014 Aigerim Yessenbayeva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SaintTabBar.h"

@interface SaintTabBarViewController : UITabBarController <SaintTabBarDelegate, UITabBarControllerDelegate> {
    
}

@property (strong, nonatomic) SaintTabBar *customTabBar;
@property (assign, nonatomic) BOOL isHide;

- (void)hideTabbar:(BOOL)hide animated:(BOOL)animated;
- (void)setBadgeValueForController:(UIViewController *)ctl;
@end

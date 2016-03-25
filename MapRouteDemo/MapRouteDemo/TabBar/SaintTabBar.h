//
//  SaintTabBar.h
//  TabBar
//
//  Created by Aigerim Yessenbayeva on 21/12/2013.
//  Copyright (c) 2014 Aigerim Yessenbayeva. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SaintTabBarDelegate;

@interface SaintTabBar : UIView 
@property (strong, nonatomic) NSArray *tabItems;
@property (assign, nonatomic) NSInteger selectIndex;
@property (strong, nonatomic) UIImageView *indicatorView;
@property (weak, nonatomic) id<SaintTabBarDelegate> delegate;
- (id)initWithFrame:(CGRect)frame tabItems:(NSArray *)items;
- (void)moveIndicatorToIndex:(NSInteger)index animated:(BOOL)animated;
- (void)setBadgeValue:(NSString *)badgeValue atIndex:(NSInteger)index;
@end

@protocol SaintTabBarDelegate <NSObject>
@optional
- (void)tabBar:(SaintTabBar *)tabBar didSelectIndex:(NSInteger)index;
@end
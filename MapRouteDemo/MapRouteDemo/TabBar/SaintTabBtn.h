//
//  SaintTabBtn.h
//  TabBar
//
//  Created by Aigerim Yessenbayeva on 21/12/2013.
//  Copyright (c) 2014 Aigerim Yessenbayeva. All rights reserved.
//

@class SaintBadgeView;
#import <UIKit/UIKit.h>

@interface SaintTabBtn : UIButton

@property (nonatomic, strong) SaintBadgeView *badgeView;
- (void)setBadgeString:(NSString *)badgeValue;
@end

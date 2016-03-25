//
//  SaintAdditions.h
//  TabBar
//
//  Created by Aigerim Yessenbayeva on 21/12/2013.
//  Copyright (c) 2014 Aigerim Yessenbayeva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface UITabBarItem (additionalImage)
- (UIImage *)selectedImg;
- (void)setSelectedImg:(UIImage *)img;
@end

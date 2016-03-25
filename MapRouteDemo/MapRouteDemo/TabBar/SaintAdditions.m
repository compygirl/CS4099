//
//  SaintAdditions.m
//  TabBar
//
//  Created by Aigerim Yessenbayeva on 21/12/2013.
//  Copyright (c) 2014 Aigerim Yessenbayeva. All rights reserved.
//

static char SELECTIMG_KEY;
#import "SaintAdditions.h"

@implementation UITabBarItem (additionalImage)
- (void)setSelectedImg:(UIImage *)img
{
    objc_setAssociatedObject(self, &SELECTIMG_KEY, img, OBJC_ASSOCIATION_RETAIN_NONATOMIC);    
}

- (UIImage *)selectedImg
{
    UIImage *img = objc_getAssociatedObject(self, &SELECTIMG_KEY);
    return img;
}
@end

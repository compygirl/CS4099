//
//  SaintBadgeView.h
//  TabBar
//
//  Created by Aigerim Yessenbayeva on 21/12/2013.
//  Copyright (c) 2014 Aigerim Yessenbayeva. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SaintBadgeView : UIView {
    CGFloat _offsetToIcon;
}
@property (nonatomic, copy) NSString *badgeString;
@property (nonatomic, retain) UIColor *badgeTextColor;
@property (nonatomic, assign) BOOL isSelect;
@property (nonatomic, retain) UIColor *badgeFillColor;
@property (nonatomic, retain) UIColor *badgeSelectFillColor;
@property (nonatomic, retain) UIColor *badgeEdgeColor;
@property (nonatomic, assign) BOOL isShinning;
@property (nonatomic, assign) BOOL isEdge;
@property (nonatomic, assign) CGFloat defaultWidth;
- (id)initWithSuperView:(UIView *)superview;
@end

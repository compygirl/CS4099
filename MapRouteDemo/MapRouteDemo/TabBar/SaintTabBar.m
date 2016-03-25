//
//  SaintTabBar.m
//  TabBar
//
//  Created by Aigerim Yessenbayeva on 21/12/2013.
//  Copyright (c) 2014 Aigerim Yessenbayeva. All rights reserved.
//
#define kBaseTagNumber                      (322)
#define kDefaultTabBarAlpha                 (0.7)
#define kBarTextFont                        (12.0)
#import "SaintTabBar.h"
#import "SaintTabBtn.h"
#import "SaintDef.h"

@interface SaintTabBar ()
- (void)tabBarButtonClicked:(UIButton *)btn;
- (void)resestSelectedBar;
- (void)createTabBar;
@end

@implementation SaintTabBar
@synthesize selectIndex = _selectIndex;
@synthesize tabItems = _tabItems;
@synthesize indicatorView = _indicatorView;
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame tabItems:(NSArray *)items
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.tabItems = [items copy];
        [self createTabBar];
    }
    return self;
}
///
- (void)createTabBar 
{
    UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tb_background"]];
    bgView.alpha = kDefaultTabBarAlpha;
    [self addSubview:bgView];
    NSLog(@"tab item count %d", self.tabItems.count);
    CGFloat width = self.frame.size.width / self.tabItems.count;//decides the width of each button
    [self.tabItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UIViewController class]]) {
            UIViewController *viewCtl = obj;
            SaintTabBtn *btn = [[SaintTabBtn alloc] init];
            btn.backgroundColor = [UIColor clearColor];
            btn.exclusiveTouch = YES;//touch of the button happening here
            btn.tag = kBaseTagNumber + idx;
            //btn.showsTouchWhenHighlighted = YES;
            btn.frame = CGRectMake(width * idx, 0, width, self.frame.size.height);//frame of the button
            [btn setImage:viewCtl.tabBarItem.image forState:UIControlStateNormal];
            [btn setImage:[viewCtl.tabBarItem selectedImg] forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(tabBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            [btn setTitle:viewCtl.tabBarItem.title forState:UIControlStateNormal];//title for button
            btn.titleLabel.font = [UIFont systemFontOfSize:kBarTextFont];
            CGSize imageSize = btn.imageView.frame.size;//takes the size of the image
            // lower the text and push it left to center it
            btn.titleEdgeInsets = UIEdgeInsetsMake(0.0, -imageSize.width, -imageSize.height, 0.0);
            // the text width might have changed (in case it was shortened before due to 
            // lack of space and isn't anymore now), so we get the frame size again
            CGSize titleSize = btn.titleLabel.frame.size;
            // raise the image and push it right to center it
            btn.imageEdgeInsets = UIEdgeInsetsMake(-titleSize.height, 0.0, 0.0, -titleSize.width);

            [self addSubview:btn];
        }
    }];
    
    _selectIndex = NSIntegerMax;
    
    UIView *btnView = [self viewWithTag:kBaseTagNumber];
    UIImage *indicatorImg = [UIImage imageNamed:@"tb_arrow.png"];
    self.indicatorView = [[UIImageView alloc] initWithImage:indicatorImg];
    self.indicatorView.frame = CGRectMake((btnView.center.x - indicatorImg.size.width / 2), self.bounds.size.height - indicatorImg.size.height,
                                      indicatorImg.size.width, indicatorImg.size.height);
    [self addSubview:_indicatorView];

}
//set the value for the button
- (void)setBadgeValue:(NSString *)badgeValue atIndex:(NSInteger)index 
{
    SaintTabBtn *btn = (SaintTabBtn *)[self viewWithTag:index + kBaseTagNumber];
    [btn setBadgeString:badgeValue];
}


//detects which bustton was pressed by index
- (void)tabBarButtonClicked:(UIButton *)btn
{
    NSInteger index = btn.tag - kBaseTagNumber;
    self.selectIndex = index;
    if ((0 <= index) && _delegate && [_delegate respondsToSelector:@selector(tabBar:didSelectIndex:)]) {
        [_delegate tabBar:self didSelectIndex:_selectIndex];
    }
}

//index and animation together
- (void)moveIndicatorToIndex:(NSInteger)index animated:(BOOL)animated {
    self.selectIndex = index;
    [self resestSelectedBar];
    UIView *btnView = [self viewWithTag:kBaseTagNumber + self.selectIndex];
    if (animated) {
        [UIView animateWithDuration:0.01
                              delay:0 
                            options:UIViewAnimationOptionCurveEaseInOut 
                         animations:^{
                             self.indicatorView.center = CGPointMake(btnView.center.x, self.indicatorView.center.y);
                         } completion:^(BOOL finished) {
                             
                         }];
    }
    else {
        self.indicatorView.center = CGPointMake(btnView.center.x, self.indicatorView.center.y);
    }
}

- (void)resestSelectedBar
{
    for (int i = 0; i < self.tabItems.count; ++i) {
        UIButton *btnView = (UIButton *)[self viewWithTag:kBaseTagNumber + i];
        if (i == self.selectIndex) {
            btnView.selected = YES;
        }
        else {
            btnView.selected = NO;
        }
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

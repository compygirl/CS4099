//
//  SaintTabBtn.m
//  TabBar
//
//  Created by Aigerim Yessenbayeva on 21/12/2013.
//  Copyright (c) 2014 Aigerim Yessenbayeva. All rights reserved.
//

#import "SaintTabBtn.h"
#import "SaintBadgeView.h"

@implementation SaintTabBtn
@synthesize badgeView = _badgeView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
//make button selected
- (void)setSelected:(BOOL)selected 
{
    [super setSelected:selected];
    if (self.badgeView) {
        self.badgeView.isSelect = selected;
    }
}


- (SaintBadgeView *)badgeView
{
    if (!_badgeView) {
        _badgeView = [[SaintBadgeView alloc] initWithSuperView:self];
        [self addSubview:_badgeView];
    }
    return _badgeView;
}



- (void)setBadgeString:(NSString *)badgeValue {
    if (self.badgeView) {
        [self.badgeView setBadgeString:badgeValue];
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

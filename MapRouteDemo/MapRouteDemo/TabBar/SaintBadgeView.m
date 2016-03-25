//
//  SaintBadgeView.m
//  TabBar
//
//  Created by Aigerim Yessenbayeva on 21/12/2013.
//  Copyright (c) 2014 Aigerim Yessenbayeva. All rights reserved.
//
#define kOffset                         (0.15)
#define kOffsetTop                      (8.0 / 2)
#define kOffsetIcon                     (2.0)
#define kBadgeWidth                     (34.0 / 2)
#define kBadgeHeight                    (34.0 / 2)
#define kRadius                         (0.4)
#define kBadgeFont                      (11.0)
#define kMaxBadgeNum                    (800)

#import "SaintBadgeView.h"
@interface SaintBadgeView ()
- (void)drawFillContext:(CGContextRef)context rect:(CGRect)arect;//
- (void)drawEdgeContext:(CGContextRef)context rect:(CGRect)arect;//
- (void)drawShinningContext:(CGContextRef)context rect:(CGRect)arect;//
- (void)layoutBadge;
@end

@implementation SaintBadgeView
@synthesize badgeString = _badgeString;
@synthesize isSelect = _isSelect;
@synthesize badgeTextColor = _badgeTextColor;
@synthesize badgeFillColor = _badgeFillColor;
@synthesize badgeSelectFillColor = _badgeSelectFillColor;
@synthesize badgeEdgeColor = _badgeEdgeColor;
@synthesize isShinning = _isShinning;
@synthesize isEdge = _isEdge;
@synthesize defaultWidth = _defaultWidth;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithSuperView:(UIView *)superview
{
    _offsetToIcon = CGRectGetMidX(superview.bounds);
    if (self = [super initWithFrame:CGRectMake(_offsetToIcon - kOffsetIcon, kOffsetTop, kBadgeWidth, kBadgeHeight)]) {
        self.badgeTextColor = [UIColor blackColor];
        self.backgroundColor = [UIColor clearColor];
        _defaultWidth = kBadgeWidth;
        self.badgeFillColor = [UIColor lightGrayColor];
        self.badgeSelectFillColor = wwRgbColor(61.0, 176.0, 239.0);
        self.badgeEdgeColor = [UIColor blackColor];
        self.isShinning = YES;
        self.isEdge = YES;
    }
    return self;
}
//checks the size of badge
- (void)layoutBadge 
{
	CGFloat rectWidth;
	CGSize stringSize = [_badgeString sizeWithFont:[UIFont systemFontOfSize:kBadgeFont]];
    rectWidth = _defaultWidth / 2 + stringSize.width;

	self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, rectWidth, self.bounds.size.height);
    [self setNeedsDisplay];
}


- (void)setBadgeString:(NSString *)badgeString
{
    if (badgeString && ![_badgeString isEqualToString:badgeString]) {
        _badgeString = [badgeString copy];
        [self layoutBadge];
    }
}

//checking whether button pressed
- (void)setIsSelect:(BOOL)isSelect
{
    if (_isSelect != isSelect) {
        _isSelect = isSelect;
        [self layoutBadge];
    }
}
//filling the button, drawing
- (void)drawFillContext:(CGContextRef)context rect:(CGRect)rect
{
    CGContextSaveGState(context);
    
	CGFloat offset = MIN(CGRectGetMaxY(rect), CGRectGetMaxX(rect)) * kOffset;
	CGFloat maxX = CGRectGetMaxX(rect) - offset;
	CGFloat maxY = CGRectGetMaxY(rect) - offset;
	CGFloat minX = CGRectGetMinX(rect) + offset;
	CGFloat minY = CGRectGetMinY(rect) + offset;
    
    CGFloat radius = MIN(maxX, maxY) * kRadius;
    
    CGContextBeginPath(context);
    UIColor *fillColor = nil;
    if (_isSelect) {
        fillColor = _badgeSelectFillColor;
    }
    else {
        fillColor = _badgeFillColor;
    }
	CGContextSetFillColorWithColor(context, [fillColor CGColor]);
	CGContextAddArc(context, maxX - radius, minY + radius, radius, M_PI + (M_PI / 2), 0, 0);
	CGContextAddArc(context, maxX - radius, maxY - radius, radius, 0, M_PI / 2, 0);
	CGContextAddArc(context, minX + radius, maxY - radius, radius, M_PI / 2, M_PI, 0);
	CGContextAddArc(context, minX + radius, minY + radius, radius, M_PI, M_PI + M_PI / 2, 0);
    
    //	CGContextSetShadowWithColor(context, CGSizeMake(0.0, 0.0), 3, [[UIColor blackColor] CGColor]);
    CGContextFillPath(context);
	CGContextRestoreGState(context);
}

- (void)drawEdgeContext:(CGContextRef)context rect:(CGRect)rect
{
    CGContextSaveGState(context);
	CGFloat offset = MIN(CGRectGetMaxY(rect), CGRectGetMaxX(rect)) * kOffset;
	CGFloat maxX = CGRectGetMaxX(rect) - offset;
	CGFloat maxY = CGRectGetMaxY(rect) - offset;
	CGFloat minX = CGRectGetMinX(rect) + offset;
	CGFloat minY = CGRectGetMinY(rect) + offset;
    
    CGFloat radius = MIN(maxX, maxY) * kRadius;
    
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, 1.0);
	CGContextSetStrokeColorWithColor(context, [_badgeEdgeColor CGColor]);
	CGContextAddArc(context, maxX - radius, minY + radius, radius, M_PI + (M_PI / 2), 0, 0);
	CGContextAddArc(context, maxX - radius, maxY - radius, radius, 0, M_PI / 2, 0);
	CGContextAddArc(context, minX + radius, maxY - radius, radius, M_PI / 2, M_PI, 0);
	CGContextAddArc(context, minX + radius, minY + radius, radius, M_PI, M_PI + M_PI / 2, 0);
    //	CGContextSetShadowWithColor(context, CGSizeMake(0.0, 0.0), 3, [[UIColor blackColor] CGColor]);
    CGContextClosePath(context);
    CGContextStrokePath(context);
	CGContextRestoreGState(context);
}

- (void)drawShinningContext:(CGContextRef)context rect:(CGRect)rect
{
    CGContextSaveGState(context);
	CGFloat offset = MIN(CGRectGetMaxY(rect), CGRectGetMaxX(rect)) * kOffset;
	CGFloat maxX = CGRectGetMaxX(rect) - offset;
	CGFloat maxY = CGRectGetMaxY(rect) - offset;
	CGFloat minX = CGRectGetMinX(rect) + offset;
	CGFloat minY = CGRectGetMinY(rect) + offset;
    
    CGFloat radius = MIN(maxX, maxY) * kRadius;
    
    CGContextBeginPath(context);
	CGContextAddArc(context, maxX - radius, minY + radius, radius, M_PI + (M_PI / 2), 0, 0);
	CGContextAddArc(context, maxX - radius, maxY - radius, radius, 0, M_PI / 2, 0);
	CGContextAddArc(context, minX + radius, maxY - radius, radius, M_PI / 2, M_PI, 0);
	CGContextAddArc(context, minX + radius, minY + radius, radius, M_PI, M_PI + M_PI / 2, 0);
    CGContextClip(context);
	size_t num_locations = 2;
	CGFloat locations[2] = {0.0, 0.5};
	CGFloat components[8] = {0.92, 0.92, 0.92, 1.0, 0.82, 0.82, 0.82, 0.1};
    
	CGColorSpaceRef cspace;
	CGGradientRef gradient;
	cspace = CGColorSpaceCreateDeviceRGB();
	gradient = CGGradientCreateWithColorComponents(cspace, components, locations, num_locations);
	
	CGPoint sPoint, ePoint;
	sPoint.x = 0;
	sPoint.y = 0;
	ePoint.x = 0;
	ePoint.y = CGRectGetMaxY(rect);
	CGContextDrawLinearGradient(context, gradient, sPoint, ePoint, 0);
	
	CGColorSpaceRelease(cspace);
	CGGradientRelease(gradient);
	
	CGContextRestoreGState(context);
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect 
{
    // Drawing code
    if (!_badgeString || 0 == [_badgeString intValue]) {
        return;
    }

    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawFillContext:context rect:rect];
    if (_isEdge) {
        [self drawEdgeContext:context rect:rect];
    }
    
    if (_isShinning) {
        [self drawShinningContext:context rect:rect];
    }

    if (_badgeString.length) {
        NSString *drawText = nil;
        if (kMaxBadgeNum < [_badgeString intValue]) {
            drawText = [NSString stringWithString:@"N"];
        }
        else {
            drawText = _badgeString;
        }
        
        [_badgeTextColor set];
        UIFont *textFont = [UIFont systemFontOfSize:kBadgeFont];
		CGSize textSize = [drawText sizeWithFont:textFont];
		[drawText drawAtPoint:CGPointMake(rect.size.width / 2 - textSize.width / 2 + 0.5,
                                          (rect.size.height / 2 - textSize.height / 2))
                     withFont:textFont];
    }
}

@end

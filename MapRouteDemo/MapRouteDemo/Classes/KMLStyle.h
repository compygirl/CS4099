#import "KMLElement.h"

@class MKOverlayPathView;

// Represents a KML <Style> element.  <Style> elements may either be specified
// at the top level of the KML document with identifiers or they may be
// specified anonymously within a Geometry element.
@interface KMLStyle : KMLElement {
@private
	UIColor *strokeColor;
	CGFloat strokeWidth;
	UIColor *fillColor;

	BOOL fill;
	BOOL stroke;

	struct {
		int inLineStyle:1;
		int inPolyStyle:1;
		
		int inColor:1;
		int inWidth:1;
		int inFill:1;
		int inOutline:1;
	} flags;
}

- (void) beginLineStyle;
- (void) endLineStyle;

- (void) beginPolyStyle;
- (void) endPolyStyle;

- (void) beginColor;
- (void) endColor;

- (void) beginWidth;
- (void) endWidth;

- (void) beginFill;
- (void) endFill;

- (void) beginOutline;
- (void) endOutline;

- (void) applyToOverlayPathView:(MKOverlayPathView *) view;
@end

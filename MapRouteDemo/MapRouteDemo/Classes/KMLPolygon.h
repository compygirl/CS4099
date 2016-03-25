#import "KMLGeometry.h"

// A KMLPolygon element corresponds to an MKPolygon and MKPolygonView
@interface KMLPolygon : KMLGeometry {
@private
	NSString *outerRing;
	NSMutableArray *innerRings;
	
	struct {
		int inOuterBoundary:1;
		int inInnerBoundary:1;
		int inLinearRing:1;
	} polyFlags;
}

- (void) beginOuterBoundary;
- (void) endOuterBoundary;

- (void) beginInnerBoundary;
- (void) endInnerBoundary;

- (void) beginLinearRing;
- (void) endLinearRing;
@end

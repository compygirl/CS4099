#import "KMLElement.h"

@class MKShape;
@class MKOverlayPathView;

@interface KMLGeometry : KMLElement {
@protected
	struct {
		int inCoords:1;
	} flags;
}

@property (nonatomic, readonly) struct flags;

- (void) beginCoordinates;
- (void) endCoordinates;

// Create (if necessary) and return the corresponding Map Kit MKShape object
// corresponding to this KML Geometry node.
- (MKShape *) mapkitShape;

// Create (if necessary) and return the corresponding MKOverlayPathView for
// the MKShape object.
- (MKOverlayPathView *) createOverlayView:(MKShape *) shape;
@end

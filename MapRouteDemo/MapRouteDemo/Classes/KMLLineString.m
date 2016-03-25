#import "KMLLineString.h"

#import "KMLUtilities.h"

@implementation KMLLineString
@synthesize points;
@synthesize length;

- (void) dealloc {
	free(points);
}

- (void) endCoordinates {
	flags.inCoords = NO;

	free(points);

	strToCoords(self.accumulated, &points, &length);

	[self clearString];
}

- (MKShape *) mapkitShape {
	return [MKPolyline polylineWithCoordinates:points count:length];
}

- (MKOverlayPathView *) createOverlayView:(MKShape *) shape {
	return [[MKPolylineView alloc] initWithPolyline:(MKPolyline *)shape];
}
@end

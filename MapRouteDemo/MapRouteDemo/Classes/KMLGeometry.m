#import "KMLGeometry.h"

@implementation KMLGeometry
- (BOOL) canAddString {
	return flags.inCoords;
}

- (void) beginCoordinates {
	flags.inCoords = YES;
}

- (void) endCoordinates {
	flags.inCoords = NO;
}

- (MKShape *) mapkitShape {
	return nil;
}

- (MKOverlayPathView *) createOverlayView:(MKShape *) shape {
	return nil;
}
@end

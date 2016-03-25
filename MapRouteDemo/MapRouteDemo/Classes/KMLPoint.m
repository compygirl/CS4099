#import "KMLPoint.h"

#import "KMLUtilities.h"

@implementation KMLPoint
@synthesize point;

- (void) endCoordinates {
	flags.inCoords = NO;

	CLLocationCoordinate2D *points = NULL;
	NSUInteger len = 0;

	strToCoords(self.accumulated, &points, &len);
	if (len == 1)
		point = points[0];

	free(points);

	[self clearString];
}

- (MKShape *) mapkitShape {
	MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
	annotation.coordinate = point;

	return annotation;
}
@end

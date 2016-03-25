#import "KMLPlacemark.h"

#import "KMLLineString.h"
#import "KMLPoint.h"
#import "KMLPolygon.h"
#import "KMLStyle.h"

#import "KMLUtilities.h"

@implementation KMLPlacemark
@synthesize style;
@synthesize styleUrl;
@synthesize geometry;
@synthesize name;
@synthesize placemarkDescription;

- (BOOL) canAddString {
	return flags.inName || flags.inStyleUrl || flags.inDescription;
}

- (void) addString:(NSString *) str {
	if (flags.inStyle)
		[style addString:str];
	else if (flags.inGeometry)
		[geometry addString:str];
	else [super addString:str];
}

- (void) beginName {
	flags.inName = YES;
}

- (void) endName {
	flags.inName = NO;

	name = [self.accumulated copy];

	[self clearString];
}

- (void) beginDescription {
	flags.inDescription = YES;
}

- (void) endDescription {
	flags.inDescription = NO;

	placemarkDescription = [self.accumulated copy];

	[self clearString];
}

- (void) beginStyleUrl {
	flags.inStyleUrl = YES;
}

- (void) endStyleUrl {
	flags.inStyleUrl = NO;

	styleUrl = [self.accumulated copy];

	[self clearString];
}

- (void) beginStyleWithIdentifier:(NSString *) ident {
	flags.inStyle = YES;

	style = [[KMLStyle alloc] initWithIdentifier:ident];
}

- (void) endStyle {
	flags.inStyle = NO;
}

- (void) beginGeometryOfType:(NSString *) elementName withIdentifier:(NSString *) ident {
	flags.inGeometry = YES;

	if (ELTYPE(Point))
		geometry = [[KMLPoint alloc] initWithIdentifier:ident];
	else if (ELTYPE(Polygon))
		geometry = [[KMLPolygon alloc] initWithIdentifier:ident];
	else if (ELTYPE(LineString))
		geometry = [[KMLLineString alloc] initWithIdentifier:ident];
}

- (void) endGeometry {
	flags.inGeometry = NO;
}

- (KMLGeometry *) geometry {
	return geometry;
}

- (KMLPolygon *) polygon {
	return [geometry isKindOfClass:[KMLPolygon class]] ? (id)geometry : nil;
}

- (void) _createShape {
	if (!mkShape) {
		mkShape = [geometry mapkitShape];
		mkShape.title = name;

		// Skip setting the subtitle for now because they're frequently
		// too verbose for viewing on in a callout in most kml files.
		// mkShape.subtitle = placemarkDescription;
	}
}

- (id <MKOverlay>) overlay {
	[self _createShape];
	
	if ([mkShape conformsToProtocol:@protocol(MKOverlay)])
		return (id <MKOverlay>)mkShape;
	
	return nil;
}

- (id <MKAnnotation>) point {
	[self _createShape];
	
	// Make sure to check if this is an MKPointAnnotation.  MKOverlays also
	// conform to MKAnnotation, so it isn't sufficient to just check to
	// conformance to MKAnnotation.
	if ([mkShape isKindOfClass:[MKPointAnnotation class]])
		return (id <MKAnnotation>)mkShape;
	
	return nil;
}

- (MKOverlayView *) overlayView {
	if (!overlayView) {
		id <MKOverlay> overlay = [self overlay];
		if (overlay) {
			overlayView = [geometry createOverlayView:overlay];
			[style applyToOverlayPathView:overlayView];
		}
	}

	return overlayView;
}

- (MKAnnotationView *) annotationView {
	if (!annotationView) {
		id <MKAnnotation> annotation = [self point];
		if (annotation) {
			MKPinAnnotationView *pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];
			pin.canShowCallout = YES;
			pin.animatesDrop = YES;
			annotationView = pin;
		}
	}

	return annotationView;
}
@end

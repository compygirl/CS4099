#import "KMLParser.h"

#import "KMLGeometry.h"
#import "KMLPlacemark.h"
#import "KMLPolygon.h"
#import "KMLStyle.h"

#import "KMLUtilities.h"

@implementation KMLParser
// After parsing has completed, this method loops over all placemarks that have
// been parsed and looks up their corresponding KMLStyle objects according to
// the placemark's styleUrl property and the global KMLStyle object's identifier.
- (void) _assignStyles {
	for (KMLPlacemark *placemark in _placemarks) {
		if (!placemark.style && placemark.styleUrl) {
			NSString *styleUrl = placemark.styleUrl;
			NSRange range = [styleUrl rangeOfString:@"#"];
			if (range.length == 1 && range.location == 0) {
				NSString *styleID = [styleUrl substringFromIndex:1];
				KMLStyle *style = [_styles objectForKey:styleID];
				placemark.style = style;
			}
		}
	}
}

- (id) initWithURL:(NSURL *) url {
	if ((self = [super init])) {
		_styles = [[NSMutableDictionary alloc] init];
		_placemarks = [[NSMutableArray alloc] init];
		_xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:url];

		[_xmlParser setDelegate:self];
	}

	return self;
}

#pragma mark -

- (void) parseKML {
	[_xmlParser parse];

	[self _assignStyles];
}

#pragma mark -

// Return the list of KMLPlacemarks from the object graph that contain overlays (as opposed to simply point annotations).
- (NSArray *) overlays {
	NSMutableArray *overlays = [[NSMutableArray alloc] init];

	for (KMLPlacemark *placemark in _placemarks) {
		id <MKOverlay> overlay = [placemark overlay];
		if (overlay)
			[overlays addObject:overlay];
	}

	return overlays;
}

// Return the list of KMLPlacemarks from the object graph that are simply MKPointAnnotations, and are not MKOverlays.
- (NSArray *) points {
	NSMutableArray *points = [[NSMutableArray alloc] init];

	for (KMLPlacemark *placemark in _placemarks) {
		id <MKAnnotation> point = [placemark point];
		if (point)
			[points addObject:point];
	}

	return points;
}

- (NSArray *) coordinates {
	NSMutableArray *points = [[NSMutableArray alloc] init];
    
	for (KMLPlacemark *placemark in _placemarks) {
		id <MKAnnotation> point = [placemark point];
		if (point)
			[points addObject:point];
	}
    
	return points;
}


#pragma mark -

- (MKAnnotationView *) viewForAnnotation:(id <MKAnnotation>) point {
	// Find the KMLPlacemark object that owns this point and get the view from it.
	for (KMLPlacemark *placemark in _placemarks) {
		if ([placemark point] == point)
			return [placemark annotationView];
	}

	return nil;
}

- (MKOverlayView *) viewForOverlay:(id <MKOverlay>) overlay {
	// Find the KMLPlacemark object that owns this overlay and get the view from it.
	for (KMLPlacemark *placemark in _placemarks) {
		if ([placemark overlay] == overlay)
			return [placemark overlayView];
	}

	return nil;
}

#pragma mark -

- (void) parser:(NSXMLParser *) parser didStartElement:(NSString *) elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *) qName attributes:(NSDictionary *) attributeDict {
	NSString *ident = [attributeDict objectForKey:@"id"];
	KMLStyle *style = [_placemark style] ? [_placemark style] : _style;

	// Style and sub-elements
	if (ELTYPE(Style)) {
		if (_placemark) {
			[_placemark beginStyleWithIdentifier:ident];
		} else if (ident != nil) {
			_style = [[KMLStyle alloc] initWithIdentifier:ident];
		}
	} else if (ELTYPE(PolyStyle)) {
		[style beginPolyStyle];
	} else if (ELTYPE(LineStyle)) {
		[style beginLineStyle];
	} else if (ELTYPE(color)) {
		[style beginColor];
	} else if (ELTYPE(width)) {
		[style beginWidth];
	} else if (ELTYPE(fill)) {
		[style beginFill];
	} else if (ELTYPE(outline)) {
		[style beginOutline];
	}
	// Placemark and sub-elements
	else if (ELTYPE(Placemark)) {
		_placemark = [[KMLPlacemark alloc] initWithIdentifier:ident];
	} else if (ELTYPE(Name)) {
		[_placemark beginName];
	} else if (ELTYPE(Description)) {
		[_placemark beginDescription];
	} else if (ELTYPE(styleUrl)) {
		[_placemark beginStyleUrl];
	} else if (ELTYPE(Polygon) || ELTYPE(Point) || ELTYPE(LineString)) {
		[_placemark beginGeometryOfType:elementName withIdentifier:ident];
	}
	// Geometry sub-elements
	else if (ELTYPE(coordinates)) {
		[_placemark.geometry beginCoordinates];
	} 
	// Polygon sub-elements
	else if (ELTYPE(outerBoundaryIs)) {
		[_placemark.polygon beginOuterBoundary];
	} else if (ELTYPE(innerBoundaryIs)) {
		[_placemark.polygon beginInnerBoundary];
	} else if (ELTYPE(LinearRing)) {
		[_placemark.polygon beginLinearRing];
	}
}

- (void) parser:(NSXMLParser *) parser didEndElement:(NSString *) elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *) qName {
	KMLStyle *style = [_placemark style] ? [_placemark style] : _style;
		// Style and sub-elements
	if (ELTYPE(Style)) {
		if (_placemark) {
			[_placemark endStyle];
		} else if (_style) {
			[_styles setObject:_style forKey:_style.identifier];
			_style = nil;
		}
	} else if (ELTYPE(PolyStyle)) {
		[style endPolyStyle];
	} else if (ELTYPE(LineStyle)) {
		[style endLineStyle];
	} else if (ELTYPE(color)) {
		[style endColor];
	} else if (ELTYPE(width)) {
		[style endWidth];
	} else if (ELTYPE(fill)) {
		[style endFill];
	} else if (ELTYPE(outline)) {
		[style endOutline];
	}
	// Placemark and sub-elements
	else if (ELTYPE(Placemark)) {
		if (_placemark) {
			[_placemarks addObject:_placemark];
			_placemark = nil;
		}
	} else if (ELTYPE(Name)) {
		[_placemark endName];
	} else if (ELTYPE(Description)) {
		[_placemark endDescription];
	} else if (ELTYPE(styleUrl)) {
		[_placemark endStyleUrl];
	} else if (ELTYPE(Polygon) || ELTYPE(Point) || ELTYPE(LineString)) {
		[_placemark endGeometry];
	}
	// Geometry sub-elements
	else if (ELTYPE(coordinates)) {
		[_placemark.geometry endCoordinates];
	} 
	// Polygon sub-elements
	else if (ELTYPE(outerBoundaryIs)) {
		[_placemark.polygon endOuterBoundary];
	} else if (ELTYPE(innerBoundaryIs)) {
		[_placemark.polygon endInnerBoundary];
	} else if (ELTYPE(LinearRing)) {
		[_placemark.polygon endLinearRing];
	}
}

- (void) parser:(NSXMLParser *) parser foundCharacters:(NSString *) string {
	KMLElement *element = _placemark ? (KMLElement *)_placemark : (KMLElement *)_style;

	[element addString:string];
}
@end

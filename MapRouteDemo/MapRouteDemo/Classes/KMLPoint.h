#import "KMLGeometry.h"

// A KMLPoint element corresponds to an MKAnnotation and MKPinAnnotationView
@interface KMLPoint : KMLGeometry {
@private
	CLLocationCoordinate2D point;
}

@property (nonatomic, readonly) CLLocationCoordinate2D point;
@end

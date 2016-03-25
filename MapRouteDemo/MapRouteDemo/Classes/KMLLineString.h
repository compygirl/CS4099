#import "KMLGeometry.h"
#import <CoreLocation/CoreLocation.h>

@interface KMLLineString : KMLGeometry {
@private
    CLLocationCoordinate2D *points;
    NSUInteger length;
}

@property (nonatomic, readonly) CLLocationCoordinate2D *points;
@property (nonatomic, readonly) NSUInteger length;
@end

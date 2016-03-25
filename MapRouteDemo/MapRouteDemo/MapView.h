
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "RegexKitLite.h"
#import "Place.h"
#import "PlaceMark.h"

@interface MapView : UIView<MKMapViewDelegate> {

	MKMapView* mapView;
	UIImageView* routeView;
	
	NSArray* routes;
	
//	UIColor* lineColor;

}

//@property (nonatomic, retain) UIColor* lineColor;
@property (nonatomic, retain) MKMapView* map_View;

-(void) showRouteFrom: (Place*) f to:(Place*) t;


@end

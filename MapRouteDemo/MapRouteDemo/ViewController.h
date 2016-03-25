#import <UIKit/UIKit.h>
#import "MapView.h"
#import "Place.h"
#import <CoreLocation/CoreLocation.h>
#import "SaintViewController.h"
@interface ViewController : SaintViewController<CLLocationManagerDelegate>
{
    MapView* mapView;
    Place *home;
    Place* office;
    CLLocationManager *locmanager;
    

}
@property (strong, nonatomic) Place* office;
@property (strong, nonatomic) Place *home;
@property (strong, nonatomic)  UITextField *fromText;
- (void)userCurrentLocation;
@end

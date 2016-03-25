//
//  ViewController.h
//  MapBackgroud
//
//  Created by Aigerim Yessenbayeva on 02/02/2014.
//  Copyright (c) 2014 Aigerim Yessenbayeva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController<CLLocationManagerDelegate>
{
    NSTimer *gpstimer;
    float lati_value;;
    float long_value;
    BOOL check_start;
}
//Interface
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, retain) IBOutlet UITextField *longitidude;
@property (nonatomic, retain) IBOutlet UITextField *latidude;
@property (nonatomic, retain) IBOutlet UIButton *start_btn;
- (IBAction)startgps:(id)sender;

@end

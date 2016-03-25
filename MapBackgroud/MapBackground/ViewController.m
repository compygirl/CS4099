//
//  ViewController.m
//  MapBackgroud
//
//  Created by Aigerim Yessenbayeva on 02/02/2014.
//  Copyright (c) 2014 Aigerim Yessenbayeva. All rights reserved.


#import "ViewController.h"

@interface ViewController ()

@end


@implementation ViewController
#define request_url @"http://www.saintbus.com/gpsupload.php?lat=%f&lng=%f"

- (void)viewDidLoad
{
    [super viewDidLoad];
    check_start = YES;
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    self.locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
   	// Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startgps:(id)sender
{
//    if(check_start)
//    {
      // [self timerstart];
     check_start = !check_start;
//[_start_btn setTitle:@"Stop" forState:UIControlStateNormal];
    [self enabledStateChanged];
    _start_btn.enabled = NO;
    
//    }
//    else
//    {
//        check_start = !check_start;
//        [self timerstop];
//        _start_btn.titleLabel.text = @"Start";
//    }
}

- (void)timerstart
{
    gpstimer = [NSTimer scheduledTimerWithTimeInterval: 3.0
                                                target: self
                                              selector:@selector(enabledStateChanged)
                                              userInfo: nil repeats:YES];
}

/*
 *This method updates the coordinates (i.e. latitude and longitude) of the location of the "GPS App"
 */
- (void)enabledStateChanged
{
     [self.locationManager startUpdatingLocation];
}

/*
 *This method updates the coordinates (i.e. latitude and longitude) of the "GPS App"
 */
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    int degrees = newLocation.coordinate.latitude;
    lati_value = newLocation.coordinate.latitude;
    double decimal = fabs(newLocation.coordinate.latitude - degrees);
    int minutes = decimal * 60;
    double seconds = decimal * 3600 - minutes * 60;
    NSString *lat = [NSString stringWithFormat:@"%d° %d' %1.4f\"",
                     degrees, minutes, seconds];
    degrees = newLocation.coordinate.longitude;
    long_value = newLocation.coordinate.longitude;
    decimal = fabs(newLocation.coordinate.longitude - degrees);
    minutes = decimal * 60;
    seconds = decimal * 3600 - minutes * 60;
    NSString *longt = [NSString stringWithFormat:@"%d° %d' %1.4f\"",
                       degrees, minutes, seconds];
    _longitidude.text = longt;
    _latidude.text = lat;
    [self request_send];
    
}

/*
 *This method sends gps data to the server/API
 */
- (void)request_send
{
    NSString *gpsdata_url = [NSString stringWithFormat :request_url, lati_value,long_value];
    NSLog(@"test=%@", gpsdata_url);
     NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
     [request setURL:[NSURL URLWithString:gpsdata_url]];
    NSURLResponse *response;
    NSError *error;
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSMutableString *reponseServeur = [[NSMutableString alloc]initWithData:data encoding:NSASCIIStringEncoding];
    NSLog(@"data=%@", reponseServeur);
   [self enabledStateChanged];
}


- (void)timerstop{
    
    [gpstimer invalidate];
    gpstimer = nil;
}


@end

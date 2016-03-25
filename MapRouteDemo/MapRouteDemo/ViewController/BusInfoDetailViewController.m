//
//  BusInfoDetailViewController.m
//  ViewController
//
//  Created by Aigerim Yessenbayeva on 16/01/2014.
//  Copyright (c) 2014 Aigerim Yessenbayeva. All rights reserved.
//

#import "BusInfoDetailViewController.h"
#import <GoogleMaps/GoogleMaps.h>
@interface BusInfoDetailViewController ()

@end

@implementation BusInfoDetailViewController
@synthesize mapview;

//initialisation
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil lat:(NSString*)latstring lng:(NSString*)lngstring title:(NSString*)titlestring{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        latidude = latstring;
        longtidude = lngstring;
        station_name = titlestring;
        NSLog(@"contents: %@", latidude);
        NSLog(@"contents: %@", longtidude);
        NSLog(@"contents: %@", station_name);
        self.title = station_name;


    }
    return self;
}

//Information about bus stops: names, coordinates: lat., long.
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    NSString *locat = [NSString stringWithFormat:@"lat=%@:lng=%@", latidude, longtidude];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:[latidude floatValue]
                                                            longitude:[longtidude floatValue]
                                                                 zoom:17];
    self.mapview = [GMSMapView mapWithFrame:CGRectZero camera:camera];

    //
    UIColor *color = [UIColor redColor];
    CLLocationCoordinate2D option = CLLocationCoordinate2DMake([latidude floatValue], [longtidude floatValue]);
    GMSMarker *maker = [GMSMarker markerWithPosition:option];
    maker.title = @"St Andrews";
    maker.snippet = station_name;
    maker.icon = [GMSMarker markerImageWithColor:color];
    maker.map = mapview;
    self.view = self.mapview;

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

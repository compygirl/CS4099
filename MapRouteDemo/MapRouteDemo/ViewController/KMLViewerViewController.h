//
//  KMLViewerViewController.h
//  ViewController
//
//  Created by Aigerim Yessenbayeva on 23/12/2013.
//  Copyright (c) 2014 Aigerim Yessenbayeva. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MyAnnotation.h"
#import "KMLParser.h"
#import "GPXTrack.h"
#import "GPXTrackpoint.h"
#import "GPXTrackSegment.h"
#import "MBProgressHUD.h"

@interface KMLViewerViewController : UIViewController<GMSMapViewDelegate,NSXMLParserDelegate, MBProgressHUDDelegate>{
    MKMapView *map;
    KMLParser *kmlParser;
    CLLocationManager *locmanager;
    int bus_select;

 //bus station info
    CLLocationCoordinate2D  coordinate;
    NSString*               title;
    int numbre_list;
    NSArray *listArraybus;         //bus station name array
    NSArray *listArraylong;         //bus station longgitidue array
    NSArray *listArraylati;         //bus station latidude array
    NSMutableArray *annotations;
    MyAnnotation* myAnnotation;
    BOOL check_value;
    NSUserDefaults *userDefault;    //variable for api
    int count_num;             
    NSTimer *request_timer;
    float bus_lat_gps;              //latidude variable from server
    float bus_lng_gps;               //longitidude variable from server
    GMSMarker *maker;
     NSTimer *second_timer;        //loading for gpx parse
    NSMutableArray *makeres;
    
}

@property (nonatomic, retain) GMSMapView *mapview;    //Google MapView
@property (nonatomic, strong) NSMutableArray *gpxs;    //gpx parse data

@property (nonatomic, strong)  GMSMutablePath *path_route;   //selected bus route info
@property (nonatomic, strong)  GMSPolyline *polyline;        //draw points for route

@property (nonatomic, strong) NSURL*            gpxURL;     //gpx file path
@property (nonatomic, strong) NSInputStream*    inputStream;  //variable to Input gpx data
@property (nonatomic, strong) NSXMLParser*      gpxParser;    //gpx parser
@property (nonatomic, strong) NSMutableArray*   tracks;
@property (nonatomic, retain) MBProgressHUD *HUD;          // loaing variable

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil busnumber:(int)number;
- (void)didTapMyLocation;     //current user location on app

@end


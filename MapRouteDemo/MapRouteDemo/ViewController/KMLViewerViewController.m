//
//  KMLViewerViewController.h
//  ViewController
//
//  Created by Aigerim Yessenbayeva on 23/12/2013.
//  Copyright (c) 2014 Aigerim Yessenbayeva. All rights reserved.
//
#import "KMLViewerViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "MBProgressHUD.h"
static CGFloat randf() {
    return (((float)arc4random()/0x100000000)*1.0f);
}
@implementation KMLViewerViewController
{
    GPXTrack*           _currentTrack;
    GPXTrackpoint*      _currentTrackpoint;
    GPXTrackSegment*    _currentSegment;
    
    NSString*           _currentElementName;
    NSDateFormatter*    _dateFormatter;
}
@synthesize mapview;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil busnumber:(int)number
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        switch (number) {//TOP BAR: TITLES OF THE PAGE:
            case 1:
                self.title = NSLocalizedString(@"99A LIST", @"99A LIST");
                break;
            case 2:
                self.title = NSLocalizedString(@"99B LIST", @"99B LIST");
                break;
                
            case 3:
                self.title = NSLocalizedString(@"99C LIST", @"99C LIST");
                break;
                
            case 4:
                self.title = NSLocalizedString(@"99D LIST", @"99D LIST");
                break;
                
            default:;
                self.title = NSLocalizedString(@"TOWN MAP", @"TOWN MAP");
                break;
        }
        
        bus_select = number;
    }
    return self;
}

/*
 *THIS METHOD IMPLEMENTS THE VIEW OF THE MAP
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    check_value = TRUE;
  
    // setting to display google map
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:56.3387100
                                                            longitude:-2.7990200
                                                                 zoom:13];
    self.mapview = [GMSMapView mapWithFrame:CGRectZero camera:camera];
   
    [mapview setMyLocationEnabled:YES];//blue dot enabled
    
    UIImage *image = [UIImage imageNamed:@"location.png"];//interface of the button for finding the blue dot position
    UIButton *myCustomButton = [UIButton buttonWithType:UIButtonTypeCustom];
     myCustomButton.bounds = CGRectMake( 0, 0, image.size.width, image.size.height );
    [myCustomButton setImage:image forState:UIControlStateNormal];
    
    [myCustomButton addTarget:self action:@selector(didTapMyLocation) forControlEvents:UIControlEventTouchUpInside];//functionality of the button "myCastomButton"
    
    
    UIBarButtonItem *myLocationButton = [[UIBarButtonItem alloc] initWithCustomView:myCustomButton];
    
    
    self.navigationItem.rightBarButtonItem = myLocationButton;
    
    
    
    NSString *path, *dirPath;
    //check first iterm or second item
    if(bus_select!=0)   //if second item/button "BUS"
    {
        
        makeres = [[NSMutableArray alloc]init];
        
        NSString *filepathbus, *filepathbuslong, *filepathlati;
//BUS ROUTES
        //Select BUS Route for displaying on the MAP
        switch (bus_select) {
            case 1:
                path = [[NSBundle mainBundle] pathForResource:@"99A" ofType:@"kml"];//KML files used here
                filepathbus = [[NSBundle mainBundle] pathForResource:@"busA_stop_list" ofType:@"txt"];
                filepathbuslong = [[NSBundle mainBundle] pathForResource:@"busA_longitude" ofType:@"txt"];
                filepathlati = [[NSBundle mainBundle] pathForResource:@"busA_latitude" ofType:@"txt"];
                 dirPath = [[NSBundle mainBundle] pathForResource:@"z41znlp7f_99Aroute" ofType:@"gpx"];//converted data
                break;
            case 2:
                path = [[NSBundle mainBundle] pathForResource:@"99B" ofType:@"kml"];
                filepathbus = [[NSBundle mainBundle] pathForResource:@"busB_stop_list" ofType:@"txt"];
                filepathbuslong = [[NSBundle mainBundle] pathForResource:@"busB_longitude" ofType:@"txt"];
                filepathlati = [[NSBundle mainBundle] pathForResource:@"busB_latitude" ofType:@"txt"];
                dirPath = [[NSBundle mainBundle] pathForResource:@"4zexme71o_99b" ofType:@"gpx"];
                break;
                
            case 3:
                path = [[NSBundle mainBundle] pathForResource:@"99Croute" ofType:@"kml"];
                filepathbus = [[NSBundle mainBundle] pathForResource:@"busC_stop_list" ofType:@"txt"];
                filepathbuslong = [[NSBundle mainBundle] pathForResource:@"busC_longitude" ofType:@"txt"];
                filepathlati = [[NSBundle mainBundle] pathForResource:@"busC_latitude" ofType:@"txt"];
                dirPath = [[NSBundle mainBundle] pathForResource:@"9v0s36snt_99c" ofType:@"gpx"];

                break;
            case 4:
                path = [[NSBundle mainBundle] pathForResource:@"99Droute" ofType:@"kml"];
                filepathbus = [[NSBundle mainBundle] pathForResource:@"busD_stop_list" ofType:@"txt"];
                filepathbuslong = [[NSBundle mainBundle] pathForResource:@"busD_longitude" ofType:@"txt"];
                filepathlati = [[NSBundle mainBundle] pathForResource:@"busD_latitude" ofType:@"txt"];
                 dirPath = [[NSBundle mainBundle] pathForResource:@"5s704usxm_99d" ofType:@"gpx"];
                break;
                
            default:
                break;
        }
        
         //LOADING...
        _HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        _HUD.delegate = self;
        [_HUD setLabelFont:[UIFont systemFontOfSize:12]];
        [_HUD setLabelText:@"Loading..."];

        
        NSError *error;
        NSString *fileContentsbus = [NSString stringWithContentsOfFile:filepathbus encoding:NSUTF8StringEncoding error:&error];
        NSString *fileContentslong = [NSString stringWithContentsOfFile:filepathbuslong encoding:NSUTF8StringEncoding error:&error];
        NSString *fileContentslati = [NSString stringWithContentsOfFile:filepathlati encoding:NSUTF8StringEncoding error:&error];
        
        if (error)
            NSLog(@"Error reading file: %@", error.localizedDescription);
        
        //  for debugging...
        NSLog(@"contents1: %@", fileContentsbus);
        
        // Read selected route info: bus stops' names, their longitudes and latitudes
        listArraybus = [fileContentsbus componentsSeparatedByString:@"\n"];
        listArraylong = [fileContentslong componentsSeparatedByString:@"\n"];
        listArraylati = [fileContentslati componentsSeparatedByString:@"\n"];
        
        NSLog(@"items = %d", [listArraybus count]);
        NSLog(@"items = %d", [listArraylong count]);
        NSLog(@"items = %d", [listArraylati count]);
        numbre_list = [listArraybus count];
        int i = 0;
        
//BUS STOPS are represented by green points on the map with route
        while(i<numbre_list)        {
            //self.view = mapView_;
            NSString *lat = [listArraylong objectAtIndex:i];
            NSString *lon = [listArraylati objectAtIndex:i];
            double lt=[lat doubleValue];
            double ln=[lon doubleValue];
            UIColor *color = [UIColor greenColor];
//            [UIColor colorWithHue:randf() saturation:1.f brightness:1.f alpha:1.0f];
            
            NSString *name = [listArraybus objectAtIndex:i];//names of bus stops for particular route
            NSLog(@"%@ and %@ and %f and %f of %@",lat,lon, ln,lt,name);
            
            // Draw green points for bus stops
            GMSMarker *marker = [[GMSMarker alloc] init];
            marker.title = name;
            marker.snippet = @"Saint Andrews";
            marker.position = CLLocationCoordinate2DMake(ln,lt);
            marker.icon = [GMSMarker markerImageWithColor:color];//green
            marker.map = mapview;
            [makeres addObject:marker];//mutable array, means resizeable array
            
            i++;
        }
        
        mapview.delegate = self;
       _path_route = [GMSMutablePath path];
        NSLog(@"path%@", _path_route);
        count_num = 0;
        
       
        NSLog(@"path%@", dirPath);
        NSURL *gpxURL =[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@", dirPath]];
        self.gpxURL = gpxURL;
        
        
        // Parse gpx file for selected route
        dispatch_async(EAIGetBGQueue, ^{
            self.inputStream = [[NSInputStream alloc] initWithURL:self.gpxURL];
            [self.inputStream open];
            self.gpxParser = [[NSXMLParser alloc] initWithStream:self.inputStream];
            self.gpxParser.delegate = self;
            [self.gpxParser parse];
        });
       
       
       second_timer = [NSTimer scheduledTimerWithTimeInterval: 0.1
                                                         target: self
                                                       selector:@selector(startloading)//loading for GPX param
                                                       userInfo: nil repeats:YES];
      }
    else  // first item/button
    {   //Default view of the map, pointing to St Andrews
        UIColor *color =
        [UIColor colorWithHue:randf() saturation:1.f brightness:1.f alpha:1.0f];
        CLLocationCoordinate2D option = CLLocationCoordinate2DMake(56.3387100, -2.7990200);
        maker = [GMSMarker markerWithPosition:option];
        maker.title = @"United Kingdom";
        maker.snippet = @"St Andrews";
        maker.icon = [GMSMarker markerImageWithColor:color];
        maker.map = mapview;
        self.view = self.mapview;
      
    }
    userDefault = [NSUserDefaults standardUserDefaults];
    if ([userDefault boolForKey:@"gps_locat"] == YES) {
       request_timer = [NSTimer scheduledTimerWithTimeInterval: 2.0
                                                         target: self
                                                       selector:@selector(onTickk:)
                                                       userInfo: nil repeats:YES];
        
    }
   
   
}

/*
 * THIS METHOD DRAWS THE ROUTE AND POSITION OF THE REDPOINT (BUS)
 */
-(IBAction)onTickk:(NSTimer *)timer
{
    //data from server:
    bus_lat_gps = [userDefault floatForKey:@"lat"];
    bus_lng_gps = [userDefault floatForKey:@"lng"];
    
    
    //draw point of the route, polylines
    UIColor *color = [UIColor redColor];
    [self.mapview clear];
    self.polyline.path = _path_route;
    _polyline.strokeColor = [UIColor redColor];
    _polyline.strokeWidth = 3.3f;
    _polyline.zIndex = 15;  // above the larger geodesic line
    _polyline.map = self.mapview;
    

    [CATransaction begin];
    [CATransaction setAnimationDuration:1.0];
    
    //position of the bus
    CLLocationCoordinate2D option = CLLocationCoordinate2DMake(bus_lat_gps, bus_lng_gps);
    maker = [GMSMarker markerWithPosition:option];
    maker.icon = [GMSMarker markerImageWithColor:color];
    maker.position = option;
    [CATransaction commit];

    maker.map = mapview;
    for(int i =0;i<[makeres count]; i++)//iterates through all stops
    {
        maker= [makeres objectAtIndex:i];
        maker.map = mapview;
    }
    
  
   
}


- (void)timerstop{
    
    [request_timer invalidate];
    request_timer = nil;
}

/*
 *Called when the view is dismissed, covered or otherwise hidden.
 */
- (void)viewWillDisappear:(BOOL)animated
{
   [super viewWillDisappear:animated];
    [self timerstop];

}


- (void) startloading
{
    if(!check_value) {
         [_HUD hide:YES];
        _polyline = [[GMSPolyline alloc] init];
        self.polyline.path = _path_route;
        _polyline.strokeColor = [UIColor redColor];
        _polyline.strokeWidth = 3.3f;
        _polyline.zIndex = 15;  // above the larger geodesic line
        _polyline.map = self.mapview;
        self.view = self.mapview;
    
        [second_timer invalidate];
        second_timer = nil;
    }

}




#pragma mark NSXMLParserDelegate

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    //
    // ending a new track
    if ([elementName isEqualToString:@"trk"]) {
        [self.tracks addObject:_currentTrack];
        _currentTrack = nil;
    }
    //
    // ending a new name
    else if ([elementName isEqualToString:@"name"]) {
        
    }
    //
    // ending a new segment
    else if ([elementName isEqualToString:@"trkseg"]) {
        [_currentTrack addTrackSegment:_currentSegment];
        _currentSegment = nil;
    }
    //
    // ending a new trackpoint
    else if ([elementName isEqualToString:@"trkpt"]) {
        [_currentSegment addTrackpoint:_currentTrackpoint];
        NSLog(@"%@", _currentTrackpoint);
        _currentTrackpoint = nil;
    }
    
    _currentElementName = nil;
}




-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    //
    // starting a new track
    if ([elementName isEqualToString:@"trk"]) {
        _currentTrack = [[GPXTrack alloc] init];
    }
    //
    // starting a new name
    else if ([elementName isEqualToString:@"name"]) {
        
    }
    //
    // starting a new segment
    else if ([elementName isEqualToString:@"trkseg"]) {
        _currentSegment = [[GPXTrackSegment alloc] init];
    }
    //
    // starting a new trackpoint
    else if ([elementName isEqualToString:@"trkpt"]) {
        _currentTrackpoint = [[GPXTrackpoint alloc] init];
        double lat = [attributeDict[@"lat"] doubleValue];
        double lng = [attributeDict[@"lon"] doubleValue];
        _currentTrackpoint.latitude = lat;
        _currentTrackpoint.longitude = lng;
        CLLocationCoordinate2D kSydneyAustralia = {lat, lng};
        [_path_route addCoordinate:kSydneyAustralia];
        NSLog(@"%@", _currentTrackpoint);
        NSLog(@"%f", _currentTrackpoint.latitude);
        NSLog(@"%f", _currentTrackpoint.longitude);
        count_num++;


    }
    else if ([elementName isEqualToString:@"ele"]) {
        // not needed
    }
    else if ([elementName isEqualToString:@"time"]) {
        // not needed
    }
    
    _currentElementName = elementName;
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if ([_currentElementName isEqualToString:@"ele"]) {
        _currentTrackpoint.elevation = [string doubleValue];
    }
    else if ([_currentElementName isEqualToString:@"time"]) {
        
        _currentTrackpoint.time = [_dateFormatter dateFromString:string];
    }
    else if ([_currentElementName isEqualToString:@"name"]) {
        _currentTrack.name = string;
    }
}

//  ...and this reports a fatal error to the delegate. The parser will stop parsing.
-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"Parser Error: %@", parseError);
}

// Called when the view has been fully transitioned onto the screen.
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
  
}

// sent when the parser has completed parsing. If this is encountered, the parse was successful.
-(void)parserDidEndDocument:(NSXMLParser *)parser {
    [self.inputStream close];
    
    check_value = FALSE;
   
}

/*
 * THIS METHOD DEALS WITH DETECTION OF CURRENT POSITION OF THE PHONE: BLUE DOT
 * Button for finding the current position of the blue dot
 */
- (void)didTapMyLocation {
    mapview.myLocationEnabled = YES;
    CLLocation *location = mapview.myLocation; // BLUE DOT POSITION ON THE MAP, i.e. current position of the user
    if (!location || !CLLocationCoordinate2DIsValid(location.coordinate)) {
        return;
    }
    
    mapview.layer.cameraLatitude = location.coordinate.latitude;
    mapview.layer.cameraLongitude = location.coordinate.longitude;
    mapview.layer.cameraBearing = 0.0;
    
    // Access the GMSMapLayer directly to modify the following properties with a
    // specified timing function and duration.
    
    CAMediaTimingFunction *curve =
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    CABasicAnimation *animation;
    
    animation = [CABasicAnimation animationWithKeyPath:kGMSLayerCameraLatitudeKey];
    animation.duration = 2.0f;
    animation.timingFunction = curve;
    animation.toValue = @(location.coordinate.latitude);
    [mapview.layer addAnimation:animation forKey:kGMSLayerCameraLatitudeKey];
    
    animation = [CABasicAnimation animationWithKeyPath:kGMSLayerCameraLongitudeKey];
    animation.duration = 2.0f;
    animation.timingFunction = curve;
    animation.toValue = @(location.coordinate.longitude);
    [mapview.layer addAnimation:animation forKey:kGMSLayerCameraLongitudeKey];
    
    animation = [CABasicAnimation animationWithKeyPath:kGMSLayerCameraBearingKey];
    animation.duration = 2.0f;
    animation.timingFunction = curve;
    animation.toValue = @(0.0);
    [mapview.layer addAnimation:animation forKey:kGMSLayerCameraBearingKey];
    
    // Fly out to the minimum zoom and then zoom back to the current zoom!
    CGFloat zoom = mapview.camera.zoom;
    NSArray *keyValues = @[@(zoom), @(kGMSMinZoomLevel), @(zoom)];
    CAKeyframeAnimation *keyFrameAnimation =
    [CAKeyframeAnimation animationWithKeyPath:kGMSLayerCameraZoomLevelKey];
    keyFrameAnimation.duration = 2.0f;
    keyFrameAnimation.values = keyValues;
    [mapview.layer addAnimation:keyFrameAnimation forKey:kGMSLayerCameraZoomLevelKey];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

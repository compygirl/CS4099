#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize home,office;
@synthesize fromText;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"TOWN MAP", @"TOWN MAP");
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *button2 =  [UIButton buttonWithType:UIButtonTypeCustom];
	[button2 setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
	[button2 setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateHighlighted];
	[button2 addTarget:self action:@selector(userCurrentLocation) forControlEvents:UIControlEventTouchUpInside];
	[button2 setFrame:CGRectMake(0, 0, 40, 40)];
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button2];

    CGRect bound_size = [[UIScreen mainScreen]bounds];
    if(bound_size.size.height == 480)
        mapView = [[MapView alloc] initWithFrame:
               CGRectMake(0, 20, self.view.frame.size.width,460-45)] ;
    else
        mapView = [[MapView alloc] initWithFrame:
                   CGRectMake(0, 20, self.view.frame.size.width,548-45)] ;
	[self.view addSubview:mapView];
	
    CLLocationCoordinate2D coord = {.latitude =  56.3404, .longitude =  15.4699};
    
    MKCoordinateSpan span = {.latitudeDelta =  0.3, .longitudeDelta =  0.3};
    MKCoordinateRegion region = {coord, span};
    [mapView.mapView setRegion:region];
       
//	home = [[Place alloc] init] ;
//	home.name = @"Home";
//	home.description = @"Sweet home";
//	home.latitude = 37.78583400;
//	home.longitude = -122.40641700;
//	
//	office = [[Place alloc] init] ;
//	office.name = @"Office";
//	office.description = @"Bad office";
//	office.latitude = 37.7858340;
//	office.longitude = -121.4064170;
//	[mapView showRouteFrom:home to:office];
//    
//    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAct:)];
//    longPress.minimumPressDuration = 1;
//    [mapView addGestureRecognizer:longPress];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == fromText) {
        [self search:nil];
    }
    return YES;
}

- (void)longPressAct:(UILongPressGestureRecognizer*)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        NSLog(@"longlonglonglonglong");
        CGPoint touchPoint = [recognizer locationInView:mapView.mapView];
        CLLocationCoordinate2D coordinate = [mapView.mapView convertPoint:touchPoint toCoordinateFromView:mapView.mapView];
        office.longitude = coordinate.longitude;
        office.latitude = coordinate.latitude;
        [mapView showRouteFrom:home to:office];
    }
}

- (IBAction)search:(id)sender
{
    [fromText resignFirstResponder];
    
    NSString *urlStr = [[NSString stringWithFormat:@"http://maps.apple.com/maps/geo?q=%@&output=csv",fromText.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *apiResponse = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlStr] encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"%@",apiResponse);
    if (apiResponse.length != 0) {
        NSArray *array = [apiResponse componentsSeparatedByString:@","];
        NSLog(@"%@",array);
        office.latitude = [[array objectAtIndex:2] floatValue];
        office.longitude = [[array objectAtIndex:3] floatValue];
        [mapView showRouteFrom:home to:office];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"Can not find the route, please check the input or network connection." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)userCurrentLocation{
    locmanager = [[CLLocationManager alloc] init];
    [locmanager setDelegate:self];
    [locmanager setDesiredAccuracy:kCLLocationAccuracyBest];
    [locmanager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    CLLocationCoordinate2D loc = [newLocation coordinate];
    
    NSString *latitude = [NSString stringWithFormat: @"%f", loc.latitude];//获取纬度
    NSString *longitude = [NSString stringWithFormat: @"%f", loc.longitude];//获取经度
    
    NSLog(@"%@,%@",latitude,longitude);
    
    office = [[Place alloc] init] ;
	office.name = @"Office";
	office.description = @"Bad office";
	office.latitude = loc.latitude;
	office.longitude = loc.longitude;
	[mapView showRouteFrom:home to:office];
}


@end

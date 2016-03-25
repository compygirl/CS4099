//
//  SaintThirdViewController.m
//  ViewController
//
//  Created by Aigerim Yessenbayeva on 02/01/2014.
//  Copyright (c) 2014 Aigerim Yessenbayeva. All rights reserved.
//

#import "SaintThirdViewController.h"

@interface SaintThirdViewController ()

@end
#define request_url @"http://www.saintbus.com/gpsdownload.php"
@implementation SaintThirdViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title =@"Settings";//title text
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.segmentedControl addTarget:self
                              action:@selector(segmentSwitch:)//how often should update: in 5 or 10 , or 30 sec
                    forControlEvents:UIControlEventValueChanged];
    int select  = self.segmentedControl.selectedSegmentIndex;
    
     userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:YES forKey:@"gps_locat"];
    switch (select) {
        case 0:
            [self timerstop];
             request_time = 5;
            [self timerstart];
            break;
        case 1:
            [self timerstop];
            request_time = 10;
            [self timerstart];
            break;
        case 2:
            [self timerstop];
            request_time = 30;
            [self timerstart];
            break;
        case 3:
            [self timerstop];
            
            break;
        default:
            break;
    }

    // Do any additional setup after loading the view from its nib.
}


//Implementation of the requests to the API
-(IBAction) onTick:(NSTimer *)timer {
    
     NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    [request setURL:[NSURL URLWithString:request_url]];

     NSURLResponse *response;
     NSError *error;
    //_gpsarray conatains coordinates of the positions, obtained from API
     NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
     _gpsarray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
     NSLog(@"data=%@", _gpsarray);
    gps_longidude = [_gpsarray valueForKey:@"lng"];
    gps_latidude = [_gpsarray valueForKey:@"lat"];
    
    
    [userDefaults setInteger:request_time forKey:@"count"];
    [userDefaults setFloat:[gps_latidude floatValue] forKey:@"lat"];
    [userDefaults setFloat:[gps_longidude floatValue] forKey:@"lng"];
    
    [userDefaults synchronize];
    NSString *mylocation= [NSString stringWithFormat:@"lat:%@  lng:%@",gps_latidude, gps_longidude];//curent position of the bus, coming from API
    
//For debugging and tetsting:
   // UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"title" message:mylocation delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
   // [alert show];
    

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)segmentSwitch:(UISegmentedControl *)control
{
    NSInteger selectedSegment = control.selectedSegmentIndex;
    switch (selectedSegment) {
        case 0:
            [self timerstop];
            request_time = 5;
             [self timerstart];
             break;
        case 1:
            [self timerstop];
            request_time = 10;
             [self timerstart];
            break;
        case 2:
            [self timerstop];
            request_time = 30;
             [self timerstart];
            break;
        case 3:
            [self timerstop];
            
            break;
        default:
            break;
    }
}

- (void)timerstop{
    
    [request_timer invalidate];
     request_timer = nil;
}

- (void)timerstart
{
    request_timer = [NSTimer scheduledTimerWithTimeInterval: request_time
                                                     target: self
                                                   selector:@selector(onTick:)
                                                   userInfo: nil repeats:YES];
}
@end

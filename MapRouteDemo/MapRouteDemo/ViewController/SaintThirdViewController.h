//
//  SaintThirdViewController.h
//  ViewController
//
//  Created by Aigerim Yessenbayeva on 02/01/2014.
//  Copyright (c) 2014 Aigerim Yessenbayeva. All rights reserved.
//


#import "SaintViewController.h"
@interface SaintThirdViewController : SaintViewController
{
    int request_time;
    NSTimer *request_timer;
    NSString *gps_longidude;
    NSString *gps_latidude;
    NSUserDefaults *userDefaults ;
}
@property (strong,nonatomic) NSArray *gpsarray;
@property (nonatomic, retain) IBOutlet UISegmentedControl *segmentedControl;
- (void)segmentSwitch:(UISegmentedControl *)control;
@end

//
//  GPXTrackpoint.m
//  strava-gpx-parser
//
//  Created by Eric Ito on 11/8/13.
//  Copyright (c) 2013 Eric Ito. All rights reserved.
//

#import "GPXTrackpoint.h"

@implementation GPXTrackpoint {
    CLLocation *_location;
}

- (CLLocation*)location {
    if (!_location) {
        _location = [[CLLocation alloc] initWithCoordinate:CLLocationCoordinate2DMake(self.latitude, self.longitude)
                                                  altitude:self.elevation
                                        horizontalAccuracy:0
                                          verticalAccuracy:0
                                                    course:0
                                                     speed:0
                                                 timestamp:self.time];
    }
    return _location;
}
@end

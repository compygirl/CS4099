//
//  GPXTrackpoint.h
//  strava-gpx-parser
//
//  Created by Eric Ito on 11/8/13.
//  Copyright (c) 2013 Eric Ito. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface GPXTrackpoint : NSObject

//
// returns a CLLocation object representing this point
@property (nonatomic, strong, readonly) CLLocation *location;

//
// the latitude of the trackpoint
@property (nonatomic, assign) double latitude;

//
// the longitude of the trackpoint
@property (nonatomic, assign) double longitude;

//
// the elevation of the trackpoint
@property (nonatomic, assign) double elevation;

//
// the time the trackpoint was collected
@property (nonatomic, strong) NSDate *time;

@end

//
//  GPXTrack.h
//  strava-gpx-parser
//
//  Created by Eric Ito on 11/8/13.
//  Copyright (c) 2013 Eric Ito. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GPXTrackSegment;

@interface GPXTrack : NSObject

//
// name of the ride
@property (nonatomic, copy) NSString* name;

//
// array of GPXTrackSegment objects
@property (nonatomic, copy, readonly) NSArray* segments;

//
// total length, in meters, of the track
@property (nonatomic, assign, readonly) double length;

//
// total gain, in meters
@property (nonatomic, assign, readonly) double elevationGain;

-(void)addTrackSegment:(GPXTrackSegment*)trkseg;
@end

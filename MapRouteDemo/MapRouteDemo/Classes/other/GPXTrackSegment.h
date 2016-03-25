//
//  GPXTrackSegment.h
//  strava-gpx-parser
//
//  Created by Eric Ito on 11/8/13.
//  Copyright (c) 2013 Eric Ito. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GPXTrackpoint;

@interface GPXTrackSegment : NSObject

//
// The total length, in meters, of this segment
@property (nonatomic, assign, readonly) double length;

//
// The total elevation gain, in meters, of this segment
@property (nonatomic, assign, readonly) double elevationGain;

//
// array of GPXTrackpoint objects
@property (nonatomic, copy) NSArray *trackpoints;

- (void)addTrackpoint:(GPXTrackpoint*)trackpoint;

@end

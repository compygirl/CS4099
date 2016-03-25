//
//  GPXTrackSegment.m
//  strava-gpx-parser
//
//  Created by Eric Ito on 11/8/13.
//  Copyright (c) 2013 Eric Ito. All rights reserved.
//

#import "GPXTrackSegment.h"
#import "GPXTrackpoint.h"

@implementation GPXTrackSegment {
    NSMutableArray* _trackpoints;
    double _length;
    double _elevationGain;
}

-(id)init {
    self = [super init];
    if (self) {
        _trackpoints = [@[] mutableCopy];
    }
    return self;
}

-(void)addTrackpoint:(GPXTrackpoint *)trackpoint {
    [_trackpoints addObject:trackpoint];
    if (_trackpoints.count > 1) {
        //
        // get the last trackpoint, it's -2 because -1 is the trackpoint we just added
        GPXTrackpoint *last = _trackpoints[_trackpoints.count - 2];
        
        //
        // figure out distance from last point
        _length += [last.location distanceFromLocation:trackpoint.location];
        
        //
        // figure out if we climbed at all since last point
        double climb = trackpoint.elevation - last.elevation;
        if (climb > 0) {
            _elevationGain += climb;
        }
    }
}

-(NSArray *)trackpoints {
    return _trackpoints;
}

- (double)length {
    return _length;
}

- (double)elevationGain {
    return _elevationGain;
}

@end

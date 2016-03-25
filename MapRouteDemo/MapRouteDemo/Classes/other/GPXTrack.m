//
//  GPXTrack.m
//  strava-gpx-parser
//
//  Created by Eric Ito on 11/8/13.
//  Copyright (c) 2013 Eric Ito. All rights reserved.
//

#import "GPXTrack.h"
#import "GPXTrackSegment.h"

@implementation GPXTrack {
    NSMutableArray* _segments;
    double _length;
    double _elevationGain;
}

-(id)init {
    self = [super init];
    if (self) {
        _segments = [@[] mutableCopy];
    }
    return self;
}

-(void)addTrackSegment:(GPXTrackSegment *)trkseg {
    [_segments addObject:trkseg];
    _length += trkseg.length;
    _elevationGain += trkseg.elevationGain;
}

- (NSArray*)segments {
    return _segments;
}

- (double)length {
    return _length;
}

- (double)elevationGain {
    return _elevationGain;
}

@end

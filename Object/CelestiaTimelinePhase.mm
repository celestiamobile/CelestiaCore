//
// CelestiaTimelinePhase.m
//
// Copyright © 2023 Celestia Development Team. All rights reserved.
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//

#include <cmath>
#import "CelestiaUtil.h"
#import "CelestiaTimelinePhase+Private.h"

@interface CelestiaTimelinePhase () {
    TimelinePhase::SharedConstPtr p;
}
@end

@implementation CelestiaTimelinePhase

- (NSDate *)startTime {
    double startTime = p->startTime();
    if (std::isinf(startTime))
        return nil;
    return [NSDate dateWithJulian:startTime];
}

- (NSDate *)endTime {
    double endTime = p->endTime();
    if (std::isinf(endTime))
        return nil;
    return [NSDate dateWithJulian:endTime];
}

@end

@implementation CelestiaTimelinePhase (Private)

- (instancetype)initWithTimelinePhase:(const TimelinePhase::SharedConstPtr&)timelinePhase {
    self = [super init];
    if (self) {
        p = timelinePhase;
    }
    return self;
}

@end

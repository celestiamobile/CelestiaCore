//
// CelestiaTimeline.m
//
// Copyright © 2023 Celestia Development Team. All rights reserved.
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//

#import "CelestiaTimeline+Private.h"
#import "CelestiaTimelinePhase+Private.h"

@interface CelestiaTimeline () {
    const Timeline *t;
}

@end

@implementation CelestiaTimeline

- (NSInteger)phaseCount {
    return (NSInteger)t->phaseCount();
}

- (CelestiaTimelinePhase *)phaseAtIndex:(NSInteger)index {
    return [[CelestiaTimelinePhase alloc] initWithTimelinePhase:t->getPhase(static_cast<unsigned int>(index))];
}

@end

@implementation CelestiaTimeline (Private)

- (instancetype)initWithTimeline:(const Timeline *)timeline {
    self = [super init];
    if (self) {
        t = timeline;
    }
    return self;
}

@end

//
//  CelestiaOrbit.mm
//  CelestiaCore
//
//  Created by Li Linfeng on 14/8/2019.
//  Copyright © 2019 李林峰. All rights reserved.
//

#import "CelestiaOrbit+Private.h"
#import "CelestiaVector+Private.h"
#import "CelestiaUtil.h"

@interface CelestiaOrbit () {
    const Orbit *o;
}

@end

@implementation CelestiaOrbit (Private)

- (instancetype)initWithOrbit:(const Orbit *)orbit {
    self = [super init];
    if (self) {
        o = orbit;
    }
    return self;
}

- (const Orbit *)orbit {
    return o;
}

@end

@implementation CelestiaOrbit

- (double)boundingRadius {
    return o->getBoundingRadius();
}

- (BOOL)isPeriodic {
    return (BOOL)o->isPeriodic();
}

- (NSTimeInterval)period {
    return o->getPeriod();
}

- (double)validBeginTime {
    double beginTime = 0.0;
    double endTime = 0.0;
    o->getValidRange(beginTime, endTime);
    return beginTime;
}

- (double)validEndTime {
    double beginTime = 0.0;
    double endTime = 0.0;
    o->getValidRange(beginTime, endTime);
    return endTime;
}

- (CelestiaVector *)positionAtTime:(NSDate *)time {
    return [CelestiaVector vectorWithVector3d:o->positionAtTime([time julianDay])];
}

- (CelestiaVector *)velocityAtTime:(NSDate *)time {
    return [CelestiaVector vectorWithVector3d:o->velocityAtTime([time julianDay])];
}

@end

//
//  CelestiaRotationModel.mm
//  CelestiaCore
//
//  Created by Li Linfeng on 14/8/2019.
//  Copyright © 2019 李林峰. All rights reserved.
//

#import "CelestiaRotationModel+Private.h"
#import "CelestiaVector+Private.h"
#import "CelestiaUtil.h"

@interface CelestiaRotationModel () {
    const RotationModel *r;
}

@end

@implementation CelestiaRotationModel (Private)

- (instancetype)initWithRotation:(const RotationModel *)rotation {
    self = [super init];
    if (self) {
        r = rotation;
    }
    return self;
}

- (const RotationModel *)rotation {
    return r;
}

@end

@implementation CelestiaRotationModel

- (BOOL)isPeriodic {
    return (BOOL)r->isPeriodic();
}

- (NSTimeInterval)period {
    return r->getPeriod();
}

- (double)validBeginTime {
    double beginTime = 0.0;
    double endTime = 0.0;
    r->getValidRange(beginTime, endTime);
    return beginTime;
}

- (double)validEndTime {
    double beginTime = 0.0;
    double endTime = 0.0;
    r->getValidRange(beginTime, endTime);
    return endTime;
}

- (CelestiaVector *)angularVelocityAtTime:(NSDate *)time {
    return [CelestiaVector vectorWithVector3d:r->angularVelocityAtTime([time julianDay])];
}

- (CelestiaVector *)equatorOrientationAtTime:(NSDate *)time {
    return [CelestiaVector vectorWithQuaterniond:r->equatorOrientationAtTime([time julianDay])];
}

- (CelestiaVector *)spinAtTime:(NSDate *)time {
    return [CelestiaVector vectorWithQuaterniond:r->spin([time julianDay])];
}

@end

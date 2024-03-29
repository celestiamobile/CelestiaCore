//
// CelestiaRotationModel.h
//
// Copyright © 2020 Celestia Development Team. All rights reserved.
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//

#import <Foundation/Foundation.h>

@class CelestiaVector;

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(RotationModel)
@interface CelestiaRotationModel : NSObject

@property (readonly, getter=isPeriodic) BOOL periodic;
@property (readonly) NSTimeInterval period;

@property (readonly) double validBeginTime;
@property (readonly) double validEndTime;

- (CelestiaVector *)angularVelocityAtTime:(NSDate *)time NS_SWIFT_NAME(angularVelocity(at:));
- (CelestiaVector *)equatorOrientationAtTime:(NSDate *)time NS_SWIFT_NAME(equatorOrientation(at:));
- (CelestiaVector *)spinAtTime:(NSDate *)time NS_SWIFT_NAME(spin(at:));

@end

NS_ASSUME_NONNULL_END

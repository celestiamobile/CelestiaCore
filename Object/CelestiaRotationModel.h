//
//  CelestiaRotationModel.h
//  CelestiaCore
//
//  Created by Li Linfeng on 14/8/2019.
//  Copyright © 2019 李林峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CelestiaVector;

NS_ASSUME_NONNULL_BEGIN

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

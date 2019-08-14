//
//  CelestiaOrbit.h
//  CelestiaCore
//
//  Created by Li Linfeng on 14/8/2019.
//  Copyright © 2019 李林峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CelestiaVector;

NS_ASSUME_NONNULL_BEGIN

@interface CelestiaOrbit : NSObject

@property (readonly, getter=isPeriodic) BOOL periodic;
@property (readonly) NSTimeInterval period;
@property (readonly) double boundingRadius;

- (CelestiaVector *)velocityAtTime:(NSDate *)time NS_SWIFT_NAME(velocity(at:));
- (CelestiaVector *)positionAtTime:(NSDate *)time NS_SWIFT_NAME(position(at:));

@end

NS_ASSUME_NONNULL_END

//
//  CelestiaEclipseFinder.h
//  CelestiaCore
//
//  Created by 李林峰 on 2019/8/10.
//  Copyright © 2019 李林峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CelestiaBody;

typedef NS_OPTIONS(NSUInteger, CelestiaEclipseKind) {
    CelestiaEclipseKindSolar = 1 << 0,
    CelestiaEclipseKindLunar = 1 << 1,
};

NS_ASSUME_NONNULL_BEGIN

@interface CelestiaEclipse : NSObject

@property (readonly) CelestiaBody *occulter;
@property (readonly) CelestiaBody *receiver;

@property (readonly) NSDate *startTime;
@property (readonly) NSDate *endTime;

@end

@interface CelestiaEclipseFinder : NSObject

- (instancetype)initWithBody:(CelestiaBody *)body;

- (NSArray<CelestiaEclipse *> *)search:(CelestiaEclipseKind)kind fromStart:(NSDate *)startTime toEnd:(NSDate *)endTime NS_SWIFT_NAME(search(kind:from:to:));

- (void)abort;

@end

NS_ASSUME_NONNULL_END

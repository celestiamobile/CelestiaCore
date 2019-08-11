//
//  EclipseSearcher.h
//  CelestiaCore
//
//  Created by 李林峰 on 2019/8/10.
//  Copyright © 2019 李林峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CelestiaBody;

typedef NS_OPTIONS(NSUInteger, EclipseKind) {
    EclipseKindSolar = 1 << 0,
    EclipseKindLunar = 1 << 1,
};

NS_ASSUME_NONNULL_BEGIN

@interface EclipseResult : NSObject

@property (readonly) CelestiaBody *occulter;
@property (readonly) CelestiaBody *receiver;

@property (readonly) NSDate *startTime;
@property (readonly) NSDate *endTime;

@end

@interface EclipseSearcher : NSObject

- (instancetype)initWithBody:(CelestiaBody *)body;

- (NSArray<EclipseResult *> *)search:(EclipseKind)kind fromStart:(NSDate *)startTime toEnd:(NSDate *)endTime NS_SWIFT_NAME(search(kind:from:to:));

- (void)abort;

@end

NS_ASSUME_NONNULL_END

//
//  CelestiaSelection.h
//  CelestiaCore
//
//  Created by 李林峰 on 2019/8/10.
//  Copyright © 2019 李林峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CelestiaAstroObject;
@class CelestiaStar;
@class CelestiaDSO;
@class CelestiaBody;
@class CelestiaLocation;
@class CelestiaUniversalCoord;

NS_ASSUME_NONNULL_BEGIN

@interface CelestiaSelection : NSObject

@property (readonly, getter=isEmpty) BOOL empty;
@property (readonly) double radius;

@property (nullable, readonly) CelestiaAstroObject *object;
@property (nullable, readonly) CelestiaStar *star;
@property (nullable, readonly) CelestiaDSO *dso;
@property (nullable, readonly) CelestiaBody *body;
@property (nullable, readonly) CelestiaLocation *location;

@property (nullable, readonly) NSString *webInfoURL;

- (BOOL)isEqualToSelection:(CelestiaSelection *)csel;
- (CelestiaUniversalCoord *)position:(double)t;

- (nullable instancetype)initWithObject:(CelestiaAstroObject *)object;

@end

NS_ASSUME_NONNULL_END

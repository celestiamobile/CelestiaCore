//
//  CelestiaSelection.h
//  CelestiaCore
//
//  Created by 李林峰 on 2019/8/10.
//  Copyright © 2019 李林峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CelestiaStar;
@class CelestiaDSO;
@class CelestiaBody;
@class CelestiaLocation;
@class CelestiaUniversalCoord;

NS_ASSUME_NONNULL_BEGIN

@interface CelestiaSelection : NSObject

@property (readonly, getter=isEmpty) BOOL empty;
@property (readonly) double radius;

@property (nullable, readonly) CelestiaStar *star;
@property (nullable, readonly) CelestiaDSO *dso;
@property (nullable, readonly) CelestiaBody *body;
@property (nullable, readonly) CelestiaLocation *location;

@property (readonly) NSString *name;

@property (nullable, readonly) NSString *webInfoURL;

- (BOOL)isEqualToSelection:(CelestiaSelection *)csel;
- (CelestiaUniversalCoord *)position:(double)t;

- (instancetype)initWithStar:(CelestiaStar *)star;
- (instancetype)initWithDSO:(CelestiaDSO *)dso;
- (instancetype)initWithBody:(CelestiaBody *)body;
- (instancetype)initWithLocation:(CelestiaLocation *)location;

@end

NS_ASSUME_NONNULL_END

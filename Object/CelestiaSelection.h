//
// CelestiaSelection.h
//
// Copyright © 2020 Celestia Development Team. All rights reserved.
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
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

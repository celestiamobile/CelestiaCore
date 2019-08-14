//
//  CelestiaBody.h
//  celestia
//
//  Created by Bob Ippolito on Sat Jun 08 2002.
//  Copyright (C) 2007, Celestia Development Team
//

#import "CelestiaCatEntry.h"

@class CelestiaPlanetarySystem;
@class CelestiaOrbit;
@class CelestiaRotationModel;

NS_ASSUME_NONNULL_BEGIN

@interface CelestiaBody : CelestiaCatEntry

@property (readonly) NSString *classification;
@property (readonly) NSString *name;
@property (readonly) float radius;
@property float mass;
@property float albedo;
@property (readonly) NSArray<NSString *> *alternateSurfaceNames;

@property (nullable, readonly) CelestiaPlanetarySystem *system;

@property (readonly) NSString *webInfoURL;

- (CelestiaOrbit *)orbitAtTime:(NSDate *)time NS_SWIFT_NAME(orbit(at:));
- (CelestiaRotationModel *)rotationAtTime:(NSDate *)time NS_SWIFT_NAME(rotation(at:));

@end

NS_ASSUME_NONNULL_END

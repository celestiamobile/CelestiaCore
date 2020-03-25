//
//  CelestiaBody.h
//  celestia
//
//  Created by Bob Ippolito on Sat Jun 08 2002.
//  Copyright (C) 2007, Celestia Development Team
//

#import <CelestiaCore/CelestiaAstroObject.h>

@class CelestiaPlanetarySystem;
@class CelestiaOrbit;
@class CelestiaRotationModel;

typedef NS_ENUM(NSUInteger, CelestiaBodyType) {
    CelestiaBodyTypePlanet         =    0x01,
    CelestiaBodyTypeMoon           =    0x02,
    CelestiaBodyTypeAsteroid       =    0x04,
    CelestiaBodyTypeComet          =    0x08,
    CelestiaBodyTypeSpacecraft     =    0x10,
    CelestiaBodyTypeInvisible      =    0x20,
    CelestiaBodyTypeBarycenter     =    0x40, // Not used (invisible is used instead)
    CelestiaBodyTypeSmallBody      =    0x80, // Not used
    CelestiaBodyTypeDwarfPlanet    =   0x100,
    CelestiaBodyTypeStellar        =   0x200, // only used for orbit mask
    CelestiaBodyTypeSurfaceFeature =   0x400,
    CelestiaBodyTypeComponent      =   0x800,
    CelestiaBodyTypeMinorMoon      =  0x1000,
    CelestiaBodyTypeDiffuse        =  0x2000,
    CelestiaBodyTypeUnknown        = 0x10000,
};

NS_ASSUME_NONNULL_BEGIN

@interface CelestiaBody : CelestiaAstroObject

@property (readonly) CelestiaBodyType type;
@property (readonly) NSString *classification;
@property (readonly) NSString *name;
@property (readonly) float radius;
@property (readonly, getter=isEllipsoid) BOOL ellipsoid;
@property (readonly) BOOL hasRings;
@property (readonly) BOOL hasAtmosphere;
@property (nullable, readonly) NSDate *startTime;
@property (nullable, readonly) NSDate *endTime;
@property float mass;
@property float albedo;
@property (readonly) NSArray<NSString *> *alternateSurfaceNames;

@property (nullable, readonly) CelestiaPlanetarySystem *system;

@property (nullable, readonly) NSString *webInfoURL;

- (CelestiaOrbit *)orbitAtTime:(NSDate *)time NS_SWIFT_NAME(orbit(at:));
- (CelestiaRotationModel *)rotationAtTime:(NSDate *)time NS_SWIFT_NAME(rotation(at:));

@end

NS_ASSUME_NONNULL_END

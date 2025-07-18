//
// CelestiaBody.mm
//
// Copyright © 2020 Celestia Development Team. All rights reserved.
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//

#import "CelestiaBody.h"
#import "CelestiaBody+Private.h"
#import "CelestiaAstroObject+Private.h"
#import "CelestiaOrbit+Private.h"
#import "CelestiaRotationModel+Private.h"
#import "CelestiaPlanetarySystem+Private.h"
#import "CelestiaUtil.h"
#import "CelestiaAtmosphere+Private.h"
#import "CelestiaTimeline+Private.h"

#import "CelestiaAppCore+Locale.h"

#include <string>
#include <vector>

@implementation CelestiaBody (Private)

- (CelestiaBody*)initWithBody:(Body *)body {
    self = [super initWithObject:body];
    return self;
}

-(Body *)body {
    return reinterpret_cast<Body *>([self object]);
}

@end

@implementation CelestiaBody

- (CelestiaBodyType)type {
    return static_cast<CelestiaBodyType>([self body]->getClassification());
}

-(NSString *)name {
    return [NSString stringWithUTF8String:[self body]->getName(true).c_str()];
}

- (float)radius {
    return [self body]->getRadius();
}

- (BOOL)isEllipsoid {
    return (BOOL)[self body]->isEllipsoid();
}

- (float)mass {
    return [self body]->getMass();
}

- (float)geomAlbedo {
    return [self body]->getGeomAlbedo();
}

- (void)setMass:(float)m
{
    [self body]->setMass(m);
}

- (void)setGeomAlbedo:(float)a {
    [self body]->setGeomAlbedo(a);
}

- (BOOL)hasRings {
    return GetBodyFeaturesManager()->getRings([self body]) ? YES : NO;
}

- (BOOL)hasAtmosphere {
    return GetBodyFeaturesManager()->getAtmosphere([self body]) ? YES : NO;
}

- (CelestiaAtmosphere *)atomosphere {
    Atmosphere *atmosphere = GetBodyFeaturesManager()->getAtmosphere([self body]);
    if (atmosphere)
        return [[CelestiaAtmosphere alloc] initWithAtmosphere:atmosphere];
    return nil;
}

- (NSArray<NSString *> *)alternateSurfaceNames {
    NSMutableArray *result = [NSMutableArray array];
    auto altSurfaces = GetBodyFeaturesManager()->getAlternateSurfaceNames([self body]);
    if (altSurfaces.has_value() && !altSurfaces->empty())
    {
        for (const auto &surface : *altSurfaces)
        {
            [result addObject:[NSString stringWithUTF8String:surface.c_str()]];
        }
    }
    return result;
}

- (CelestiaPlanetarySystem *)system {
    PlanetarySystem *s = [self body]->getSystem();
    if (s == NULL) {
        return nil;
    }
    return [[CelestiaPlanetarySystem alloc] initWithSystem:s];
}

- (CelestiaTimeline *)timeline {
    return [[CelestiaTimeline alloc] initWithTimeline:[self body]->getTimeline()];
}

- (NSString *)webInfoURL {
    NSString *url = [NSString stringWithUTF8String:[self body]->getInfoURL().c_str()];
    if ([url length] == 0)
        return nil;

    return url;
}

- (CelestiaOrbit *)orbitAtTime:(NSDate *)time {
    return [[CelestiaOrbit alloc] initWithOrbit:[self body]->getOrbit([time julianDay])];
}

- (CelestiaRotationModel *)rotationAtTime:(NSDate *)time {
    return [[CelestiaRotationModel alloc] initWithRotation:[self body]->getRotationModel([time julianDay])];
}

- (BOOL)canBeUsedAsCockpit {
    return GetBodyFeaturesManager()->canBeUsedAsCockpit([self body]);
}

@end

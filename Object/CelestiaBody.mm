//
//  CelestiaBody.mm
//  celestia
//
//  Created by Bob Ippolito on Sat Jun 08 2002.
//  Copyright (C) 2007, Celestia Development Team
//

#import "CelestiaBody.h"
#import "CelestiaBody+Private.h"
#import "CelestiaAstroObject+Private.h"
#import "CelestiaOrbit+Private.h"
#import "CelestiaRotationModel+Private.h"
#import "CelestiaPlanetarySystem+Private.h"
#import "CelestiaUtil.h"

#import "CelestiaAppCore+Locale.h"

#include <string>
#include <vector>

@implementation CelestiaBody (Private)

- (CelestiaBody*)initWithBody:(Body *)body {
    self = [super initWithObject:reinterpret_cast<AstroObject *>(body)];
    return self;
}

-(Body *)body {
    return reinterpret_cast<Body *>([self object]);
}

@end

@implementation CelestiaBody

- (CelestiaBodyType)type {
    return (CelestiaBodyType)[self body]->getClassification();
}

- (NSString *)classification {
    switch ([self body]->getClassification())
    {
        case (Body::Planet):
            return LocalizedString(@"Planet");
            break;
        case (Body::Moon):
            return LocalizedString(@"Moon");
            break;
        case (Body::Asteroid):
            return LocalizedString(@"Asteroid");
            break;
        case (Body::Comet):
            return LocalizedString(@"Comet");
            break;
        case (Body::Spacecraft):
            return LocalizedString(@"Spacecraft");
            break;
        default:
            break;
    }
    return LocalizedString(@"Unknown");
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

- (float)albedo {
    return [self body]->getAlbedo();
}

- (void)setMass:(float)m
{
    [self body]->setMass(m);
}

- (void)setAlbedo:(float)a {
    [self body]->setAlbedo(a);
}

- (BOOL)hasRings {
    return [self body]->getRings() ? YES : NO;
}

- (BOOL)hasAtmosphere {
    return [self body]->getAtmosphere() ? YES : NO;
}

- (NSDate *)startTime {
    double start, end;
    [self body]->getLifespan(start, end);
    if (start > -1.0e9)
        return [NSDate dateWithJulian:start];
    return nil;
}

- (NSDate *)endTime {
    double start, end;
     [self body]->getLifespan(start, end);
     if (end < 1.0e9)
         return [NSDate dateWithJulian:end];
     return nil;
}

- (NSArray<NSString *> *)alternateSurfaceNames {
    NSMutableArray *result = [NSMutableArray array];
    std::vector<std::string> *altSurfaces = [self body]->getAlternateSurfaceNames();
    if (altSurfaces)
    {
        result = [NSMutableArray array];
        if (altSurfaces->size() > 0)
        {
            for (unsigned int i = 0; i < altSurfaces->size(); ++i)
            {
                [result addObject:[NSString stringWithUTF8String:(*altSurfaces)[i].c_str()]];
            }
        }
        delete altSurfaces;
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

@end

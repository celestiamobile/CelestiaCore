//
//  CelestiaUniverse+BrowserItem.m
//  CelestiaCore
//
//  Created by Li Linfeng on 13/8/2019.
//  Copyright © 2019 李林峰. All rights reserved.
//

#import "CelestiaUniverse+BrowserItem.h"
#import "CelestiaUniverse+Private.h"
#import "CelestiaStar+Private.h"
#import "CelestiaBody+Private.h"
#import "CelestiaLocation+Private.h"

@implementation CelestiaUniverse (BrowserItem)

- (NSDictionary *)childrenForBrowserItem:(CelestiaBrowserItem *)item {
    CelestiaCatEntry *entry = [item entry];
    if (entry == nil)
        return nil;

    if ([entry isKindOfClass:[CelestiaStar class]]) {
        CelestiaStar *star = (CelestiaStar *)entry;
        return [self childrenForStar:star];
    } else if ([entry isKindOfClass:[CelestiaBody class]]) {
        CelestiaBody *body = (CelestiaBody *)entry;
        return [self childrenForBody:body];
    }
    return nil;
}

- (NSDictionary *)childrenForStar:(CelestiaStar *)aStar {
    SolarSystem *ss = [self universe]->getSolarSystem([aStar star]);
    PlanetarySystem* sys = NULL;
    if (ss) sys = ss->getPlanets();

    NSMutableDictionary *resultDictionary = [NSMutableDictionary dictionary];

    if (sys)
    {
        int sysSize = sys->getSystemSize();
        NSMutableDictionary *subItem = nil;
        NSMutableDictionary *planets = nil;
        NSMutableDictionary *dwarfPlanets = nil;
        NSMutableDictionary *minorMoons = nil;
        NSMutableDictionary *asteroids = nil;
        NSMutableDictionary *comets = nil;
        NSMutableDictionary *spacecrafts = nil;
        int i;
        for ( i=0; i<sysSize; i++)
        {
            Body* body = sys->getBody(i);
            if (body->getName().empty())
                continue;
            CelestiaBrowserItem *item = [[CelestiaBrowserItem alloc] initWithCatEntry:[[CelestiaBody alloc] initWithBody:body] provider:self];
            int bodyClass  = body->getClassification();
            NSString *name = [NSString stringWithUTF8String:body->getName(true).c_str()];
            switch (bodyClass)
            {
                case Body::Invisible:
                    continue;
                case Body::Planet:
                    if (!planets)
                        planets = [NSMutableDictionary dictionary];
                    subItem = planets;
                    break;
                case Body::DwarfPlanet:
                    if (!dwarfPlanets)
                        dwarfPlanets = [NSMutableDictionary dictionary];
                    subItem = dwarfPlanets;
                    break;
                case Body::Moon:
                case Body::MinorMoon:
                    if (body->getRadius() < 100.0f || Body::MinorMoon == bodyClass)
                    {
                        if (!minorMoons)
                            minorMoons = [NSMutableDictionary dictionary];
                        subItem = minorMoons;
                    }
                    else
                    {
                        subItem = resultDictionary;
                    }
                    break;
                case Body::Asteroid:
                    if (!asteroids)
                        asteroids = [NSMutableDictionary dictionary];
                    subItem = asteroids;
                    break;
                case Body::Comet:
                    if (!comets)
                        comets = [NSMutableDictionary dictionary];
                    subItem = comets;
                    break;
                case Body::Spacecraft:
                    if (!spacecrafts)
                        spacecrafts = [NSMutableDictionary dictionary];
                    subItem = spacecrafts;
                    break;
                default:
                    subItem = resultDictionary;
                    break;
            }
            [subItem setObject:item forKey:name];
        }

        if (planets) {
            NSString *name = NSLocalizedStringFromTable(@"Planets",@"po",@"");
            [resultDictionary setObject:[[CelestiaBrowserItem alloc] initWithName:name children:planets] forKey:name];
        }
        if (dwarfPlanets) {
            NSString *name = NSLocalizedStringFromTable(@"Dwarf Planets",@"po",@"");
            [resultDictionary setObject:[[CelestiaBrowserItem alloc] initWithName:name children:dwarfPlanets] forKey:name];
        }
        if (minorMoons) {
            NSString *name = NSLocalizedStringFromTable(@"Minor Moons",@"po",@"");
            [resultDictionary setObject:[[CelestiaBrowserItem alloc] initWithName:name children:minorMoons] forKey:name];
        }
        if (asteroids) {
            NSString *name = NSLocalizedStringFromTable(@"Asteroids",@"po",@"");
            [resultDictionary setObject:[[CelestiaBrowserItem alloc] initWithName:name children:asteroids] forKey:name];
        }
        if (comets) {
            NSString *name = NSLocalizedStringFromTable(@"Comets",@"po",@"");
            [resultDictionary setObject:[[CelestiaBrowserItem alloc] initWithName:name children:comets] forKey:name];
        }
        if (spacecrafts) {
            NSString *name = NSLocalizedStringFromTable(@"Spacecrafts",@"po",@"");
            [resultDictionary setObject:[[CelestiaBrowserItem alloc] initWithName:name children:spacecrafts] forKey:name];
        }
    }
    return resultDictionary;
}

- (NSDictionary *)childrenForBody:(CelestiaBody *)aBody {
    PlanetarySystem* sys = [aBody body]->getSatellites();

    NSMutableDictionary *resultDictionary = [NSMutableDictionary dictionary];

    if (sys)
    {
        int sysSize = sys->getSystemSize();
        NSMutableDictionary *subItem = nil;
        NSMutableDictionary *minorMoons = nil;
        NSMutableDictionary *comets = nil;
        NSMutableDictionary *spacecrafts = nil;
        int i;
        for ( i=0; i<sysSize; i++)
        {
            Body* body = sys->getBody(i);
            if (body->getName().empty())
                continue;
            CelestiaBrowserItem *item = [[CelestiaBrowserItem alloc] initWithCatEntry:[[CelestiaBody alloc] initWithBody:body] provider:self];
            int bodyClass  = body->getClassification();
            NSString *name = [NSString stringWithUTF8String:body->getName(true).c_str()];

            if (bodyClass==Body::Asteroid) bodyClass = Body::Moon;

            switch (bodyClass)
            {
                case Body::Invisible:
                    continue;
                case Body::Moon:
                case Body::MinorMoon:
                    if (body->getRadius() < 100.0f || Body::MinorMoon == bodyClass)
                    {
                        if (!minorMoons)
                            minorMoons = [NSMutableDictionary dictionary];
                        subItem = minorMoons;
                    }
                    else
                    {
                        subItem = resultDictionary;
                    }
                    break;
                case Body::Comet:
                    if (!comets)
                        comets = [NSMutableDictionary dictionary];
                    subItem = comets;
                    break;
                case Body::Spacecraft:
                    if (!spacecrafts)
                        spacecrafts = [NSMutableDictionary dictionary];
                    subItem = spacecrafts;
                    break;
                default:
                    subItem = resultDictionary;
                    break;
            }
            [subItem setObject:item forKey:name];
        }

        if (minorMoons) {
            NSString *name = NSLocalizedStringFromTable(@"Minor Moons",@"po",@"");
            [resultDictionary setObject:[[CelestiaBrowserItem alloc] initWithName:name children:minorMoons] forKey:name];
        }
        if (comets) {
            NSString *name = NSLocalizedStringFromTable(@"Comets",@"po",@"");
            [resultDictionary setObject:[[CelestiaBrowserItem alloc] initWithName:name children:comets] forKey:name];
        }
        if (spacecrafts) {
            NSString *name = NSLocalizedStringFromTable(@"Spacecrafts",@"po",@"");
            [resultDictionary setObject:[[CelestiaBrowserItem alloc] initWithName:name children:spacecrafts] forKey:name];
        }
    }

    std::vector<Location*>* locations = [aBody body]->getLocations();
    if (locations != NULL)
    {
        NSMutableDictionary *locationDictionary = [NSMutableDictionary dictionary];
        for (vector<Location*>::const_iterator iter = locations->begin();
             iter != locations->end(); iter++)
        {
            CelestiaLocation *location = [[CelestiaLocation alloc] initWithLocation:*iter];
            [locationDictionary setObject:[[CelestiaBrowserItem alloc] initWithCatEntry:location provider:nil] forKey:[location name]];
        }
        if ([locationDictionary count] > 0) {
            NSString *name = NSLocalizedStringFromTable(@"Locations",@"po",@"");
            [resultDictionary setObject:[[CelestiaBrowserItem alloc] initWithName:name children:locationDictionary] forKey:name];
        }
    }

    return resultDictionary;
}

@end

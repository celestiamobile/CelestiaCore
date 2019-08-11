//
//  BrowserItem.mm
//  celestia
//
//  Created by Da Woon Jung on 2007-11-26
//  Copyright (C) 2007, Celestia Development Team
//

#include "solarsys.h"
#import "BrowserItem.h"
#import "CelestiaStar.h"
#import "CelestiaBody.h"
#import "CelestiaDSO.h"
#import "CelestiaLocation.h"
#import "CelestiaUniverse.h"
#import "CelestiaStar+Private.h"
#import "CelestiaBody+Private.h"
#import "CelestiaUniverse+Private.h"
#import "CelestiaLocation+Private.h"

@implementation BrowserItem

- (instancetype)initWithDSO:(CelestiaDSO *)aDSO {
    self = [super init];
    if (self) data = aDSO;
    return self;
}

- (instancetype)initWithStar:(CelestiaStar *)aStar {
    self = [super init];
    if (self) data = aStar;
    return self;
}

- (instancetype)initWithBody:(CelestiaBody *)aBody {
    self = [super init];
    if (self) data = aBody;
    return self;
}

- (instancetype)initWithLocation:(CelestiaLocation *)aLocation {
    self = [super init];
    if (self) data = aLocation;
    return self;
}

- (instancetype)initWithName:(NSString *)aName {
    self = [super init];
    if (self) data = aName;
    return self;
}

- (instancetype)initWithName:(NSString *)aName
                    children:(NSDictionary *)aChildren {
    self = [super init];
    if (self) {
        data = aName;
        if (nil == children) {
            children = [[NSMutableDictionary alloc] initWithDictionary: aChildren];
            childrenChanged = YES;
        }
    }
    return self;
}

+ (void)addChildrenIfAvailable:(BrowserItem *)item inUniverse:(CelestiaUniverse *)universe {
    if ([item childCount] == 0 && ![self isLeaf:item inUniverse:universe]) {
        id body = [item body];
        if ([body respondsToSelector: @selector(star)]) {
            [self addChildrenToStar:item inUniverse:universe];
        } else if ([body respondsToSelector: @selector(body)]) {
            [self addChildrenToBody:item];
        }
    }
}

+ (void)addChildrenToStar:(BrowserItem *) aStar inUniverse:(CelestiaUniverse *)universe {
    SolarSystem *ss = [universe universe]->getSolarSystem([((CelestiaStar *)[aStar body]) star]);
    PlanetarySystem* sys = NULL;
    if (ss) sys = ss->getPlanets();

    if (sys)
    {
        int sysSize = sys->getSystemSize();
        BrowserItem *subItem = nil;
        BrowserItem *planets = nil;
        BrowserItem *dwarfPlanets = nil;
        BrowserItem *minorMoons = nil;
        BrowserItem *asteroids = nil;
        BrowserItem *comets = nil;
        BrowserItem *spacecrafts = nil;
        int i;
        for ( i=0; i<sysSize; i++)
        {
            Body* body = sys->getBody(i);
            if (body->getName().empty())
                continue;
            BrowserItem *item = [[BrowserItem alloc] initWithBody:[[CelestiaBody alloc] initWithBody:body]];
            int bodyClass  = body->getClassification();
            switch (bodyClass)
            {
                case Body::Invisible:
                    continue;
                case Body::Planet:
                    if (!planets)
                        planets = [[BrowserItem alloc] initWithName: NSLocalizedStringFromTable(@"Planets",@"po",@"")];
                    subItem = planets;
                    break;
                case Body::DwarfPlanet:
                    if (!dwarfPlanets)
                        dwarfPlanets = [[BrowserItem alloc] initWithName: NSLocalizedStringFromTable(@"Dwarf Planets",@"po",@"")];
                    subItem = dwarfPlanets;
                    break;
                case Body::Moon:
                case Body::MinorMoon:
                    if (body->getRadius() < 100.0f || Body::MinorMoon == bodyClass)
                    {
                        if (!minorMoons)
                            minorMoons = [[BrowserItem alloc] initWithName: NSLocalizedString(@"Minor Moons",@"")];
                        subItem = minorMoons;
                    }
                    else
                    {
                        subItem = aStar;
                    }
                    break;
                case Body::Asteroid:
                    if (!asteroids)
                        asteroids = [[BrowserItem alloc] initWithName: NSLocalizedStringFromTable(@"Asteroids",@"po",@"")] ;
                    subItem = asteroids;
                    break;
                case Body::Comet:
                    if (!comets)
                        comets = [[BrowserItem alloc] initWithName: NSLocalizedStringFromTable(@"Comets",@"po",@"")];
                    subItem = comets;
                    break;
                case Body::Spacecraft:
                    if (!spacecrafts)
                        spacecrafts = [[BrowserItem alloc] initWithName: NSLocalizedString(@"Spacecrafts",@"")];
                    subItem = spacecrafts;
                    break;
                default:
                    subItem = aStar;
                    break;
            }
            [subItem addChild: item];
        }

        if (planets)      [aStar addChild: planets];
        if (dwarfPlanets) [aStar addChild: dwarfPlanets];
        if (minorMoons)   [aStar addChild: minorMoons];
        if (asteroids)    [aStar addChild: asteroids];
        if (comets)       [aStar addChild: comets];
        if (spacecrafts)  [aStar addChild: spacecrafts];
    }
}

+ (void)addChildrenToBody:(BrowserItem *) aBody {
    PlanetarySystem* sys = [(CelestiaBody *)[aBody body] body]->getSatellites();

    if (sys)
    {
        int sysSize = sys->getSystemSize();
        BrowserItem *subItem = nil;
        BrowserItem *minorMoons = nil;
        BrowserItem *comets = nil;
        BrowserItem *spacecrafts = nil;
        int i;
        for ( i=0; i<sysSize; i++)
        {
            Body* body = sys->getBody(i);
            if (body->getName().empty())
                continue;
            BrowserItem *item = [[BrowserItem alloc] initWithBody:
                                  [[CelestiaBody alloc] initWithBody: body]];
            int bodyClass  = body->getClassification();
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
                            minorMoons = [[BrowserItem alloc] initWithName: NSLocalizedString(@"Minor Moons",@"")];
                        subItem = minorMoons;
                    }
                    else
                    {
                        subItem = aBody;
                    }
                    break;
                case Body::Comet:
                    if (!comets)
                        comets = [[BrowserItem alloc] initWithName: NSLocalizedStringFromTable(@"Comets",@"po",@"")];
                    subItem = comets;
                    break;
                case Body::Spacecraft:
                    if (!spacecrafts)
                        spacecrafts = [[BrowserItem alloc] initWithName: NSLocalizedString(@"Spacecrafts",@"")];
                    subItem = spacecrafts;
                    break;
                default:
                    subItem = aBody;
                    break;
            }
            [subItem addChild: item];
        }

        if (minorMoons)  [aBody addChild: minorMoons];
        if (comets)      [aBody addChild: comets];
        if (spacecrafts) [aBody addChild: spacecrafts];
    }

    std::vector<Location*>* locations = [(CelestiaBody *)[aBody body] body]->getLocations();
    if (locations != NULL)
    {
        BrowserItem *locationItems = [[BrowserItem alloc] initWithName: NSLocalizedStringFromTable(@"Locations",@"po",@"")];
        for (vector<Location*>::const_iterator iter = locations->begin();
             iter != locations->end(); iter++)
        {
            [locationItems addChild:[[BrowserItem alloc] initWithLocation:[[CelestiaLocation alloc] initWithLocation:*iter]]];
        }
        [aBody addChild: locationItems];
    }
}

+ (BOOL)isLeaf:(BrowserItem *)item inUniverse:(CelestiaUniverse *)universe {
    if ([item childCount] > 0) return NO;

    id body = [item body];
    if ([body respondsToSelector: @selector(star)]) {
        return [universe universe]->getSolarSystem([(CelestiaStar *)body star]) ? NO : YES;
    } else if ([body respondsToSelector: @selector(body)]) {
        return ([(CelestiaBody *)body body]->getSatellites() || [(CelestiaBody *)body body]->getLocations()) ? NO : YES;
    }
    return YES;
}

- (NSString *)name {
    return ([data respondsToSelector:@selector(name)]) ? [data name] : data;
}

- (id)body {
    return ([data isKindOfClass: [NSString class]]) ? nil : data;
}

- (void)addChild:(BrowserItem *)aChild {
    if (nil == children)
        children = [[NSMutableDictionary alloc] init];

    [children setObject: aChild forKey: [aChild name]];
    childrenChanged = YES;
}

- (id)childNamed:(NSString *)aName {
    return [children objectForKey: aName];
}

- (NSArray<NSString *> *)allChildNames {
    if (childrenChanged) {
        childNames = nil;
    }

    if (nil == childNames)
    {
        childNames = [[children allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
        childrenChanged = NO;
    }

    return childNames;
}

- (NSUInteger)childCount {
    return [children count];
}

@end

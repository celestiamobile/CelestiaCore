//
// CelestiaStarBrowser.mm
//
// Copyright © 2020 Celestia Development Team. All rights reserved.
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//

#import "CelestiaStarBrowser.h"
#import "CelestiaStar+Private.h"
#import "CelestiaSimulation+Private.h"
#include "celengine/starbrowser.h"

#define BROWSER_MAX_STAR_COUNT          100

@interface CelestiaStarBrowser () {
    StarBrowser *b;
    Simulation *s;
}

@end

@implementation CelestiaStarBrowser

- (instancetype)initWithKind:(CelestiaStarBrowserKind)kind simulation:(CelestiaSimulation *)simulation {
    self = [super init];
    if (self) {
        s = [simulation simulation];
        b = new StarBrowser(s, (int)kind);
    }
    return self;
}

- (NSArray<CelestiaStar *> *)stars {
    std::vector<const Star*>* nearStars = b->listStars( BROWSER_MAX_STAR_COUNT );

    if (nearStars == nil ) return [NSArray array];

    unsigned long starCount = nearStars->size();
    NSMutableArray* starArray = [NSMutableArray array];
    for (int i = 0; i < starCount; i++)
    {
        Star *aStar = (Star *)(*nearStars)[i];
        CelestiaStar *star = [[CelestiaStar alloc] initWithStar:aStar];
        [starArray addObject:star];
    }

    delete nearStars;
    return starArray;
}

- (void)dealloc {
    delete b;
}

@end

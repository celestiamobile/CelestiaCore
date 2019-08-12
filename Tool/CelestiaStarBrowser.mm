//
//  CelestiaStarBrowser.m
//  CelestiaCore
//
//  Created by 李林峰 on 2019/8/10.
//  Copyright © 2019 李林峰. All rights reserved.
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

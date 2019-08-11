//
//  CelestiaPlanetarySystem.m
//  CelestiaCore
//
//  Created by 李林峰 on 2019/8/10.
//  Copyright © 2019 李林峰. All rights reserved.
//

#import "CelestiaPlanetarySystem+Private.h"
#import "CelestiaBody+Private.h"
#import "CelestiaStar+Private.h"

@interface CelestiaPlanetarySystem () {
    PlanetarySystem *s;
}

@end

@implementation CelestiaPlanetarySystem (Private)

- (instancetype)initWithSystem:(PlanetarySystem *)system {
    self = [super init];
    if (self) {
        s = system;
    }
    return self;
}

- (PlanetarySystem *)system {
    return s;
}

@end

@implementation CelestiaPlanetarySystem

- (CelestiaBody *)primaryObject {
    Body *b = s->getPrimaryBody();
    if (b == NULL) {
        return nil;
    }
    return [[CelestiaBody alloc] initWithBody:b];
}

- (CelestiaStar *)star {
    Star *b = s->getStar();
    if (b == NULL) {
        return nil;
    }
    return [[CelestiaStar alloc] initWithStar:b];
}

@end

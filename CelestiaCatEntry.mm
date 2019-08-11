//
//  CelestiaCatEntry.m
//  CelestiaCore
//
//  Created by 李林峰 on 2019/8/10.
//  Copyright © 2019 李林峰. All rights reserved.
//

#import "CelestiaCatEntry.h"
#import "CelestiaCatEntry+Private.h"

@interface CelestiaCatEntry () {
    CatEntry *c;
}
@end

@implementation CelestiaCatEntry (Private)

- (instancetype)initWithCatEntry:(CatEntry *)entry {
    self = [super init];
    if (self) {
        c = entry;
    }
    return self;
}

- (CatEntry *)entry {
    return c;
}

@end

@implementation CelestiaCatEntry

@end

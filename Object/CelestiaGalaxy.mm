//
//  CelestiaGalaxy.mm
//  celestia
//
//  Created by Bob Ippolito on Sat Jun 08 2002.
//  Copyright (c) 2002 Chris Laurel. All rights reserved.
//

#import "CelestiaGalaxy.h"
#import "CelestiaCatEntry+Private.h"
#import "CelestiaGalaxy+Private.h"

@implementation CelestiaGalaxy (Private)

- (instancetype)initWithGalaxy:(Galaxy *)galaxy
{
    self = [super initWithCatEntry:reinterpret_cast<CatEntry *>(galaxy)];
    return self;
}

-(Galaxy *)galaxy {
    return reinterpret_cast<Galaxy *>([self entry]);
}

@end

/*
    GalacticForm* getForm() const;
*/

@implementation CelestiaGalaxy

-(NSString *)type {
    return [NSString stringWithUTF8String:[self galaxy]->getType()];
}

-(NSString *)name {
    return @"";
}

- (float)radius {
    return [self galaxy]->getRadius();
}

- (void)setRadius:(float)r {
    [self galaxy]->setRadius(r);
}

- (float)detail {
    return [self galaxy]->getDetail();
}

- (void)setDetail:(float)d {
    [self galaxy]->setDetail(d);
}

@end

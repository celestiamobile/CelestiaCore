//
//  CelestiaLocation.mm
//  celestia
//
//  Created by Da Woon Jung on 12/31/06.
//  Copyright 2006 Chris Lauerl. All rights reserved.
//

#import "CelestiaLocation+Private.h"
#import "CelestiaCatEntry+Private.h"

@implementation CelestiaLocation (Private)

-(instancetype)initWithLocation:(Location *)aLocation {
    self = [super initWithCatEntry:reinterpret_cast<CatEntry *>(aLocation)];
    return self;
}

- (Location *)location {
    return reinterpret_cast<Location *>([self entry]);;
}

@end

@implementation CelestiaLocation

- (NSString *)name {
    return [NSString stringWithUTF8String:[self location]->getName(true).c_str()];
}

@end

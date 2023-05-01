//
// CelestiaLocation.mm
//
// Copyright © 2020 Celestia Development Team. All rights reserved.
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//

#import "CelestiaLocation+Private.h"
#import "CelestiaAstroObject+Private.h"

@implementation CelestiaLocation (Private)

-(instancetype)initWithLocation:(Location *)aLocation {
    self = [super initWithObject:aLocation];
    return self;
}

- (Location *)location {
    return reinterpret_cast<Location *>([self object]);;
}

@end

@implementation CelestiaLocation

- (NSString *)name {
    return [NSString stringWithUTF8String:[self location]->getName(true).c_str()];
}

@end

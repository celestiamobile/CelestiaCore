//
//  CelestiaLocation.mm
//  celestia
//
//  Created by Da Woon Jung on 12/31/06.
//  Copyright 2006 Chris Lauerl. All rights reserved.
//

#import "CelestiaLocation+Private.h"
#import "CelestiaAstroObject+Private.h"

@implementation CelestiaLocation (Private)

-(instancetype)initWithLocation:(Location *)aLocation {
    self = [super initWithObject:reinterpret_cast<AstroObject *>(aLocation)];
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

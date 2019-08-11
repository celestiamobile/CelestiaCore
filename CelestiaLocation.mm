//
//  CelestiaLocation.mm
//  celestia
//
//  Created by Da Woon Jung on 12/31/06.
//  Copyright 2006 Chris Lauerl. All rights reserved.
//

#import "CelestiaLocation.h"
#import "CelestiaLocation+Private.h"

@interface CelestiaLocation () {
    Location *l;
}

@end

@implementation CelestiaLocation

-(instancetype)initWithLocation:(Location *)aLocation {
    self = [super init];
    if (self) {
        l = aLocation;
    }
    return self;
}

- (Location *)location {
    return l;
}

- (NSString *)name {
    return [NSString stringWithUTF8String:l->getName(true).c_str()];
}

@end

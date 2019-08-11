//
//  CelestiaUniversalCoord.mm
//  celestia
//
//  Created by Bob Ippolito on Fri Jun 07 2002.
//  Copyright (c) 2002 Chris Laurel. All rights reserved.
//

#import "CelestiaUniversalCoord.h"
#import "CelestiaUniversalCoord+Private.h"

@interface CelestiaUniversalCoord () {
    UniversalCoord u;
}
@end

@implementation CelestiaUniversalCoord (Private)

- (instancetype)initWithUniversalCoord:(UniversalCoord)uni {
    self = [super init];
    if (self) {
        u = uni;
    }
    return self;
}

-(UniversalCoord)universalCoord {
    return u;
}

@end

@implementation CelestiaUniversalCoord

- (double)distanceTo:(CelestiaUniversalCoord*) t {
    return [self universalCoord].distanceFromKm([t universalCoord]);
}

- (CelestiaUniversalCoord *)difference:(CelestiaUniversalCoord *)t {
    return [[CelestiaUniversalCoord alloc] initWithUniversalCoord:[self universalCoord].difference([self universalCoord])];
}

@end

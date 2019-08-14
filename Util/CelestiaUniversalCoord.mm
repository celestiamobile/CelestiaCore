//
//  CelestiaUniversalCoord.mm
//  celestia
//
//  Created by Bob Ippolito on Fri Jun 07 2002.
//  Copyright (c) 2002 Chris Laurel. All rights reserved.
//

#import "CelestiaUniversalCoord+Private.h"
#import "CelestiaVector+Private.h"

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

- (double)distanceFrom:(CelestiaUniversalCoord *) t {
    return u.distanceFromKm([t universalCoord]);
}

- (CelestiaUniversalCoord *)difference:(CelestiaUniversalCoord *)t {
    return [[CelestiaUniversalCoord alloc] initWithUniversalCoord:u.difference([self universalCoord])];
}

- (CelestiaVector *)offetFrom:(CelestiaUniversalCoord *)t {
    Eigen::Vector3d offset = u.offsetFromKm([t universalCoord]);
    return [CelestiaVector vectorWithVector3d:offset];
}

@end

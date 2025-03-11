//
// CelestiaAtmosphere.mm
//
// Copyright © 2020 Celestia Development Team. All rights reserved.
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//

#import "CelestiaAtmosphere.h"
#import "CelestiaAtmosphere+Private.h"
#import "CelestiaTexture+Private.h"

@interface CelestiaAtmosphere () {
    Atmosphere *a;
    CelestiaMultiResTexture *cloudTexture;
}
@end

@implementation CelestiaAtmosphere (Private)

- (instancetype)initWithAtmosphere:(Atmosphere *)atmosphere {
    self = [super init];
    if (self) {
        a = atmosphere;
    }
    return self;
}

@end

@implementation CelestiaAtmosphere

- (CelestiaMultiResTexture *)cloudTexture {
    if (!cloudTexture) {
        cloudTexture = [[CelestiaMultiResTexture alloc] initWithTexture:&a->cloudTexture];
    }
    return cloudTexture;
}

@end

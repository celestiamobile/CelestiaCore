//
// CelestiaAstroObject.mm
//
// Copyright © 2020 Celestia Development Team. All rights reserved.
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//

#import "CelestiaAstroObject.h"
#import "CelestiaAstroObject+Private.h"

@interface CelestiaAstroObject () {
    AstroObject *c;
}
@end

@implementation CelestiaAstroObject (Private)

- (instancetype)initWithObject:(AstroObject *)object {
    self = [super init];
    if (self) {
        c = object;
    }
    return self;
}

- (AstroObject *)object {
    return c;
}

@end

@implementation CelestiaAstroObject

@end

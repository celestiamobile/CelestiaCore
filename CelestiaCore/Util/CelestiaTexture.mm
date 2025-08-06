// CelestiaTexture.mm
//
// Copyright (C) 2025, Celestia Development Team
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.


#import "CelestiaTexture.h"
#import "CelestiaTexture+Private.h"

@interface CelestiaMultiResTexture () {
    MultiResTexture *t;
}
@end

@implementation CelestiaMultiResTexture (Private)

- (instancetype)initWithTexture:(MultiResTexture *)texture {
    self = [super init];
    if (self) {
        t = texture;
    }
    return self;
}

@end

@implementation CelestiaMultiResTexture

- (void)setTexture:(NSString *)source path:(NSString *)path {
    t->setTexture([source UTF8String], [path UTF8String]);
}

@end

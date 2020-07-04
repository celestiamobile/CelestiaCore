//
// CelestiaObserver.mm
//
// Copyright © 2020 Celestia Development Team. All rights reserved.
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//

#import "CelestiaObserver.h"
#import "CelestiaObserver+Private.h"

@interface CelestiaObserver () {
    Observer *o;
}

@end

@implementation CelestiaObserver

- (NSString *)displayedSurface {
    return [NSString stringWithUTF8String:o->getDisplayedSurface().c_str()];
}

- (void)setDisplayedSurface:(NSString *)displayedSurface {
    o->setDisplayedSurface([displayedSurface UTF8String]);
}

@end

@implementation CelestiaObserver (Private)

- (instancetype)initWithObserver:(Observer *)observer {
    self = [super init];
    if (self) {
        o = observer;
    }
    return self;
}

- (Observer *)observer {
    return o;
}

@end

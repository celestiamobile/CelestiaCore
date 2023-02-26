//
// CelestiaSelection.mm
//
// Copyright © 2020 Celestia Development Team. All rights reserved.
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//

#import "CelestiaSelection+Private.h"
#import "CelestiaBody+Private.h"
#import "CelestiaDSO+Private.h"
#import "CelestiaGalaxy+Private.h"
#import "CelestiaStar+Private.h"
#import "CelestiaLocation+Private.h"
#import "CelestiaUniversalCoord+Private.h"

@interface CelestiaSelection () {
    Selection s;
}
@end

@implementation CelestiaSelection (Private)

- (instancetype)initWithSelection:(Selection)selection {
    self = [super init];
    if (self) {
        s = selection;
    }
    return self;
}

- (Selection)selection {
    return s;
}

@end

@implementation CelestiaSelection

- (instancetype)init {
    return [self initWithSelection:Selection()];
}

- (instancetype)initWithObject:(CelestiaAstroObject *)object {
    if ([object isKindOfClass:[CelestiaStar class]]) {
        return [self initWithStar:(CelestiaStar *)object];
    } else if ([object isKindOfClass:[CelestiaBody class]]) {
        return [self initWithBody:(CelestiaBody *)object];
    } else if ([object isKindOfClass:[CelestiaDSO class]]) {
        return [self initWithDSO:(CelestiaDSO *)object];
    } else if ([object isKindOfClass:[CelestiaLocation class]]) {
        return [self initWithLocation:(CelestiaLocation *)object];
    }
    return [self initWithSelection:Selection()];
}

- (instancetype)initWithStar:(CelestiaStar *)star {
    return [self initWithSelection:Selection([star star])];
}

- (instancetype)initWithBody:(CelestiaBody *)body {
    return [self initWithSelection:Selection([body body])];
}

- (instancetype)initWithDSO:(CelestiaDSO *)dso {
    return [self initWithSelection:Selection([dso DSO])];
}

- (instancetype)initWithLocation:(CelestiaLocation *)location {
    return [self initWithSelection:Selection([location location])];
}

- (BOOL)isEmpty {
    return s.empty() ? YES : NO;
}

- (double)radius {
    return s.radius();
}

- (BOOL)isEqualToSelection:(CelestiaSelection *)csel {
    return s == [csel selection];
}

- (CelestiaAstroObject *)object {
    switch (s.getType()) {
    case Selection::Type_Star:
        return [[CelestiaStar alloc] initWithStar:s.star()];
    case Selection::Type_DeepSky:
        if (!strcmp(s.deepsky()->getObjTypeName(), "galaxy"))
            return [[CelestiaGalaxy alloc] initWithGalaxy:reinterpret_cast<Galaxy *>(s.deepsky())];
        return [[CelestiaDSO alloc] initWithDSO:s.deepsky()];
    case Selection::Type_Body:
        return [[CelestiaBody alloc] initWithBody:s.body()];
    case Selection::Type_Location:
        return [[CelestiaLocation alloc] initWithLocation:s.location()];
    default:
        return nil;
    }
}

- (CelestiaStar *)star {
    CelestiaAstroObject *object = [self object];
    if ([object isKindOfClass:[CelestiaStar class]]) {
        return (CelestiaStar *)object;
    }
    return nil;
}

- (CelestiaDSO *)dso {
    CelestiaAstroObject *object = [self object];
    if ([object isKindOfClass:[CelestiaDSO class]]) {
        return (CelestiaDSO *)object;
    }
    return nil;
}

- (CelestiaBody *)body {
    CelestiaAstroObject *object = [self object];
    if ([object isKindOfClass:[CelestiaBody class]]) {
        return (CelestiaBody *)object;
    }
    return nil;
}

- (CelestiaLocation *)location {
    CelestiaAstroObject *object = [self object];
    if ([object isKindOfClass:[CelestiaLocation class]]) {
        return (CelestiaLocation *)object;
    }
    return nil;
}

- (NSString *)name {
    return [NSString stringWithUTF8String:s.getName(true).c_str()];
}

- (NSString *)webInfoURL {
    CelestiaAstroObject *object = [self object];
    if ([object isKindOfClass:[CelestiaStar class]]) {
        return [(CelestiaStar *)object webInfoURL];
    } else if ([object isKindOfClass:[CelestiaBody class]]) {
        return [(CelestiaBody *)object webInfoURL];
    } else if ([object isKindOfClass:[CelestiaDSO class]]) {
        return [(CelestiaDSO *)object webInfoURL];
    }
    return nil;
}

- (CelestiaUniversalCoord *)position:(double)t {
    return [[CelestiaUniversalCoord alloc] initWithUniversalCoord:s.getPosition(t)];
}

@end


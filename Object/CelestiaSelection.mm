//
//  CelestiaSelection.m
//  CelestiaCore
//
//  Created by 李林峰 on 2019/8/10.
//  Copyright © 2019 李林峰. All rights reserved.
//

#import "CelestiaSelection+Private.h"
#import "CelestiaBody+Private.h"
#import "CelestiaDSO+Private.h"
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

- (CelestiaStar *)star {
    if (s.getType() == Selection::Type_Star) {
        return [[CelestiaStar alloc] initWithStar:s.star()];
    }
    return nil;
}

- (CelestiaDSO *)dso {
    if (s.getType() == Selection::Type_DeepSky) {
        return [[CelestiaDSO alloc] initWithDSO:s.deepsky()];
    }
    return nil;
}

- (CelestiaBody *)body {
    if (s.getType() == Selection::Type_Body) {
        return [[CelestiaBody alloc] initWithBody:s.body()];
    }
    return nil;
}

- (CelestiaLocation *)location {
    if (s.getType() == Selection::Type_Location) {
        return [[CelestiaLocation alloc] initWithLocation:s.location()];
    }
    return nil;
}

- (NSString *)name {
    return [NSString stringWithUTF8String:s.getName().c_str()];
}

- (NSString *)webInfoURL {
    switch (s.getType())
    {
        case Selection::Type_Body:
            return [[self body] webInfoURL];
        case Selection::Type_Star:
            return [[self star] webInfoURL];
        case Selection::Type_DeepSky:
            return [[self dso] webInfoURL];
        default:
            break;
    }
    return nil;
}

- (CelestiaUniversalCoord *)position:(double)t {
    return [[CelestiaUniversalCoord alloc] initWithUniversalCoord:s.getPosition(t)];
}

@end


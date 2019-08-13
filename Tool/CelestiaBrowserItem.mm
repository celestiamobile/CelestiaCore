//
//  CelestiaBrowserItem.m
//  CelestiaCore
//
//  Created by Li Linfeng on 13/8/2019.
//  Copyright © 2019 李林峰. All rights reserved.
//

#import "CelestiaBrowserItem+Private.h"
#import "CelestiaStar.h"
#import "CelestiaBody.h"
#import "CelestiaDSO.h"
#import "CelestiaLocation.h"
#import "CelestiaUniverse.h"

@interface CelestiaBrowserItem ()

@property (nonatomic) CelestiaCatEntry *catEntry;
@property (nonatomic) NSString *stringValue;
@property (nonatomic) BOOL designatedSubItems;

@end

@implementation CelestiaBrowserItem

- (instancetype)initWithCatEntry:(CelestiaCatEntry *)entry {
    self = [super init];
    if (self) {
        _catEntry = entry;
        _stringValue = nil;
        _designatedSubItems = NO;
    }
    return self;
}

- (instancetype)initWithDSO:(CelestiaDSO *)aDSO {
    return [self initWithCatEntry:aDSO];
}

- (instancetype)initWithStar:(CelestiaStar *)aStar {
    return [self initWithCatEntry:aStar];
}

- (instancetype)initWithBody:(CelestiaBody *)aBody {
    return [self initWithCatEntry:aBody];
}

- (instancetype)initWithLocation:(CelestiaLocation *)aLocation {
    return [self initWithCatEntry:aLocation];
}

- (instancetype)initWithName:(NSString *)aName {
    self = [super init];
    if (self) {
        _catEntry = nil;
        _stringValue = aName;
        _designatedSubItems = NO;
    }
    return self;
}

@end

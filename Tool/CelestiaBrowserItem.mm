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

@property CelestiaCatEntry *catEntry;
@property NSString *stringValue;

@property (weak) id<CelestiaBrowserItemChildrenProvider> childrenProvider;

@property NSArray<NSString *> *childrenKeys;
@property NSDictionary<NSString *, CelestiaBrowserItem *> *childrenDictionary;

@end

@implementation CelestiaBrowserItem

- (instancetype)initWithCatEntry:(CelestiaCatEntry *)entry provider:(id<CelestiaBrowserItemChildrenProvider>)provider {
    self = [super init];
    if (self) {
        _catEntry = entry;
        _stringValue = nil;
        _childrenProvider = provider;
    }
    return self;
}

- (instancetype)initWithName:(NSString *)aName provider:(id<CelestiaBrowserItemChildrenProvider>)provider {
    self = [super init];
    if (self) {
        _catEntry = nil;
        _stringValue = aName;
        _childrenProvider = provider;
    }
    return self;
}

- (instancetype)initWithName:(NSString *)aName
                    children:(NSDictionary<NSString *, CelestiaBrowserItem *> *)children {
    self = [super init];
    if (self) {
        _catEntry = nil;
        _stringValue = aName;
        _childrenDictionary = children;
        _childrenKeys = [[children allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    }
    return self;
}

- (NSString *)name {
    return _stringValue;
}

- (CelestiaCatEntry *)entry {
    return _catEntry;
}

- (void)setChildren:(NSDictionary<NSString *, CelestiaBrowserItem *> *)children {
    _childrenDictionary = children;
    _childrenKeys = [[children allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    _childrenProvider = nil;
}

- (NSUInteger)childCount {
    if (_childrenDictionary != nil)
        return [_childrenDictionary count];

    if (_childrenProvider != nil)
        [self setChildren:[_childrenProvider childrenForBrowserItem:self]];

    return [_childrenDictionary count];
}

- (NSString *)childNameAt:(NSInteger)index {
    if (_childrenDictionary != nil)
    {
        if (index >= 0 && index < [_childrenKeys count])
        {
            return _childrenKeys[index];
        }
        return nil;
    }

    if (_childrenProvider != nil)
        [self setChildren:[_childrenProvider childrenForBrowserItem:self]];

    if (_childrenDictionary != nil)
    {
        if (index >= 0 && index < [_childrenKeys count])
        {
            return _childrenKeys[index];
        }
        return nil;
    }
    return nil;
}

- (CelestiaBrowserItem *)childNamed: (NSString *)aName {
    if (_childrenDictionary != nil)
        return _childrenDictionary[aName];

    if (_childrenProvider != nil)
        [self setChildren:[_childrenProvider childrenForBrowserItem:self]];

    return _childrenDictionary[aName];
}

@end

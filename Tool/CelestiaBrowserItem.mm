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
@property NSArray<CelestiaBrowserItem *> *childrenValues;

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
        _childrenProvider = nil;
        _childrenKeys = [[children allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
        NSMutableArray *values = [NSMutableArray array];
        for (NSString *key : _childrenKeys) {
            [values addObject:[children objectForKey:key]];
        }
        _childrenValues = values;
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
    _childrenKeys = [[children allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    NSMutableArray *values = [NSMutableArray array];
    for (NSString *key : _childrenKeys) {
        [values addObject:[children objectForKey:key]];
    }
    _childrenValues = values;
    _childrenProvider = nil;
}

- (NSUInteger)childCount {
    if (_childrenValues == nil && _childrenProvider != nil)
        [self setChildren:[_childrenProvider childrenForBrowserItem:self]];

    return [_childrenValues count];
}

- (NSString *)childNameAt:(NSInteger)index {
    if (_childrenValues == nil && _childrenProvider != nil)
        [self setChildren:[_childrenProvider childrenForBrowserItem:self]];

    return [_childrenKeys objectAtIndex:index];
}

- (CelestiaBrowserItem *)childNamed:(NSString *)aName {
    if (_childrenValues == nil && _childrenProvider != nil)
        [self setChildren:[_childrenProvider childrenForBrowserItem:self]];

    NSUInteger index = [_childrenKeys indexOfObject:aName];
    if (index == NSNotFound)
        return nil;

    return [_childrenValues objectAtIndex:index];
}

- (NSArray<CelestiaBrowserItem *> *)children {
    if (_childrenValues == nil && _childrenProvider != nil)
        [self setChildren:[_childrenProvider childrenForBrowserItem:self]];

    return [_childrenValues copy];
}

@end

//
// CelestiaFavorite.m
//
// Copyright © 2020 Celestia Development Team. All rights reserved.
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//

#import "CelestiaFavorite.h"

@interface CelestiaFavorite ()
@end

@implementation CelestiaFavorite

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        NSDictionary *nodeValue = [dict objectForKey:@"nodeValue"];
        NSArray *children = [dict objectForKey:@"children"];
        _name = [nodeValue objectForKey:@"name"];
        if ([[nodeValue objectForKey:@"isFolder"] boolValue]) {
            // is folder
            _url = nil;
            NSMutableArray *childrenArray = [NSMutableArray array];
            for (NSDictionary *dictionary in children) {
                [childrenArray addObject:[[CelestiaFavorite alloc] initWithDictionary:dictionary]];
            }
            _children = childrenArray;
        } else {
            // is leaf
            _url = [nodeValue objectForKey:@"url"];
            _children = nil;
        }
        if (!_name) {
            _name = @"";
        }
    }
    return self;
}

@end

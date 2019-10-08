//
//  CelestiaFavorite.m
//  CelestiaCore
//
//  Created by Li Linfeng on 8/10/2019.
//  Copyright © 2019 李林峰. All rights reserved.
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

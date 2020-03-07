//
//  CelestiaAstroObject.m
//  CelestiaCore
//
//  Created by 李林峰 on 2019/8/10.
//  Copyright © 2019 李林峰. All rights reserved.
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

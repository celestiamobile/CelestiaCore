//
//  CelestiaObserver.m
//  CelestiaCore
//
//  Created by 李林峰 on 2019/9/22.
//  Copyright © 2019 李林峰. All rights reserved.
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

//
//  CelestiaStarCatalog.m
//  CelestiaCore
//
//  Created by 李林峰 on 2019/8/10.
//  Copyright © 2019 李林峰. All rights reserved.
//

#import "CelestiaStarCatalog+Private.h"
#import "CelestiaStar+Private.h"

@interface CelestiaStarCatalog () {
    StarDatabase *d;
}

@end

@implementation CelestiaStarCatalog (Private)

- (instancetype)initWithDatabase:(StarDatabase *)database {
    self = [super init];
    if (self) {
        d = database;
    }
    return self;
}

- (StarDatabase *)database {
    return d;
}

@end

@implementation CelestiaStarCatalog

- (NSInteger)count {
    return d->size();
}

- (CelestiaStar *)objectAtIndex:(NSInteger)index {
    return [[CelestiaStar alloc] initWithStar:d->getStar((uint32_t)index)];
}

- (NSString *)starName:(CelestiaStar *)star {
    Star *s = [star star];
    return [NSString stringWithUTF8String:d->getStarName(*s, true).c_str()];
}

- (NSArray<NSString *> *)completionForName:(NSString *)name NS_SWIFT_NAME(completion(for:)) {
    std::vector<std::string> names = d->getCompletion([name UTF8String]);
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:names.size()];
    for (int i = 0; i < names.size(); i++) {
        [array addObject:[NSString stringWithUTF8String:names[i].c_str()]];
    }
    return array;
}

@end

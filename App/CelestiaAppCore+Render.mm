//
//  CelestiaAppCore+Render.m
//  CelestiaCore
//
//  Created by 李林峰 on 2020/2/25.
//  Copyright © 2020 李林峰. All rights reserved.
//

#import "CelestiaAppCore+Render.h"
#import "CelestiaAppCore+Private.h"

#include <celestia/helper.h>

@implementation CelestiaAppCore (Render)

- (NSString *)renderInfo {
    return [NSString stringWithUTF8String:Helper::getRenderInfo(core->getRenderer()).c_str()];
}

@end

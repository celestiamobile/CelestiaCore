//
//  CelestiaAppCore+Private.h
//  CelestiaAppCore
//
//  Created by 李林峰 on 2019/8/9.
//  Copyright © 2019 李林峰. All rights reserved.
//

#import "CelestiaAppCore.h"
#include <celestia/celestiacore.h>

@interface CelestiaAppCore () {
    CelestiaCore *core;
};

@end

@interface CelestiaAppCore (Private)

// MARK: Mouse events
- (void)appCoreMouseButtonUp:(CGPoint)location modifiers:(int)modifiers;
- (void)appCoreMouseButtonDown:(CGPoint)location modifiers:(int)modifiers;
- (void)appCoreMouseDragged:(CGPoint)location;
- (void)appCoreMouseMove:(CGPoint)offset modifiers:(int)modifiers;
- (void)appCoreMouseWheel:(CGFloat)motion modifiers:(int)modifiers;

// MARK: Key events
- (void)appCoreKeyUp:(int)input modifiers:(int)modifiers;
- (void)appCoreKeyDown:(int)input modifiers:(int)modifiers;
- (void)appCoreCharEnter:(char)input modifiers:(int)modifiers;

@end

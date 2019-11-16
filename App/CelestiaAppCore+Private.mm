//
//  CelestiaAppCore+Private
//  CelestiaCore
//
//  Created by 李林峰 on 2019/8/25.
//  Copyright © 2019 李林峰. All rights reserved.
//

#import "CelestiaAppCore+Private.h"

@implementation CelestiaAppCore (Private)

// MARK: Mouse events
- (void)appCoreMouseButtonUp:(CGPoint)location modifiers:(int)modifiers {
    core->mouseButtonUp(location.x, location.y, modifiers);
}

- (void)appCoreMouseButtonDown:(CGPoint)location modifiers:(int)modifiers {
    core->mouseButtonDown(location.x, location.y, modifiers);
}

- (void)appCoreMouseDragged:(CGPoint)location {
    core->mouseMove(location.x, location.y);
}

- (void)appCoreMouseMove:(CGPoint)offset modifiers:(int)modifiers {
    core->mouseMove(offset.x, offset.y, modifiers);
}

- (void)appCoreMouseWheel:(CGFloat)motion modifiers:(int)modifiers {
    core->mouseWheel(motion, modifiers);
}

// MARK: Key events
- (void)appCoreKeyUp:(int)input modifiers:(int)modifiers {
    core->keyUp(input, modifiers);
}

- (void)appCoreKeyDown:(int)input modifiers:(int)modifiers {
    core->keyDown(input, modifiers);
}

- (void)appCoreCharEnter:(char)input modifiers:(int)modifiers {
    core->charEntered(input, modifiers);
}

@end

//
//  CelestiaAppCore+AppKit.h
//  CelestiaCore
//
//  Created by 李林峰 on 2019/8/25.
//  Copyright © 2019 李林峰. All rights reserved.
//

#import <CelestiaCore/CelestiaAppCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface CelestiaAppCore (AppKit)

// MARK: Mouse events
- (void)mouseButtonUp:(CGPoint)location modifiers:(NSUInteger)modifiers buttons:(MouseButton)buttons NS_SWIFT_NAME(mouseButtonUp(at:modifiers:with:));
- (void)mouseButtonDown:(CGPoint)location modifiers:(NSUInteger)modifiers buttons:(MouseButton)buttons NS_SWIFT_NAME(mouseButtonDown(at:modifiers:with:));
- (void)mouseDragged:(CGPoint)location NS_SWIFT_NAME(mouseDragged(to:));
- (void)mouseMove:(CGPoint)offset modifiers:(NSUInteger)modifiers buttons:(MouseButton)buttons NS_SWIFT_NAME(mouseMove(by:modifiers:with:));
- (void)mouseWheel:(CGFloat)motion modifiers:(NSUInteger)modifiers NS_SWIFT_NAME(mouseWheel(by:modifiers:));

// MARK: Key events
- (void)keyUp:(nullable NSString *)input modifiers:(NSUInteger)modifiers NS_SWIFT_NAME(keyUp(with:modifiers:));
- (void)keyDown:(nullable NSString *)input modifiers:(NSUInteger)modifiers NS_SWIFT_NAME(keyDown(with:modifiers:));
- (void)keyUp:(NSInteger)input;
- (void)keyDown:(NSInteger)input;
- (void)charEnter:(char)input;

@end

NS_ASSUME_NONNULL_END

//
//  CelestiaAppCore.h
//  CelestiaAppCore
//
//  Created by 李林峰 on 2019/8/9.
//  Copyright © 2019 李林峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CelestiaSimulation;
@class CelestiaSelection;

typedef NS_OPTIONS(NSUInteger, MouseButton) {
    MouseButtonLeft = 1 << 0,
    MouseButtonMiddle = 1 << 1,
    MouseButtonRight = 1 << 2,
};

NS_ASSUME_NONNULL_BEGIN

@interface CelestiaAppCore : NSObject

// MARK: Initilalization

- (instancetype)init;

+ (BOOL)glewInit;

- (BOOL)startSimulationWithConfigFileName:(nullable NSString *)configFileName extraDirectories:(nullable NSArray<NSString *> *)extraDirectories progressReporter:(void (^)(NSString *))reporter NS_SWIFT_NAME(startSimulation(configFileName:extraDirectories:progress:));

- (BOOL)startRenderer;

- (void)start:(NSDate *)date NS_SWIFT_NAME(start(at:));

// MARK: Drawing

@property (readonly) NSUInteger aaSamples;

- (void)draw;

- (void)tick;

- (void)resize:(CGSize)size NS_SWIFT_NAME(resize(to:));

// MARK: Mouse events

- (void)mouseButtonUp:(NSPoint)location modifiers:(NSUInteger)modifiers buttons:(MouseButton)buttons NS_SWIFT_NAME(mouseButtonUp(at:modifiers:with:));
- (void)mouseButtonDown:(NSPoint)location modifiers:(NSUInteger)modifiers buttons:(MouseButton)buttons NS_SWIFT_NAME(mouseButtonDown(at:modifiers:with:));
- (void)mouseDragged:(NSPoint)location NS_SWIFT_NAME(mouseDragged(to:));
- (void)mouseMove:(NSPoint)offset modifiers:(NSUInteger)modifiers buttons:(MouseButton)buttons NS_SWIFT_NAME(mouseMove(by:modifiers:with:));
- (void)mouseWheel:(CGFloat)motion modifiers:(NSUInteger)modifiers NS_SWIFT_NAME(mouseWheel(by:modifiers:));

- (CelestiaSelection *)requestSelection:(NSPoint)location NS_SWIFT_NAME(requestSelection(at:));

// MARK: Key events
- (void)keyUp:(nullable NSString *)input modifiers:(NSUInteger)modifiers NS_SWIFT_NAME(keyUp(with:modifiers:));
- (void)keyDown:(nullable NSString *)input modifiers:(NSUInteger)modifiers NS_SWIFT_NAME(keyDown(with:modifiers:));
- (void)keyUp:(NSInteger)input;
- (void)keyDown:(NSInteger)input;
- (void)charEnter:(unichar)input;

// MARK: History
- (void)forward;
- (void)back;

// MARK: Other
- (void)runScript:(NSString *)path NS_SWIFT_NAME(runScript(at:));

// MARK: Simulation
@property (readonly) CelestiaSimulation *simulation;

@end

NS_ASSUME_NONNULL_END

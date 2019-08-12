//
//  CelestiaAppCore.mm
//  CelestiaAppCore
//
//  Created by 李林峰 on 2019/8/9.
//  Copyright © 2019 李林峰. All rights reserved.
//

#include <GL/glew.h>
#import "CelestiaAppCore+Private.h"
#import "CelestiaAppCore+Setting.h"

#import "CelestiaSimulation+Private.h"
#import "EclipseSearcher+Private.h"

#import "Astro.h"

#import <AppKit/AppKit.h>

class AppCoreProgressWatcher: public ProgressNotifier
{
public:
    AppCoreProgressWatcher(void (^block)(NSString *)) : ProgressNotifier(), block(block) {};

    void update(const std::string& status) {
        @autoreleasepool {
            block([NSString stringWithUTF8String:status.c_str()]);
        }
    }
private:
    void (^block)(NSString *);
};

@implementation CelestiaAppCore

// MARK: Initilalization

- (instancetype)init {
    self = [super init];
    if (self != nil) {
        core = new CelestiaCore;
        [self initializeSetting];
    }
    return self;
}

+ (BOOL)glewInit {
    return glewInit() == GLEW_OK;
}

- (BOOL)startSimulationWithConfigFileName:(NSString *)configFileName extraDirectories:(NSArray<NSString *> *)extraDirectories progressReporter:(void (^)(NSString *))reporter {

    AppCoreProgressWatcher watcher(reporter);

    std::string configFile = configFileName == nil ? "" : [configFileName UTF8String];
    __block std::vector<std::string> extras;
    [extraDirectories enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        extras.push_back([obj UTF8String]);
    }];

    return core->initSimulation(configFile, extras, &watcher) ? YES : NO;
}

- (BOOL)startRenderer {
    BOOL success = core->initRenderer() ? YES : NO;

    return success;
}

- (void)start:(NSDate *)date {
    core->start([date julianDay]);
}

// MARK: Drawing

- (NSUInteger)aaSamples {
    return core->getConfig()->aaSamples;
}

- (void)draw {
    core->draw();
}

- (void)tick {
    core->tick();
}

- (void)resize:(CGSize)size {
    core->resize(size.width, size.height);
}

// MARK: Mouse events
- (void)mouseButtonUp:(NSPoint)location modifiers:(NSUInteger)modifiers buttons:(MouseButton)buttons {
    core->mouseButtonUp(location.x, location.y, [self toCelestiaModifiers:modifiers buttons:buttons]);
}

- (void)mouseButtonDown:(NSPoint)location modifiers:(NSUInteger)modifiers buttons:(MouseButton)buttons {
    core->mouseButtonDown(location.x, location.y, [self toCelestiaModifiers:modifiers buttons:buttons]);
}

- (void)mouseDragged:(NSPoint)location {
    core->mouseMove(location.x, location.y);
}

- (void)mouseMove:(NSPoint)offset modifiers:(NSUInteger)modifiers buttons:(MouseButton)buttons {
    core->mouseMove(offset.x, offset.y, [self toCelestiaModifiers:modifiers buttons:buttons]);
}

- (void)mouseWheel:(CGFloat)motion modifiers:(NSUInteger)modifiers {
    core->mouseWheel(motion, [self toCelestiaModifiers:modifiers buttons:0]);
}

- (CelestiaSelection *)requestSelection:(NSPoint)location {
    core->charEntered(8, 0);
    [self mouseButtonUp:location modifiers:0 buttons:MouseButtonLeft];
    [self mouseButtonDown:location modifiers:0 buttons:MouseButtonLeft];

    return [[self simulation] selection];
}

// MARK: Key events
- (void)keyUp:(NSString *)input modifiers:(NSUInteger)modifiers {
    if (input == nil || input.length == 0) {
        return;
    }

    unichar key = [input characterAtIndex:0];
    int cModifiers = [self toCelestiaModifiers:modifiers buttons:0];
    core->keyUp([self toCelestiaKey:key modifiers:modifiers], cModifiers);
}

- (void)keyDown:(NSString *)input modifiers:(NSUInteger)modifiers {
    if (input == nil || input.length == 0) {
        return;
    }

    unichar key = [input characterAtIndex:0];
    int cModifiers = [self toCelestiaModifiers:modifiers buttons:0];
    if ( key == NSDeleteCharacter )
        key = NSBackspaceCharacter; // delete = backspace
    else if ( key == NSDeleteFunctionKey || key == NSClearLineFunctionKey )
        key = NSDeleteCharacter; // del = delete
    else if ( key == NSBackTabCharacter )
        key = 127;

    if ( (key<128) && ((key < '0') || (key>'9') || !(modifiers & NSNumericPadKeyMask)) ) {
        core->charEntered(key, cModifiers);
    }

    core->keyDown([self toCelestiaKey:key modifiers:modifiers], cModifiers);
}

- (void)keyUp:(NSInteger)input {
    core->keyUp((int)input);
}

- (void)keyDown:(NSInteger)input {
    core->keyDown((int)input);
}

- (void)charEnter:(unichar)input {
    core->charEntered(input);
}

// MARK: Other
- (void)runScript:(NSString *)path {
    core->runScript([path UTF8String]);
}

// MARK: Private
- (int)toCelestiaModifiers:(NSUInteger)modifiers buttons:(MouseButton)buttons {
    int cModifiers = 0;
    if (modifiers & NSCommandKeyMask)
        cModifiers |= CelestiaCore::ControlKey;
    if (modifiers & NSControlKeyMask)
        cModifiers |= CelestiaCore::ControlKey;
    if (modifiers & NSShiftKeyMask)
        cModifiers |= CelestiaCore::ShiftKey;
    if (buttons & 1)
        cModifiers |= CelestiaCore::LeftButton;
    if (buttons & 2)
        cModifiers |= CelestiaCore::MiddleButton;
    if (buttons & 4)
        cModifiers |= CelestiaCore::RightButton;
    return cModifiers;
}

- (int)toCelestiaKey:(unichar)key modifiers:(NSUInteger)modifiers {

    int celestiaKey = 0;

    if ((modifiers & NSNumericPadKeyMask) && (key >= '0') && (key <= '9'))
        switch(key)
    {
        case '0':
            celestiaKey = CelestiaCore::Key_NumPad0;
            break;
        case '1':
            celestiaKey = CelestiaCore::Key_NumPad1;
            break;
        case '2':
            celestiaKey = CelestiaCore::Key_NumPad2;
            break;
        case '3':
            celestiaKey = CelestiaCore::Key_NumPad3;
            break;
        case '4':
            celestiaKey = CelestiaCore::Key_NumPad4;
            break;
        case '5':
            celestiaKey = CelestiaCore::Key_NumPad5;
            break;
        case '6':
            celestiaKey = CelestiaCore::Key_NumPad6;
            break;
        case '7':
            celestiaKey = CelestiaCore::Key_NumPad7;
            break;
        case '8':
            celestiaKey = CelestiaCore::Key_NumPad8;
            break;
        case '9':
            celestiaKey = CelestiaCore::Key_NumPad9;
            break;
        default: break;
    }
    else switch(key)
    {
        case NSF1FunctionKey:
            celestiaKey = CelestiaCore::Key_F1;
            break;
        case NSF2FunctionKey:
            celestiaKey = CelestiaCore::Key_F2;
            break;
        case NSF3FunctionKey:
            celestiaKey = CelestiaCore::Key_F3;
            break;
        case NSF4FunctionKey:
            celestiaKey = CelestiaCore::Key_F4;
            break;
        case NSF5FunctionKey:
            celestiaKey = CelestiaCore::Key_F5;
            break;
        case NSF6FunctionKey:
            celestiaKey = CelestiaCore::Key_F6;
            break;
        case NSF7FunctionKey:
            celestiaKey = CelestiaCore::Key_F7;
            break;
        case NSF8FunctionKey:
            celestiaKey = CelestiaCore::Key_F8;
            break;
        case NSF9FunctionKey:
            celestiaKey = CelestiaCore::Key_F9;
            break;
        case NSF10FunctionKey:
            celestiaKey = CelestiaCore::Key_F10;
            break;
        case NSF11FunctionKey:
            celestiaKey = CelestiaCore::Key_F11;
            break;
        case NSF12FunctionKey:
            celestiaKey = CelestiaCore::Key_F12;
            break;
        case NSUpArrowFunctionKey:
            celestiaKey = CelestiaCore::Key_Up;
            break;
        case NSDownArrowFunctionKey:
            celestiaKey = CelestiaCore::Key_Down;
            break;
        case NSLeftArrowFunctionKey:
            celestiaKey = CelestiaCore::Key_Left;
            break;
        case NSRightArrowFunctionKey:
            celestiaKey = CelestiaCore::Key_Right;
            break;
        case NSPageUpFunctionKey:
            celestiaKey = CelestiaCore::Key_PageUp;
            break;
        case NSPageDownFunctionKey:
            celestiaKey = CelestiaCore::Key_PageDown;
            break;
        case NSHomeFunctionKey:
            celestiaKey = CelestiaCore::Key_Home;
            break;
        case NSEndFunctionKey:
            celestiaKey = CelestiaCore::Key_End;
            break;
        case NSInsertFunctionKey:
            celestiaKey = CelestiaCore::Key_Insert;
            break;
        default:
            if ((key < 128) && (key > 33))
            {
                celestiaKey = (int) (key & 0x00FF);
            }
            break;
    }

    return celestiaKey;
}

// MARK: Simulation
- (CelestiaSimulation *)simulation {
    return [[CelestiaSimulation alloc] initWithSimulation:core->getSimulation()];
}

// MARK: History
- (void)forward {
    std::vector<Url>::size_type historySize = core->getHistory().size();
    if (historySize < 2) return;
    if (core->getHistoryCurrent() > historySize-2) return;
    core->forward();
}

- (void)back {
    core->back();
}

- (void)dealloc {
    delete core;
}

@end

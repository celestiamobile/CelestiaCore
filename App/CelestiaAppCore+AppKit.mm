//
//  CelestiaAppCore+AppKit.mm
//  CelestiaCore
//
//  Created by 李林峰 on 2019/8/25.
//  Copyright © 2019 李林峰. All rights reserved.
//

#import "CelestiaAppCore+AppKit.h"
#import "CelestiaAppCore+Private.h"

#import <AppKit/AppKit.h>

@implementation CelestiaAppCore (AppKit)

// MARK: Mouse events
- (void)mouseButtonUp:(CGPoint)location modifiers:(NSUInteger)modifiers buttons:(MouseButton)buttons {
    [self appCoreMouseButtonUp:location modifiers:[self toCelestiaModifiers:modifiers buttons:buttons]];
}

- (void)mouseButtonDown:(CGPoint)location modifiers:(NSUInteger)modifiers buttons:(MouseButton)buttons {
    [self appCoreMouseButtonDown:location modifiers:[self toCelestiaModifiers:modifiers buttons:buttons]];
}

- (void)mouseDragged:(CGPoint)location {
    [self appCoreMouseDragged:location];
}

- (void)mouseMove:(CGPoint)offset modifiers:(NSUInteger)modifiers buttons:(MouseButton)buttons {
    [self appCoreMouseMove:offset modifiers:[self toCelestiaModifiers:modifiers buttons:buttons]];
}

- (void)mouseWheel:(CGFloat)motion modifiers:(NSUInteger)modifiers {
    [self appCoreMouseWheel:motion modifiers:[self toCelestiaModifiers:modifiers buttons:0]];
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

// MARK: Key events
- (void)keyUp:(NSString *)input modifiers:(NSUInteger)modifiers {
    if (input == nil || input.length == 0) {
        return;
    }

    unichar key = [input characterAtIndex:0];
    int cModifiers = [self toCelestiaModifiers:modifiers buttons:0];
    [self appCoreKeyUp:[self toCelestiaKey:key modifiers:modifiers] modifiers:cModifiers];
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
        [self appCoreCharEnter:(char)key modifiers:cModifiers];
    }

    [self appCoreKeyDown:[self toCelestiaKey:key modifiers:modifiers] modifiers:cModifiers];
}

- (void)keyUp:(NSInteger)input {
    [self appCoreKeyUp:(int)input modifiers:0];
}

- (void)keyDown:(NSInteger)input {
    [self appCoreKeyDown:(int)input modifiers:0];
}

- (void)charEnter:(char)input {
    [self appCoreCharEnter:input modifiers:0];
}

// MARK: Private
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

@end

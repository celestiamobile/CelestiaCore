//
// CelestiaAppCore.h
//
// Copyright © 2020 Celestia Development Team. All rights reserved.
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGGeometry.h>

@class CelestiaSimulation;
@class CelestiaSelection;
@class CelestiaDestination;

typedef NS_OPTIONS(NSUInteger, MouseButton) {
    MouseButtonLeft = 1 << 0,
    MouseButtonMiddle = 1 << 1,
    MouseButtonRight = 1 << 2,
};

typedef NS_ENUM(NSUInteger, CursorShape) {
    CursorShapeArrow            = 0,
    CursorShapeUpArrow          = 1,
    CursorShapeCross            = 2,
    CursorShapeInvertedCross    = 3,
    CursorShapeWait             = 4,
    CursorShapeBusy             = 5,
    CursorShapeIbeam            = 6,
    CursorShapeSizeVer          = 7,
    CursorShapeSizeHor          = 8,
    CursorShapeSizeBDiag        = 9,
    CursorShapeSizeFDiag        = 10,
    CursorShapeSizeAll          = 11,
    CursorShapeSplitV           = 12,
    CursorShapeSplitH           = 13,
    CursorShapePointingHand     = 14,
    CursorShapeForbidden        = 15,
    CursorShapeWhatsThis        = 16,
};

typedef NS_ENUM(NSUInteger, CelestiaJoystickAxis) {
    CelestiaJoystickAxisX           = 0,
    CelestiaJoystickAxisY           = 1,
    CelestiaJoystickAxisZ           = 2,
};

typedef NS_ENUM(NSUInteger, CelestiaJoystickButton) {
    CelestiaJoystickButton1           = 0,
    CelestiaJoystickButton2           = 1,
    CelestiaJoystickButton3           = 2,
    CelestiaJoystickButton4           = 3,
    CelestiaJoystickButton5           = 4,
    CelestiaJoystickButton6           = 5,
    CelestiaJoystickButton7           = 6,
    CelestiaJoystickButton8           = 7,
};

typedef NS_ENUM(NSUInteger, ScreenshotFileType) {
    ScreenshotFileTypeJPEG      = 1,
    ScreenshotFileTypePNG       = 4,
};

typedef NS_ENUM(NSUInteger, RendererFontStyle) {
    RendererFontNormal          = 0,
    RendererFontLarge           = 1,
};

typedef NS_OPTIONS(NSUInteger, CelestiaWatcherFlag) {
    CelestiaWatcherFlagLabelFlagsChanged       = 1,
    CelestiaWatcherFlagRenderFlagsChanged      = 2,
    CelestiaWatcherFlagVerbosityLevelChanged   = 4,
    CelestiaWatcherFlagTimeZoneChanged         = 8,
    CelestiaWatcherFlagAmbientLightChanged     = 16,
    CelestiaWatcherFlagFaintestChanged         = 32,
    CelestiaWatcherFlagHistoryChanged          = 64,
    CelestiaWatcherFlagTextEnterModeChanged    = 128,
    CelestiaWatcherFlagGalaxyLightGainChanged  = 256,
};

typedef NS_ENUM(NSUInteger, CelestiaTextEnterMode) {
    CelestiaTextEnterModeNormal         = 0,
    CelestiaTextEnterModeAutoComplete   = 1,
    CelestiaTextEnterModePassToScript   = 2,
};

NS_ASSUME_NONNULL_BEGIN

@protocol CelestiaAppCoreDelegate <NSObject>

- (void)celestiaAppCoreFatalErrorHappened:(NSString *)error;
- (void)celestiaAppCoreCursorShapeChanged:(CursorShape)shape;
- (void)celestiaAppCoreCursorDidRequestContextMenuAtPoint:(CGPoint)location withSelection:(CelestiaSelection *)selection;
- (void)celestiaAppCoreWatchedFlagDidChange:(CelestiaWatcherFlag)changedFlag;

@end

@interface CelestiaAppCore : NSObject

@property (nonatomic, readonly, getter=isInitialized) BOOL initialized;

@property (nonatomic, weak, nullable) id<CelestiaAppCoreDelegate> delegate;

// MARK: Initilalization

- (instancetype)init;

+ (BOOL)initGL;

- (BOOL)startSimulationWithConfigFileName:(nullable NSString *)configFileName extraDirectories:(nullable NSArray<NSString *> *)extraDirectories progressReporter:(void (NS_NOESCAPE ^)(NSString *))reporter NS_SWIFT_NAME(startSimulation(configFileName:extraDirectories:progress:));

- (BOOL)startRenderer;
- (void)setDPI:(NSInteger)dpi;

- (void)setStartURL:(nullable NSString *)startURL;
- (void)start;
- (void)start:(NSDate *)date NS_SWIFT_NAME(start(at:));

// MARK: Drawing

@property (readonly) NSUInteger aaSamples;

- (void)draw;
- (void)tick;
+ (void)finish;
- (void)resize:(CGSize)size NS_SWIFT_NAME(resize(to:));
- (void)setSafeAreaInsetsWithLeft:(CGFloat)left top:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom NS_SWIFT_NAME(setSafeAreaInsets(left:top:right:bottom:));
- (void)setFont:(NSString *)fontPath collectionIndex:(NSInteger)collectionIndex fontSize:(NSInteger)fontSize;
- (void)setTitleFont:(NSString *)fontPath collectionIndex:(NSInteger)collectionIndex fontSize:(NSInteger)fontSize;
- (void)setRendererFont:(NSString *)fontPath collectionIndex:(NSInteger)collectionIndex fontSize:(NSInteger)fontSize fontStyle:(RendererFontStyle)fontStyle;
- (void)clearFonts;
- (void)setPickTolerance:(CGFloat)pickTolerance;

// MARK: History
- (void)forward;
- (void)back;

// MARK: Other
@property (readonly) NSString *currentURL;
@property CelestiaTextEnterMode textEnterMode;

@property (readonly) NSArray<CelestiaDestination *> *destinations;

- (void)runScript:(NSString *)path NS_SWIFT_NAME(runScript(at:));
- (void)goToURL:(NSString *)url NS_SWIFT_NAME(go(to:));

- (BOOL)screenshot:(NSString *)filePath withFileSize:(ScreenshotFileType)type NS_SWIFT_NAME(screenshot(to:type:));

+ (void)setLocaleDirectory:(NSString *)localeDirectory;

// MARK: Simulation
@property (readonly) CelestiaSimulation *simulation;

@end

NS_ASSUME_NONNULL_END

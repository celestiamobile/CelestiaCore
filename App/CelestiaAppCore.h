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
@class CelestiaAppState;

typedef NS_OPTIONS(NSUInteger, CelestiaMouseButton) {
    CelestiaMouseButtonLeft = 1 << 0,
    CelestiaMouseButtonMiddle = 1 << 1,
    CelestiaMouseButtonRight = 1 << 2,
} NS_SWIFT_NAME(MouseButton);

typedef NS_ENUM(NSUInteger, CelestiaCursorShape) {
    CelestiaCursorShapeArrow            = 0,
    CelestiaCursorShapeUpArrow          = 1,
    CelestiaCursorShapeCross            = 2,
    CelestiaCursorShapeInvertedCross    = 3,
    CelestiaCursorShapeWait             = 4,
    CelestiaCursorShapeBusy             = 5,
    CelestiaCursorShapeIbeam            = 6,
    CelestiaCursorShapeSizeVer          = 7,
    CelestiaCursorShapeSizeHor          = 8,
    CelestiaCursorShapeSizeBDiag        = 9,
    CelestiaCursorShapeSizeFDiag        = 10,
    CelestiaCursorShapeSizeAll          = 11,
    CelestiaCursorShapeSplitV           = 12,
    CelestiaCursorShapeSplitH           = 13,
    CelestiaCursorShapePointingHand     = 14,
    CelestiaCursorShapeForbidden        = 15,
    CelestiaCursorShapeWhatsThis        = 16,
} NS_SWIFT_NAME(CursorShape);

typedef NS_ENUM(NSUInteger, CelestiaJoystickAxis) {
    CelestiaJoystickAxisX           = 0,
    CelestiaJoystickAxisY           = 1,
    CelestiaJoystickAxisZ           = 2,
} NS_SWIFT_NAME(JoystickAxis);

typedef NS_ENUM(NSUInteger, CelestiaJoystickButton) {
    CelestiaJoystickButton1           = 0,
    CelestiaJoystickButton2           = 1,
    CelestiaJoystickButton3           = 2,
    CelestiaJoystickButton4           = 3,
    CelestiaJoystickButton5           = 4,
    CelestiaJoystickButton6           = 5,
    CelestiaJoystickButton7           = 6,
    CelestiaJoystickButton8           = 7,
} NS_SWIFT_NAME(JoystickButton);

typedef NS_ENUM(NSUInteger, CelestiaScreenshotFileType) {
    CelestiaScreenshotFileTypeJPEG      = 1,
    CelestiaScreenshotFileTypePNG       = 4,
} NS_SWIFT_NAME(ScreenshotFileType);

typedef NS_ENUM(NSUInteger, CelestiaRendererFontStyle) {
    CelestiaRendererFontStyleNormal          = 0,
    CelestiaRendererFontStyleLarge           = 1,
} NS_SWIFT_NAME(RendererFontStyle);

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
} NS_SWIFT_NAME(WatcherFlag);

typedef NS_ENUM(NSUInteger, CelestiaTextEnterMode) {
    CelestiaTextEnterModeNormal         = 0,
    CelestiaTextEnterModeAutoComplete   = 1,
    CelestiaTextEnterModePassToScript   = 2,
} NS_SWIFT_NAME(TextEnterMode);

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(AppCoreDelegate)
@protocol CelestiaAppCoreDelegate <NSObject>

- (void)celestiaAppCoreFatalErrorHappened:(NSString *)error;
- (void)celestiaAppCoreCursorShapeChanged:(CelestiaCursorShape)shape;
- (void)celestiaAppCoreWatchedFlagDidChange:(CelestiaWatcherFlag)changedFlag;

@end

NS_SWIFT_NAME(AppCoreContextMenuHandler)
@protocol CelestiaAppCoreContextMenuHandler <NSObject>
- (void)celestiaAppCoreCursorDidRequestContextMenuAtPoint:(CGPoint)location withSelection:(CelestiaSelection *)selection;
@end

NS_SWIFT_NAME(AppCore)
@interface CelestiaAppCore : NSObject

@property (nonatomic, readonly, getter=isInitialized) BOOL initialized;

@property (nonatomic, weak, nullable) id<CelestiaAppCoreDelegate> delegate;
@property (nonatomic, weak, nullable) id<CelestiaAppCoreContextMenuHandler> contextMenuHandler;
@property (nonatomic, readonly) CGSize size;

@property (nonatomic, readonly) CelestiaAppState *state;

// MARK: Initilalization

- (instancetype)init;

+ (BOOL)initGL;

- (BOOL)startSimulationWithConfigFileName:(nullable NSString *)configFileName extraDirectories:(nullable NSArray<NSString *> *)extraDirectories progressReporter:(void (NS_NOESCAPE ^)(NSString *))reporter NS_SWIFT_NAME(startSimulation(configFileName:extraDirectories:progress:));

- (BOOL)startRenderer;
- (void)setDPI:(NSInteger)dpi;

- (void)setStartURL:(nullable NSString *)startURL;
- (void)start;
- (void)start:(NSDate *)date NS_SWIFT_NAME(start(at:));

- (void)runDemo;

// MARK: Drawing

- (void)draw;
- (void)tick;
+ (void)finish;
- (void)resize:(CGSize)size NS_SWIFT_NAME(resize(to:));
- (void)setSafeAreaInsetsWithLeft:(CGFloat)left top:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom NS_SWIFT_NAME(setSafeAreaInsets(left:top:right:bottom:));
- (void)setHudFont:(NSString *)fontPath collectionIndex:(NSInteger)collectionIndex fontSize:(NSInteger)fontSize;
- (void)setHudTitleFont:(NSString *)fontPath collectionIndex:(NSInteger)collectionIndex fontSize:(NSInteger)fontSize;
- (void)setRendererFont:(NSString *)fontPath collectionIndex:(NSInteger)collectionIndex fontSize:(NSInteger)fontSize fontStyle:(CelestiaRendererFontStyle)fontStyle;
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

- (BOOL)screenshot:(NSString *)filePath withFileSize:(CelestiaScreenshotFileType)type NS_SWIFT_NAME(screenshot(to:type:));

@property (class, readonly) NSString *language;

+ (void)setLocaleDirectory:(NSString *)localeDirectory;

// MARK: Simulation
@property (readonly) CelestiaSimulation *simulation;

@end

NS_ASSUME_NONNULL_END

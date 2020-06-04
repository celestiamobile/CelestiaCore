//
//  CelestiaAppCore.h
//  CelestiaAppCore
//
//  Created by 李林峰 on 2019/8/9.
//  Copyright © 2019 李林峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGGeometry.h>

@class CelestiaSimulation;
@class CelestiaSelection;

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

typedef NS_ENUM(NSUInteger, ScreenshotFileType) {
    ScreenshotFileTypeJPEG      = 1,
    ScreenshotFileTypePNG       = 4,
};

NS_ASSUME_NONNULL_BEGIN

@protocol CelestiaAppCoreDelegate <NSObject>

- (void)celestiaAppCoreFatalErrorHappened:(NSString *)error;
- (void)celestiaAppCoreCursorShapeChanged:(CursorShape)shape;
- (void)celestiaAppCoreCursorDidRequestContextMenuAtPoint:(CGPoint)location withSelection:(CelestiaSelection *)selection;

@end

@interface CelestiaAppCore : NSObject

@property (nonatomic, readonly, getter=isInitialized) BOOL initialized;

@property (nonatomic, weak, nullable) id<CelestiaAppCoreDelegate> delegate;

// MARK: Initilalization

- (instancetype)init;

+ (BOOL)initGL;

- (BOOL)startSimulationWithConfigFileName:(nullable NSString *)configFileName extraDirectories:(nullable NSArray<NSString *> *)extraDirectories progressReporter:(void (^)(NSString *))reporter NS_SWIFT_NAME(startSimulation(configFileName:extraDirectories:progress:));

- (BOOL)startRenderer;
- (void)setDPI:(NSInteger)dpi;

- (void)setStartURL:(nullable NSString *)startURL;
- (void)start;
- (void)start:(NSDate *)date NS_SWIFT_NAME(start(at:));

// MARK: Drawing

@property (readonly) NSUInteger aaSamples;

- (void)draw;
- (void)tick;
- (void)resize:(CGSize)size NS_SWIFT_NAME(resize(to:));
- (void)setSafeAreaInsetsWithLeft:(CGFloat)left top:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom NS_SWIFT_NAME(setSafeAreaInsets(left:top:right:bottom:));

// MARK: History
- (void)forward;
- (void)back;

// MARK: Other
@property (readonly) NSString *currentURL;

- (void)runScript:(NSString *)path NS_SWIFT_NAME(runScript(at:));
- (void)goToURL:(NSString *)url NS_SWIFT_NAME(go(to:));

- (BOOL)captureMovie:(NSString *)filePath withVideoSize:(CGSize)size fps:(float)fps NS_SWIFT_NAME(captureMovie(to:size:fps:));
- (BOOL)screenshot:(NSString *)filePath withFileSize:(ScreenshotFileType)type NS_SWIFT_NAME(screenshot(to:type:));

+ (void)setLocaleDirectory:(NSString *)localeDirectory;

// MARK: Simulation
@property (readonly) CelestiaSimulation *simulation;

@end

NS_ASSUME_NONNULL_END

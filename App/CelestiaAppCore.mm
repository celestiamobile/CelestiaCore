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

#import "CelestiaSelection+Private.h"

#import "CelestiaUtil.h"

#include "celestia/url.h"
#include "celestia/oggtheoracapture.h"

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

class AppCoreAlerter: public CelestiaCore::Alerter
{
public:
    AppCoreAlerter(void (^block)(NSString *)) : CelestiaCore::Alerter(), block(block) {};

    void fatalError(const std::string &error)
    {
        @autoreleasepool {
            block([NSString stringWithUTF8String:error.c_str()]);
        }
    }
private:
    void (^block)(NSString *);
};

class AppCoreCursorHandler: public CelestiaCore::CursorHandler
{
public:
    AppCoreCursorHandler(void (^block)(CursorShape)) : CelestiaCore::CursorHandler(), block(block), shape(CelestiaCore::ArrowCursor) {};

    void setCursorShape(CelestiaCore::CursorShape shape)
    {
        CelestiaCore::CursorShape oldShape = this->shape;
        if (oldShape != shape)
        {
            this->shape = shape;
            @autoreleasepool {
                block((CursorShape)shape);
            }
        }
    }

    CelestiaCore::CursorShape getCursorShape() const
    {
        return shape;
    }
private:
    void (^block)(CursorShape);
    CelestiaCore::CursorShape shape;
};

class AppCoreContextMenuHandler: public CelestiaCore::ContextMenuHandler
{
public:
    AppCoreContextMenuHandler(void (^block)(NSPoint, CelestiaSelection *)) : CelestiaCore::ContextMenuHandler(), block(block) {};

    void requestContextMenu(float x, float y, Selection sel)
    {
        @autoreleasepool {
            CelestiaSelection *selection = [[CelestiaSelection alloc] initWithSelection:sel];
            block(NSMakePoint(x, y), selection);
        }
    }
private:
    void (^block)(NSPoint, CelestiaSelection *);
};

@interface CelestiaAppCore () {
    AppCoreAlerter *alerter;
    AppCoreCursorHandler *cursorHandler;
    AppCoreContextMenuHandler *contextMenuHandler;
}

@end

@implementation CelestiaAppCore

// MARK: Initilalization
- (instancetype)init {
    self = [super init];
    if (self != nil) {
        _initialized = NO;
        core = new CelestiaCore;
        __weak CelestiaAppCore *weakSelf = self;
        alerter = new AppCoreAlerter(^(NSString *error) {
            [[weakSelf delegate] celestiaAppCoreFatalErrorHappened:error];
        });
        cursorHandler = new AppCoreCursorHandler(^(CursorShape shape) {
            [[weakSelf delegate] celestiaAppCoreCursorShapeChanged:shape];
        });
        contextMenuHandler = new AppCoreContextMenuHandler(^(CGPoint location, CelestiaSelection *selection) {
            [[weakSelf delegate] celestiaAppCoreCursorDidRequestContextMenuAtPoint:location withSelection:selection];
        });
        core->setAlerter(alerter);
        core->setCursorHandler(cursorHandler);
        core->setContextMenuHandler(contextMenuHandler);
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
    __block std::vector<fs::path> extras;
    [extraDirectories enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        extras.push_back([obj UTF8String]);
    }];

    bool success = core->initSimulation(configFile, extras, &watcher);
    if (success) {
        _initialized = YES;
    }
    return _initialized;
}

- (BOOL)startRenderer {
    BOOL success = core->initRenderer() ? YES : NO;

    // start with default values
    const int DEFAULT_ORBIT_MASK = Body::Planet | Body::Moon | Body::Stellar;
    const int DEFAULT_LABEL_MODE = 2176;
    const float DEFAULT_AMBIENT_LIGHT_LEVEL = 0.1f;
    const float DEFAULT_VISUAL_MAGNITUDE = 8.0f;
    const Renderer::StarStyle DEFAULT_STAR_STYLE = Renderer::FuzzyPointStars;
    const ColorTableType DEFAULT_STARS_COLOR = ColorTable_Blackbody_D65;
    const unsigned int DEFAULT_TEXTURE_RESOLUTION = medres;

    core->getRenderer()->setRenderFlags(Renderer::DefaultRenderFlags);
    core->getRenderer()->setOrbitMask(DEFAULT_ORBIT_MASK);
    core->getRenderer()->setLabelMode(DEFAULT_LABEL_MODE);
    core->getRenderer()->setAmbientLightLevel(DEFAULT_AMBIENT_LIGHT_LEVEL);
    core->getRenderer()->setStarStyle(DEFAULT_STAR_STYLE);
    core->getRenderer()->setResolution(DEFAULT_TEXTURE_RESOLUTION);
    core->getRenderer()->setStarColorTable(GetStarColorTable(DEFAULT_STARS_COLOR));

    core->getSimulation()->setFaintestVisible(DEFAULT_VISUAL_MAGNITUDE);

    core->getRenderer()->setSolarSystemMaxDistance((core->getConfig()->SolarSystemMaxDistance));

    return success;
}

- (void)setDPI:(NSInteger)dpi {
    core->setScreenDpi((int)dpi);
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

// MARK: Other
- (NSString *)currentURL {
    CelestiaState appState;
    appState.captureState(core);

    Url currentURL(appState, Url::CurrentVersion);
    return [NSString stringWithUTF8String:currentURL.getAsString().c_str()];
}

- (void)runScript:(NSString *)path {
    core->runScript([path UTF8String]);
}

- (void)goToURL:(NSString *)url {
    core->goToUrl([url UTF8String]);
}

- (BOOL)captureMovie:(NSString *)filePath withVideoSize:(CGSize)size fps:(float)fps {
    MovieCapture *movieCapture = new OggTheoraCapture(core->getRenderer());
    movieCapture->setAspectRatio(1, 1);
    bool ok = movieCapture->start([filePath UTF8String],
                                  size.width, size.height,
                                  fps);
    if (ok) {
        core->initMovieCapture(movieCapture);
    } else {
        delete movieCapture;
    }
    return ok ? YES : NO;
}

+ (void)setLocaleDirectory:(NSString *)localeDirectory {
    // Gettext integration
    setlocale(LC_ALL, "");
    setlocale(LC_NUMERIC, "C");
    bindtextdomain("celestia", [localeDirectory UTF8String]);
    bind_textdomain_codeset("celestia", "UTF-8");
    bindtextdomain("celestia_constellations", [localeDirectory UTF8String]);
    bind_textdomain_codeset("celestia_constellations", "UTF-8");
    textdomain("celestia");
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
    core->setAlerter(nullptr);
    core->setCursorHandler(nullptr);
    core->setContextMenuHandler(nullptr);
    delete alerter;
    delete cursorHandler;
    delete contextMenuHandler;
    delete core;
}

@end

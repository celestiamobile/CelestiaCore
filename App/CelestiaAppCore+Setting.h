//
//  CelestiaAppCore+Setting.h
//  CelestiaAppCore
//
//  Created by 李林峰 on 2019/8/9.
//  Copyright © 2019 李林峰. All rights reserved.
//

#import "CelestiaAppCore.h"

NS_ASSUME_NONNULL_BEGIN

@interface CelestiaAppCore (Setting)

// Time Settings

@property double time ;

@property NSInteger timeZone ;

@property double timeScale ;

@property BOOL synchTime;

// Gaze Settings

@property float fieldOfView ;

// situation

// Cruise Settings

// Velocity
// AngularVelocity

// Visibility Settings

@property BOOL showStars ;

@property BOOL showPlanets ;

@property BOOL showDwarfPlanets ;

@property BOOL showMoons ;

@property BOOL showMinorMoons ;

@property BOOL showAsteroids ;

@property BOOL showComets ;

@property BOOL showSpacecrafts ;

@property BOOL showOpenClusters ;

@property BOOL showGalaxies ;

@property BOOL showDiagrams ;

@property BOOL showCloudMaps ;

@property BOOL showOrbits ;

@property BOOL showCelestialSphere ;

@property BOOL showNightMaps ;

@property BOOL showAtmospheres ;

@property BOOL showSmoothLines ;

@property BOOL showEclipseShadows ;

@property BOOL showRingShadows ;

@property BOOL showCloudShadows ;

@property BOOL showBoundaries ;

@property BOOL showAutoMag ;

@property BOOL showCometTails ;

@property BOOL showPlanetRings ;

@property BOOL showMarkers ;

@property BOOL showPartialTrajectories ;

// Label Settings

// -(BOOL) showNoLabels ;
// -(void) setShowNoLabels: (BOOL) value ;

@property BOOL showStarLabels ;

@property BOOL showPlanetLabels ;

@property BOOL showMoonLabels ;

@property BOOL showConstellationLabels ;

@property BOOL showGalaxyLabels ;

@property BOOL showAsteroidLabels ;

@property BOOL showSpacecraftLabels ;

@property BOOL showLocationLabels ;

@property BOOL showCometLabels ;

// -(BOOL) showBodyLabels ;
// -(void) setShowBodyLabels: (BOOL) value ;

// Orbit Settings

@property BOOL showPlanetOrbits ;

@property BOOL showMoonOrbits ;

@property BOOL showAsteroidOrbits ;

@property BOOL showCometOrbits ;

@property BOOL showSpacecraftOrbits ;

@property BOOL showStellarOrbits ;

@property float minimumOrbitSize ;

// Location Visibility Settings

// Feature Settings

@property float minimumFeatureSize ;

// Lighting Settings

@property float ambientLightLevel ;

// Star Settings

@property float distanceLimit ;

@property float faintestVisible ;

@property NSInteger starStyle ;

// Texture Settings

@property NSInteger resolution;

- (void)initializeSetting;

- (NSNumber *)valueForTag:(NSInteger)tag;

- (NSInteger)tagForKey:(NSInteger)key;

- (NSInteger)integerValueForTag:(NSInteger)tag;
- (BOOL)boolValueForTag:(NSInteger)tag;
- (float)floatValueForTag:(NSInteger)tag;

- (void)setIntegerValue:(NSInteger)value forTag:(NSInteger) tag;
- (void)setFloatValue:(float)value forTag:(NSInteger) tag;
- (void)setBoolValue:(BOOL)value forTag:(NSInteger) tag;

- (void)loadUserDefaultsWithAppDefaultsAtPath:(nullable NSString *)path;
- (void)storeUserDefaults;

@end

NS_ASSUME_NONNULL_END

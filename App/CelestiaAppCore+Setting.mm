//
// CelestiaAppCore+Setting.mm
//
// Copyright © 2020 Celestia Development Team. All rights reserved.
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//

#include <celengine/body.h>
#include <celutil/flag.h>

#import "CelestiaAppCore+Private.h"
#import "CelestiaAppCore+Setting.h"
#import "CelestiaAppCore+Locale.h"
#import "CelestiaSelection.h"
#import "CelestiaBody.h"
#import "CelestiaUtil.h"

@implementation CelestiaAppCore (Setting)

- (id)valueForUndefinedKey:(NSString *)key {
#ifdef DEBUG
    if ( key ) NSLog(@"unbound value for %@", key);
#endif
    return nil;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
#ifdef DEBUG
    NSLog(@"unbound key set for %@", key);
#endif
}

- (void)setNilValueForKey:(NSString *)key {
#ifdef DEBUG
    NSLog(@"nil value for %@", key);
#endif
}

// Time Settings

- (double)time { return core->getSimulation()->getTime(); }
- (void)setTime:(double)value { core->getSimulation()->setTime(value); }

- (double)timeScale { return core->getSimulation()->getTimeScale(); }
- (void)setTimeScale:(double)value { core->getSimulation()->setTimeScale(value); }

- (BOOL)synchTime { return core->getSimulation()->getSyncTime(); }
- (void)setSynchTime:(BOOL)value { core->getSimulation()->setSyncTime(value); }

// Gaze Settings

- (float)fieldOfView { return core->getSimulation()->getObserver().getFOV(); }
- (void)setFieldOfView: (float)value { core->getSimulation()->getObserver().setFOV(value); }

// Observer Settings

// Cruise Settings

// Velocity
// AngularVelocity

- (uint64_t)setValue:(BOOL)value forBit:(uint64_t)bit inSet:(uint64_t)set {
    NSInteger result = value
    ? ((bit&set) ? set : (set|bit) )
    : ((bit&set) ?  (set^bit) : set);
    //    NSLog([NSString stringWithFormat: @"setValue %d forBit: %d inSet: %d = %d",value,bit,set,result]);
    //    NSLog([NSString stringWithFormat: @"bit was: %d bit is: %d ",(set&bit),(result&bit)]);
    return result;
}

// Visibility Settings

#define RENDERMETHODS(flag)  -(BOOL) show##flag { return (core->getRenderer()->getRenderFlags()&Renderer::Show##flag) != 0; } -(void) setShow##flag: (BOOL) value  { core->getRenderer()->setRenderFlags( [self setValue: value forBit: Renderer::Show##flag inSet: core->getRenderer()->getRenderFlags() ] ); }

RENDERMETHODS(Stars)
RENDERMETHODS(Planets)
RENDERMETHODS(DwarfPlanets)
RENDERMETHODS(Moons)
RENDERMETHODS(MinorMoons)
RENDERMETHODS(Asteroids)
RENDERMETHODS(Comets)
RENDERMETHODS(Spacecrafts)
RENDERMETHODS(Galaxies)
RENDERMETHODS(Globulars)
RENDERMETHODS(Nebulae)
RENDERMETHODS(OpenClusters)
RENDERMETHODS(Diagrams)
RENDERMETHODS(Boundaries)
RENDERMETHODS(CloudMaps)
RENDERMETHODS(NightMaps)
RENDERMETHODS(Atmospheres)
RENDERMETHODS(CometTails)
RENDERMETHODS(PlanetRings)
RENDERMETHODS(Markers)
RENDERMETHODS(Orbits)
RENDERMETHODS(FadingOrbits)
RENDERMETHODS(PartialTrajectories)
RENDERMETHODS(Ecliptic)
RENDERMETHODS(SmoothLines)
RENDERMETHODS(EclipseShadows)
RENDERMETHODS(RingShadows)
RENDERMETHODS(CloudShadows)
RENDERMETHODS(AutoMag)
RENDERMETHODS(CelestialSphere)
RENDERMETHODS(EclipticGrid)
RENDERMETHODS(HorizonGrid)
RENDERMETHODS(GalacticGrid)

// Label Settings

#define LABELMETHODS(flag)  -(BOOL) show##flag##Labels { return (core->getRenderer()->getLabelMode()&Renderer::flag##Labels) != 0; } -(void) setShow##flag##Labels : (BOOL) value  { core->getRenderer()->setLabelMode( (int)[self setValue: value forBit: Renderer::flag##Labels inSet: core->getRenderer()->getLabelMode()] ); }

LABELMETHODS(Star)
LABELMETHODS(Planet)
LABELMETHODS(Moon)
LABELMETHODS(Constellation)
LABELMETHODS(Galaxy)
LABELMETHODS(Globular)
LABELMETHODS(Nebula)
LABELMETHODS(OpenCluster)
LABELMETHODS(Asteroid)
LABELMETHODS(Spacecraft)
LABELMETHODS(Location)
LABELMETHODS(Comet)
LABELMETHODS(DwarfPlanet)
LABELMETHODS(MinorMoon)

- (BOOL)showLatinConstellationLabels {
    return (core->getRenderer()->getLabelMode() & Renderer::I18nConstellationLabels) == 0;
}
- (void)setShowLatinConstellationLabels:(BOOL)value {
    core->getRenderer()->setLabelMode( (int)[self setValue: (!value) forBit:  Renderer::I18nConstellationLabels inSet: core->getRenderer()->getLabelMode()] );
}

// Orbit Settings

#define ORBITMETHODS(flag)  -(BOOL) show##flag##Orbits { return (core->getRenderer()->getOrbitMask()&Body::flag) != 0; } -(void) setShow##flag##Orbits: (BOOL) value  { core->getRenderer()->setOrbitMask((int)[self setValue: value forBit: Body::flag inSet: core->getRenderer()->getOrbitMask()]); }

ORBITMETHODS(Planet)
ORBITMETHODS(Moon)
ORBITMETHODS(Asteroid)
ORBITMETHODS(Spacecraft)
ORBITMETHODS(Comet)
ORBITMETHODS(Stellar)
ORBITMETHODS(DwarfPlanet)
ORBITMETHODS(MinorMoon)


- (float)minimumOrbitSize { return core->getRenderer()->getMinimumOrbitSize(); }
- (void)setMinimumOrbitSize:(float)value { core->getRenderer()->setMinimumOrbitSize(value); }

// Feature Settings

#define FEATUREMETHODS(flag)  -(BOOL) show##flag##Labels { return (core->getSimulation()->getObserver().getLocationFilter()&Location::flag) != 0; } -(void) setShow##flag##Labels: (BOOL) value  { core->getSimulation()->getObserver().setLocationFilter([self setValue: value forBit: Location::flag inSet: (int)core->getSimulation()->getObserver().getLocationFilter()]); }

FEATUREMETHODS(City)
FEATUREMETHODS(Observatory)
FEATUREMETHODS(LandingSite)
FEATUREMETHODS(Crater)
FEATUREMETHODS(Vallis)
FEATUREMETHODS(Mons)
FEATUREMETHODS(Planum)
FEATUREMETHODS(Chasma)
FEATUREMETHODS(Patera)
FEATUREMETHODS(Mare)
FEATUREMETHODS(Rupes)
FEATUREMETHODS(Tessera)
FEATUREMETHODS(Regio)
FEATUREMETHODS(Chaos)
FEATUREMETHODS(Terra)
FEATUREMETHODS(Astrum)
FEATUREMETHODS(Corona)
FEATUREMETHODS(Dorsum)
FEATUREMETHODS(Fossa)
FEATUREMETHODS(Catena)
FEATUREMETHODS(Mensa)
FEATUREMETHODS(Rima)
FEATUREMETHODS(Undae)
FEATUREMETHODS(Reticulum)
FEATUREMETHODS(Planitia)
FEATUREMETHODS(Linea)
FEATUREMETHODS(Fluctus)
FEATUREMETHODS(Farrum)
FEATUREMETHODS(EruptiveCenter)
FEATUREMETHODS(Other)

- (float)minimumFeatureSize { return core->getRenderer()->getMinimumFeatureSize(); }
- (void)setMinimumFeatureSize:(float)value { core->getRenderer()->setMinimumFeatureSize(value); }

// Refmark Settings

- (BOOL)showBodyAxes {
    return core->referenceMarkEnabled("body axes");
}

- (void)setShowBodyAxes:(BOOL)value {
    core->toggleReferenceMark("body axes");
}

- (BOOL)showFrameAxes {
    return core->referenceMarkEnabled("frame axes");
}

- (void)setShowFrameAxes:(BOOL)value {
    core->toggleReferenceMark("frame axes");
}

- (BOOL)showSunDirection {
    return core->referenceMarkEnabled("sun direction");
}

- (void)setShowSunDirection:(BOOL)value {
    core->toggleReferenceMark("sun direction");
}

- (BOOL)showVelocityVector {
    return core->referenceMarkEnabled("velocity vector");
}

- (void)setShowVelocityVector:(BOOL)value {
    core->toggleReferenceMark("velocity vector");
}

- (BOOL)showPlanetographicGrid {
    return core->referenceMarkEnabled("planetographic grid");
}

- (void)setShowPlanetographicGrid:(BOOL)value {
    core->toggleReferenceMark("planetographic grid");
}

- (BOOL)showTerminator {
    return core->referenceMarkEnabled("terminator");
}

- (void)setShowTerminator:(BOOL)value {
    core->toggleReferenceMark("terminator");
}


// Lighting Settings

- (float)ambientLightLevel { return core->getRenderer()->getAmbientLightLevel(); }
- (void)setAmbientLightLevel:(float)value { core->getRenderer()->setAmbientLightLevel(value); }

- (float)galaxyBrightness { return Galaxy::getLightGain(); }
- (void)setGalaxyBrightness:(float)value { Galaxy::setLightGain(value); }

// Star Settings

- (float)distanceLimit { return core->getRenderer()->getDistanceLimit(); }
- (void)setDistanceLimit:(float)value { core->getRenderer()->setDistanceLimit(value); }

- (float)faintestVisible {
    //    return core->getSimulation()->getFaintestVisible();
    if ((core->getRenderer()->getRenderFlags() & Renderer::ShowAutoMag) == 0)
    {
        return core->getSimulation()->getFaintestVisible();
    }
    else
    {
        return core->getRenderer()->getFaintestAM45deg();
    }
}

- (void)setFaintestVisible:(float)value {
    if ((core->getRenderer()->getRenderFlags() & Renderer::ShowAutoMag) == 0)
    {
        core->setFaintest(value);
    }
    else
    {
        core->getRenderer()->setFaintestAM45deg(value);
        core->setFaintestAutoMag();
    }
}

- (NSInteger)starStyle { return core->getRenderer()->getStarStyle(); }
- (void)setStarStyle:(NSInteger)value { core->getRenderer()->setStarStyle((Renderer::StarStyle)value); }

- (NSInteger)starColors {
    return static_cast<NSInteger>(core->getRenderer()->getStarColorTable());
}

- (void)setStarColors:(NSInteger)starColors {
    core->getRenderer()->setStarColorTable(static_cast<ColorTableType>(starColors));
}

- (float)tintSaturation {
    return core->getRenderer()->getTintSaturation();
}

- (void)setTintSaturation:(float)tintSaturation {
    core->getRenderer()->setTintSaturation(tintSaturation);
}

// Texture Settings

- (NSInteger)resolution { return core->getRenderer()->getResolution(); }
- (void)setResolution:(NSInteger)value { core->getRenderer()->setResolution((int)value); }

// Overlay Settings

- (NSInteger)hudDetail { return core->getHudDetail(); }
- (void)setHudDetail:(NSInteger)value { core->setHudDetail((int)value); }

// Measurement Settings

- (CelestiaMeasurementSystem)measurementSystem { return (CelestiaMeasurementSystem)core->getMeasurementSystem(); }
- (void)setMeasurementSystem:(CelestiaMeasurementSystem)measurementSystem { return core->setMeasurementSystem((celestia::MeasurementSystem)measurementSystem); }

- (CelestiaTemperatureScale)temperatureScale { return (CelestiaTemperatureScale)core->getTemperatureScale(); }
- (void)setTemperatureScale:(CelestiaTemperatureScale)temperatureScale { return core->setTemperatureScale((celestia::TemperatureScale)temperatureScale); }

- (CelestiaScriptSystemAccessPolicy)scriptSystemAccessPolicy { return (CelestiaScriptSystemAccessPolicy)core->getScriptSystemAccessPolicy(); }
- (void)setScriptSystemAccessPolicy:(CelestiaScriptSystemAccessPolicy)scriptSystemAccessPolicy { return core->setScriptSystemAccessPolicy((CelestiaCore::ScriptSystemAccessPolicy)scriptSystemAccessPolicy); }

- (CelestiaLayoutDirection)layoutDirection { return static_cast<CelestiaLayoutDirection>(core->getLayoutDirection()); }
- (void)setLayoutDirection:(CelestiaLayoutDirection)layoutDirection { core->setLayoutDirection(static_cast<celestia::LayoutDirection>(layoutDirection)); }

#define INTERACTIONMETHODS(flag)  -(BOOL) enable##flag { return static_cast<BOOL>(celestia::util::is_set(core->getInteractionFlags(), CelestiaCore::InteractionFlags::flag)); } -(void) setEnable##flag: (BOOL) value  { auto flags = core->getInteractionFlags();celestia::util::set_or_unset(flags, CelestiaCore::InteractionFlags::flag, static_cast<bool>(value));core->setInteractionFlags(flags); }

INTERACTIONMETHODS(ReverseWheel);
INTERACTIONMETHODS(RayBasedDragging);
INTERACTIONMETHODS(FocusZooming);

- (CelestiaOverlayElements)overlayElements {
    return static_cast<CelestiaOverlayElements>(core->getOverlayElements());
}

- (void)setOverlayElements:(CelestiaOverlayElements)overlayElements {
    core->setOverlayElements(static_cast<celestia::HudElements>(overlayElements));
}

// Time settings

// Timezone values are inverted to maintain backward compatibility
- (NSInteger)timeZone { return core->getTimeZoneBias() == 0 ? 1 : 0; }

- (void)setTimeZone:(NSInteger)value {
    core->setTimeZoneBias(0 == value ? 1 : 0);
}

- (NSInteger)dateFormat { return core->getDateFormat(); }

- (void)setDateFormat:(NSInteger)value {
    core->setDateFormat(static_cast<celestia::astro::Date::Format>(value));
}

- (void)loadUserDefaults:(NSUserDefaults *)userDefaults withAppDefaultsAtPath:(nullable NSString *)path {
    NSDictionary* settingsDictionary = [self settingsWithUserDefaults:userDefaults appDefaultsAtPath:path];
    [settingsDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [self setValue:obj forKey:key];
    }];
}

- (NSDictionary *)settingsWithUserDefaults:(NSUserDefaults *)userDefaults appDefaultsAtPath:(NSString *)path {
    if (path == nil) return [NSDictionary dictionary];

    NSString *oldDefaultsKey = @"Celestia-1.4.0";
    NSDictionary *appDefs = [[[NSDictionary alloc] initWithContentsOfFile:path] objectForKey:oldDefaultsKey];
    if (appDefs == nil) return [NSDictionary dictionary];

    NSDictionary *oldUserDefs = [userDefaults objectForKey:oldDefaultsKey];

    NSMutableDictionary *settingsDictionary = [NSMutableDictionary dictionary];

    [appDefs enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        id customValue = [oldUserDefs objectForKey:key];
        if (customValue != nil)
            [userDefaults setObject:customValue forKey:key]; // Migration
        else
            customValue = [userDefaults objectForKey:key];

        if (customValue != nil)
            [settingsDictionary setObject:customValue forKey:key];
        else
            [settingsDictionary setObject:obj forKey:key];
    }];

    // Remove the old user defaults
    if (oldUserDefs != nil)
        [userDefaults setObject:nil forKey:oldDefaultsKey];

    return [settingsDictionary copy];
}

@end

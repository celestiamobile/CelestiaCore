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
#import "CelestiaAppCore+Private.h"
#import "CelestiaAppCore+Setting.h"
#import "CelestiaAppCore+Locale.h"
#import "CelestiaSelection.h"
#import "CelestiaBody.h"
#import "CelestiaUtil.h"

@implementation CelestiaAppCore (Setting)

static NSMutableDictionary* tagDict;
static NSArray* keyArray;

#define CS_DefaultsName @"Celestia-1.4.0"
#define CS_NUM_PREV_VERSIONS 1

#define TAGDEF(tag,key) key, [NSNumber numberWithInteger:tag],

static NSString *CS_PREV_VERSIONS[CS_NUM_PREV_VERSIONS] = {
    @"Celestia-1.3.2"
};

- (void)initializeSetting {
    tagDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
               //        TAGDEF(101,@"time")
               //        TAGDEF(999,@"timeScale")
               // render flags
               TAGDEF(400,@"showStars")
               TAGDEF(401,@"showPlanets")
               TAGDEF(418,@"showDwarfPlanets")
               TAGDEF(431,@"showMoons")
               TAGDEF(432,@"showMinorMoons")
               TAGDEF(433,@"showAsteroids")
               TAGDEF(434,@"showComets")
               TAGDEF(435,@"showSpacecrafts")
               TAGDEF(436,@"showOpenClusters")
               TAGDEF(402,@"showGalaxies")
               TAGDEF(430,@"showGlobulars")
               TAGDEF(417,@"showNebulae")
               TAGDEF(403,@"showDiagrams")
               TAGDEF(413,@"showBoundaries")
               TAGDEF(404,@"showCloudMaps")
               TAGDEF(407,@"showNightMaps")
               TAGDEF(408,@"showAtmospheres")
               TAGDEF(415,@"showCometTails")
               TAGDEF(437,@"showPlanetRings")
               TAGDEF(416,@"showMarkers")
               TAGDEF(405,@"showOrbits")
               TAGDEF(409,@"showSmoothLines")
               TAGDEF(410,@"showEclipseShadows")
               TAGDEF(412,@"showRingShadows")
               TAGDEF(419,@"showCloudShadows")
               TAGDEF(411,@"showFadingOrbits")
               TAGDEF(414,@"showAutoMag")
               TAGDEF(406,@"showCelestialSphere")
               TAGDEF(420,@"showEclipticGrid")
               TAGDEF(421,@"showHorizonGrid")
               TAGDEF(422,@"showGalacticGrid")
               TAGDEF(423,@"showPartialTrajectories")
               TAGDEF(425,@"showEcliptic")
               // object labels
               TAGDEF(500,@"showStarLabels")
               TAGDEF(501,@"showPlanetLabels")
               TAGDEF(502,@"showMoonLabels")
               TAGDEF(503,@"showConstellationLabels")
               TAGDEF(504,@"showGalaxyLabels")
               TAGDEF(514,@"showGlobularLabels")
               TAGDEF(505,@"showAsteroidLabels")
               TAGDEF(506,@"showSpacecraftLabels")
               TAGDEF(507,@"showLocationLabels")
               TAGDEF(508,@"showCometLabels")
               TAGDEF(509,@"showNebulaLabels")
               TAGDEF(510,@"showOpenClusterLabels")
               TAGDEF(511,@"showLatinConstellationLabels")
               TAGDEF(512,@"showDwarfPlanetLabels")
               TAGDEF(513,@"showMinorMoonLabels")
               // popups
               TAGDEF(610,@"hudDetail")
               TAGDEF(620,@"starStyle")
               TAGDEF(640,@"resolution")
               TAGDEF(650,@"timeZone")
               TAGDEF(660,@"dateFormat")
               TAGDEF(670,@"measurementSystem")
               TAGDEF(680,@"temperatureScale")
               TAGDEF(690,@"scriptSystemAccessPolicy")
               TAGDEF(691,@"starColors")
               // orbits
               //        TAGDEF(999,@"minimumOrbitSize")
               TAGDEF(700,@"showPlanetOrbits")
               TAGDEF(701,@"showMoonOrbits")
               TAGDEF(702,@"showAsteroidOrbits")
               TAGDEF(704,@"showSpacecraftOrbits")
               TAGDEF(703,@"showCometOrbits")
               TAGDEF(705,@"showStellarOrbits")
               TAGDEF(706,@"showDwarfPlanetOrbits")
               TAGDEF(707,@"showMinorMoonOrbits")
               // feature labels
               TAGDEF(903,@"minimumFeatureSize")
               TAGDEF(800,@"showCityLabels")
               TAGDEF(801,@"showObservatoryLabels")
               TAGDEF(802,@"showLandingSiteLabels")
               TAGDEF(803,@"showCraterLabels")
               TAGDEF(804,@"showVallisLabels")
               TAGDEF(805,@"showMonsLabels")
               TAGDEF(806,@"showPlanumLabels")
               TAGDEF(807,@"showChasmaLabels")
               TAGDEF(808,@"showPateraLabels")
               TAGDEF(809,@"showMareLabels")
               TAGDEF(810,@"showRupesLabels")
               TAGDEF(811,@"showTesseraLabels")
               TAGDEF(812,@"showRegioLabels")
               TAGDEF(813,@"showChaosLabels")
               TAGDEF(814,@"showTerraLabels")
               TAGDEF(815,@"showAstrumLabels")
               TAGDEF(816,@"showCoronaLabels")
               TAGDEF(817,@"showDorsumLabels")
               TAGDEF(818,@"showFossaLabels")
               TAGDEF(819,@"showCatenaLabels")
               TAGDEF(820,@"showMensaLabels")
               TAGDEF(821,@"showRimaLabels")
               TAGDEF(822,@"showUndaeLabels")
               TAGDEF(824,@"showReticulumLabels")
               TAGDEF(825,@"showPlanitiaLabels")
               TAGDEF(826,@"showLineaLabels")
               TAGDEF(827,@"showFluctusLabels")
               TAGDEF(828,@"showFarrumLabels")
               TAGDEF(829,@"showEruptiveCenterLabels")
               TAGDEF(831,@"showOtherLabels")
               // stars
               //        TAGDEF(999,@"distanceLimit")
               TAGDEF(900,@"ambientLightLevel")
               //        TAGDEF(901,@"brightnessBias")
               TAGDEF(902,@"faintestVisible")
               TAGDEF(904,@"galaxyBrightness")
               TAGDEF(905,@"tintSaturation")
               //        TAGDEF(999,@"saturationMagnitude")

               nil];
    keyArray = [tagDict allValues];

    NSDictionary *volatileTagDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                     TAGDEF(1000,@"showBodyAxes")
                                     TAGDEF(1001,@"showFrameAxes")
                                     TAGDEF(1002,@"showSunDirection")
                                     TAGDEF(1003,@"showVelocityVector")
                                     TAGDEF(1004,@"showPlanetographicGrid")
                                     TAGDEF(1005,@"showTerminator")
                                     nil];
    [tagDict addEntriesFromDictionary: volatileTagDict];
}

- (NSNumber *)valueForTag:(NSInteger)tag {
    return (NSNumber *)[self valueForKey: [tagDict objectForKey: [NSNumber numberWithInteger: tag] ] ];
}

- (void)setValue:(id)value forTag:(NSInteger)tag {
    id key = [tagDict objectForKey:[NSNumber numberWithInteger:tag]];
    if (key!= nil) {
        [self setValue:value forKey:key];
    }
}

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
- (void)setMeasurementSystem:(CelestiaMeasurementSystem)measurementSystem { return core->setMeasurementSystem((CelestiaCore::MeasurementSystem)measurementSystem); }

- (CelestiaTemperatureScale)temperatureScale { return (CelestiaTemperatureScale)core->getTemperatureScale(); }
- (void)setTemperatureScale:(CelestiaTemperatureScale)temperatureScale { return core->setTemperatureScale((CelestiaCore::TemperatureScale)temperatureScale); }

- (CelestiaScriptSystemAccessPolicy)scriptSystemAccessPolicy { return (CelestiaScriptSystemAccessPolicy)core->getScriptSystemAccessPolicy(); }
- (void)setScriptSystemAccessPolicy:(CelestiaScriptSystemAccessPolicy)scriptSystemAccessPolicy { return core->setScriptSystemAccessPolicy((CelestiaCore::ScriptSystemAccessPolicy)scriptSystemAccessPolicy); }

- (CelestiaLayoutDirection)layoutDirection { return static_cast<CelestiaLayoutDirection>(core->getLayoutDirection()); }
- (void)setLayoutDirection:(CelestiaLayoutDirection)layoutDirection { core->setLayoutDirection(static_cast<CelestiaCore::LayoutDirection>(layoutDirection)); }

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

- (NSInteger)tagForKey:(NSInteger)key {
    if ( key > 128 ) return key;
    NSInteger tag;
    switch (key)
    {
        case 112: tag = 501; break;  // LabelPlanets
        case 109: tag = 502; break;  // LabelMoons
        case 119: tag = 505; break;  // LabelAsteroids
        case  98: tag = 500; break;  // LabelStars
        case 101: tag = 504; break;  // LabelGalaxies
        case 110: tag = 506; break;  // LabelSpacecraft
        case  87: tag = 508; break;  // LabelComets
        case  61: tag = 503; break;  // LabelConstellations
        case 105: tag = 404; break;  // CloudMaps
        case   1: tag = 408; break;  // Atmospheres
        case  12: tag = 407; break;  // NightMaps
        case   5: tag = 410; break;  // EclipseShadows
        case 111: tag = 405; break;  // Orbits
        case 117: tag = 402; break;  // Galaxies
        case  47: tag = 403; break;  // Diagrams
        case   2: tag = 413; break;  // Boundaries
        case  59: tag = 406; break;  // CelestialSphere
        case  25: tag = 414; break;  // AutoMag
        case  20: tag = 415; break;  // CometTails
        case  11: tag = 416; break;  // Markers
        case  24: tag = 409; break;  // SmoothLines
        default : tag = key; break; // Special or not a setting
    }
    return tag;
}

- (NSInteger)integerValueForTag:(NSInteger)tag {
    tag = [self tagForKey:tag];

    if ( tag > 128 )
    {
        switch ( tag/100)
        {
            case 6:
                // 600s (popups)
                return [[self valueForTag:tag] integerValue];
        }
    }

    return 0;
}

- (BOOL)boolValueForTag:(NSInteger)tag {
    tag = [self tagForKey:tag];

    if ( tag > 128 )
    {
        switch ( tag/100)
        {
            case 4: case 5: case 7: case 8: case 10:
                // 400s, 500s, 700s, 800s, 1000s (checkboxes)
                return [[self valueForTag:tag] boolValue];
        }
    }

    return NO;
}

- (float)floatValueForTag:(NSInteger)tag {
    tag = [self tagForKey:tag];

    if ( tag > 128 )
    {
        switch ( tag/100)
        {
            case 9:
                return [[self valueForTag:tag] floatValue];
        }
    }

    return 0;
}


- (void)setIntegerValue:(NSInteger)value forTag:(NSInteger)tag {
    tag = [self tagForKey:tag];
    if ( tag <= 128 ) { core->charEntered(tag); return; }

    switch ( tag/100)
    {
        case 6: // 600
            // 600s (popups)
            [self setValue:[NSNumber numberWithInteger:value] forTag:tag];
            break;
    }
}

- (void)setFloatValue:(float)value forTag:(NSInteger)tag {
    tag = [self tagForKey:tag];
    if ( tag <= 128 ) { core->charEntered(tag); return; }

    switch ( tag/100)
    {
        case 9:
            return [self setValue:[NSNumber numberWithFloat:value] forTag:tag];
    }
}

- (void)setBoolValue:(BOOL)value forTag:(NSInteger)tag {
    tag = [self tagForKey:tag];
    if ( tag <= 128 ) { core->charEntered(tag); return; }

    if ( tag > 128 )
    {
        switch ( tag/100)
        {
            case 4: case 5: case 7: case 8: case 10:
                // 400s, 500s, 700s, 800s, 1000s (checkboxes)
                return [self setValue:[NSNumber numberWithBool:value] forTag:tag];
        }
    }
}

- (void)loadUserDefaults:(NSUserDefaults *)userDefaults withAppDefaultsAtPath:(nullable NSString *)path {
    NSDictionary* defaultsDictionary = [self findUserDefaultsWithUserDefaults:userDefaults appDefaultsAtPath:path];
    [defaultsDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [self setValue:obj forKey:key];
    }];
}

- (NSDictionary *)findUserDefaultsWithUserDefaults:(NSUserDefaults *)userDefaults appDefaultsAtPath:(NSString *)path {
    NSDictionary *appDefs = nil;
    if (path) { appDefs = [[[NSDictionary alloc] initWithContentsOfFile:path] objectForKey:CS_DefaultsName]; }
    NSDictionary *userDefs = [userDefaults objectForKey:CS_DefaultsName];
    if (userDefs == nil)
    {
        // Scan for older versions
        int i = 0;
        for (; i < CS_NUM_PREV_VERSIONS; ++i)
        {
            if ((userDefs = [userDefaults objectForKey:CS_PREV_VERSIONS[i]]))
                break;
        }

        if (userDefs)
            [self upgradeUserDefaults:userDefaults values:userDefs fromVersion:CS_PREV_VERSIONS[i]];
        else
            userDefs = appDefs;
    }

    if (appDefs)
        [userDefaults registerDefaults:[NSDictionary dictionaryWithObject:appDefs forKey:CS_DefaultsName]];
    return userDefs;
}

- (NSDictionary *)defaultsDictionary {
    NSMutableDictionary* theDictionary = [NSMutableDictionary dictionaryWithCapacity:[keyArray count]];
    NSEnumerator* keys = [keyArray objectEnumerator];
    id key;
    while ( nil != (key = [keys nextObject]) )
    {
        //                NSLog([NSString stringWithFormat: @"default dict entry %@ %@", key, [self valueForKey: key]]);
        [theDictionary setObject:[self valueForKey:key] forKey:key];
    }
    return theDictionary;
}

- (void)storeUserDefaults:(NSUserDefaults *)userDefaults {
    //        NSLog(@"storing user defaults");
    [userDefaults setObject:[self defaultsDictionary] forKey:CS_DefaultsName];
    [userDefaults synchronize];
    //        NSLog(@"stored user defaults");
}

-(void)upgradeUserDefaults:(NSUserDefaults *)userDefaults values:(NSDictionary *)values fromVersion:(NSString *)old {
    [userDefaults setObject:values forKey:CS_DefaultsName];
    [userDefaults removeObjectForKey:old];
    [userDefaults synchronize];
}

@end

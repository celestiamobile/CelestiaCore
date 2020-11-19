//
// CelestiaSimulation.h
//
// Copyright © 2020 Celestia Development Team. All rights reserved.
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//

#import <Foundation/Foundation.h>

@class CelestiaSelection;
@class CelestiaUniverse;
@class CelestiaUniversalCoord;
@class CelestiaObserver;
@class CelestiaEclipse;
@class CelestiaDestination;

typedef NS_ENUM(NSUInteger, SimulationCoordinateSystem) {
    SimulationCoordinateSystemUniversal = 0,
    SimulationCoordinateSystemEcliptical = 1,
    SimulationCoordinateSystemEquatorial = 2,
    SimulationCoordinateSystemBodyFixed = 3,
    SimulationCoordinateSystemPhaseLock = 5,
    SimulationCoordinateSystemChase = 6,
    SimulationCoordinateSystemPhaseLock_Old = 100,
    SimulationCoordinateSystemChase_Old = 101,
    SimulationCoordinateSystemObserverLocal = 200,
    SimulationCoordinateSystemUnknown = 1000,
};

typedef NS_ENUM(NSUInteger, SimulationDistanceUnit) {
    SimulationDistanceUnitKM = 0,
    SimulationDistanceUnitRadii = 1,
    SimulationDistanceUnitAU = 2,
};

NS_ASSUME_NONNULL_BEGIN

@interface CelestiaGoToLocation : NSObject

@property (readonly) CelestiaSelection *selection;
@property (readonly) double longitude;
@property (readonly) double latitude;
@property (readonly) double distance;
@property (readwrite) double duration;

- (instancetype)initWithSelection:(CelestiaSelection *)selection longitude:(double)longitude latitude:(double)latitude distance:(double)distance unit:(SimulationDistanceUnit)unit;
- (instancetype)initWithSelection:(CelestiaSelection *)selection longitude:(double)longitude latitude:(double)latitude;
- (instancetype)initWithSelection:(CelestiaSelection *)selection distance:(double)distance unit:(SimulationDistanceUnit)unit;
- (instancetype)initWithSelection:(CelestiaSelection *)selection;

@end

@interface CelestiaSimulation : NSObject

@property CelestiaSelection *selection;
@property NSDate *time;

@property (readonly) CelestiaObserver *activeObserver;

@property (nullable, readonly) CelestiaGoToLocation *currentLocation;

@property (readonly) CelestiaUniverse *universe;

- (CelestiaSelection *)findObjectFromPath:(NSString *)path NS_SWIFT_NAME(findObject(from:));

- (void)setFrame:(SimulationCoordinateSystem)coordinate target:(CelestiaSelection *)target reference:(CelestiaSelection *)reference NS_SWIFT_NAME(setFrame(coordinate:target:reference:));

- (void)reverseObserverOrientation;

- (void)goToLocation:(CelestiaGoToLocation *)location NS_SWIFT_NAME(go(to:));

- (void)goToEclipse:(CelestiaEclipse *)eclipse NS_SWIFT_NAME(goToEclipse(_:));

- (void)goToDestination:(CelestiaDestination *)destination NS_SWIFT_NAME(goToDestination(_:));

- (NSArray<NSString *> *)completionForName:(NSString *)name NS_SWIFT_NAME(completion(for:));

@end

NS_ASSUME_NONNULL_END

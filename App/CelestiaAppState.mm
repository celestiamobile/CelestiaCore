//
// CelestiaAppState.m
//
// Copyright © 2023 Celestia Development Team. All rights reserved.
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//

#import "CelestiaAppState+Private.h"
#import "CelestiaSelection+Private.h"
#import "CelestiaUtil.h"

@implementation CelestiaAppState

- (instancetype)initWithCore:(CelestiaCore *)core {
    self = [super init];
    if (self) {
        auto *sim = core->getSimulation();
        auto frame = sim->getFrame();

        _coordinateSystem = static_cast<CelestiaCoordinateSystem>(frame->getCoordinateSystem());
        if (_coordinateSystem != CelestiaCoordinateSystemUniversal) {
            _referenceObject = [[CelestiaSelection alloc] initWithSelection:frame->getRefObject()];
            if (_coordinateSystem == CelestiaCoordinateSystemPhaseLock)
                _targetObject = [[CelestiaSelection alloc] initWithSelection:frame->getTargetObject()];
            else
                _targetObject = [[CelestiaSelection alloc] init];
        } else {
            _referenceObject = [[CelestiaSelection alloc] init];
            _targetObject = [[CelestiaSelection alloc] init];
        }

        _speed = sim->getTargetSpeed();

        _time = [NSDate dateWithJulian:sim->getTime()];

        _trackedObject = [[CelestiaSelection alloc] initWithSelection:sim->getTrackedObject()];
        _selectedObject = [[CelestiaSelection alloc] initWithSelection:sim->getSelection()];

        _timeScale = static_cast<float>(sim->getTimeScale());
        _paused = static_cast<BOOL>(sim->getPauseState());
        _lightTravelDelayEnabled = static_cast<BOOL>(core->getLightDelayActive());
    }
    return self;
}

- (BOOL)isEqual:(id)object {
    if (![object isKindOfClass:[CelestiaAppState class]])
        return NO;
    CelestiaAppState *other = (CelestiaAppState *)object;
    if (![_time isEqualToDate:other.time])
        return NO;
    if (_speed != other.speed)
        return NO;
    if (_coordinateSystem != other.coordinateSystem)
        return NO;
    if (_timeScale != other.timeScale)
        return NO;
    if (_paused != other.paused)
        return NO;
    if (_lightTravelDelayEnabled != other.isLightTravelDelayEnabled)
        return NO;
    if (![_referenceObject isEqualToSelection:other.referenceObject])
        return NO;
    if (![_targetObject isEqualToSelection:other.targetObject])
        return NO;
    if (![_trackedObject isEqualToSelection:other.trackedObject])
        return NO;
    if (![_selectedObject isEqualToSelection:other.selectedObject])
        return NO;
    return YES;
}

@end

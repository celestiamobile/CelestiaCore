//
// CelestiaEclipseFinder.mm
//
// Copyright © 2020 Celestia Development Team. All rights reserved.
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//

#import "CelestiaUtil.h"
#import "CelestiaEclipseFinder.h"
#import "CelestiaBody+Private.h"
#include "celestia/eclipsefinder.h"

class EclipseSeacherWatcher;

@interface CelestiaEclipseFinder () {
    EclipseFinder *s;
    EclipseSeacherWatcher *d;
@public
    BOOL aborted;
}

@end

class EclipseSeacherWatcher: public EclipseFinderWatcher
{
public:
    EclipseSeacherWatcher(void *delegate) : EclipseFinderWatcher(), delegate(delegate) {}

    virtual Status eclipseFinderProgressUpdate(double t)
    {
        CelestiaEclipseFinder *searcher = (__bridge CelestiaEclipseFinder *)delegate;
        if (searcher->aborted) {
            return AbortOperation;
        }
        return ContinueOperation;
    };
private:
    void *delegate;
};

@implementation CelestiaEclipse

- (instancetype)initWithEclipse:(Eclipse *)eclipse {
    self = [super init];
    if (self) {
        _occulter = [[CelestiaBody alloc] initWithBody:eclipse->occulter];
        _receiver = [[CelestiaBody alloc] initWithBody:eclipse->receiver];
        _startTime = [NSDate dateWithJulian:eclipse->startTime];
        _endTime = [NSDate dateWithJulian:eclipse->endTime];
    }
    return self;
}

@end

@implementation CelestiaEclipseFinder

- (instancetype)initWithBody:(CelestiaBody *)body {
    self = [super init];
    if (self) {
        d = new EclipseSeacherWatcher((__bridge void *)self);
        s = new EclipseFinder([body body], d);
        aborted = YES;
    }
    return self;
}

- (NSArray<CelestiaEclipse *> *)search:(CelestiaEclipseKind)kind fromStart:(NSDate *)startTime toEnd:(NSDate *)endTime {
    aborted = NO;
    std::vector<Eclipse> results;
    s->findEclipses([startTime julianDay], [endTime julianDay], (int)kind, results);

    NSMutableArray *array = [NSMutableArray arrayWithCapacity:results.size()];
    for (Eclipse &result: results) {
        [array addObject:[[CelestiaEclipse alloc] initWithEclipse:&result]];
    }
    aborted = YES;
    return array;
}

- (void)abort {
    aborted = YES;
}

- (void)dealloc {
    delete s;
    delete d;
}

@end

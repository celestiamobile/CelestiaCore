//
//  CelestiaEclipseFinder.m
//  CelestiaCore
//
//  Created by 李林峰 on 2019/8/10.
//  Copyright © 2019 李林峰. All rights reserved.
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

@implementation EclipseResult

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

- (NSArray<EclipseResult *> *)search:(EclipseKind)kind fromStart:(NSDate *)startTime toEnd:(NSDate *)endTime {
    aborted = NO;
    std::vector<Eclipse> results;
    s->findEclipses([startTime julianDay], [endTime julianDay], (int)kind, results);

    NSMutableArray *array = [NSMutableArray arrayWithCapacity:results.size()];
    for (Eclipse &result: results) {
        [array addObject:[[EclipseResult alloc] initWithEclipse:&result]];
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

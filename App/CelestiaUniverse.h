//
// CelestiaUniverse.h
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
@class CelestiaDSOCatalog;
@class CelestiaStarCatalog;


typedef NS_ENUM(NSUInteger, CelestiaMarkerRepresentation) {
    CelestiaMarkerRepresentationDiamond    = 0,
    CelestiaMarkerRepresentationTriangle   = 1,
    CelestiaMarkerRepresentationSquare     = 2,
    CelestiaMarkerRepresentationFilledSquare = 3,
    CelestiaMarkerRepresentationPlus       = 4,
    CelestiaMarkerRepresentationX          = 5,
    CelestiaMarkerRepresentationLeftArrow  = 6,
    CelestiaMarkerRepresentationRightArrow = 7,
    CelestiaMarkerRepresentationUpArrow    = 8,
    CelestiaMarkerRepresentationDownArrow  = 9,
    CelestiaMarkerRepresentationCircle     = 10,
    CelestiaMarkerRepresentationDisk       = 11,
    CelestiaMarkerRepresentationCrosshair  = 12,
};

NS_ASSUME_NONNULL_BEGIN

@interface CelestiaUniverse : NSObject

@property (readonly) CelestiaDSOCatalog *dsoCatalog;
@property (readonly) CelestiaStarCatalog *starCatalog;

- (CelestiaSelection *)find:(NSString *)name;

- (NSString *)nameForSelection:(CelestiaSelection *)selection;

- (BOOL)isSelectionMarked:(CelestiaSelection *)selection NS_SWIFT_NAME(isMarked(_:));
- (void)markSelection:(CelestiaSelection *)selection withMarker:(CelestiaMarkerRepresentation)marker NS_SWIFT_NAME(mark(_:with:));
- (void)unmarkSelection:(CelestiaSelection *)selection NS_SWIFT_NAME(unmark(_:));
- (void)unmarkAll;

@end

NS_ASSUME_NONNULL_END

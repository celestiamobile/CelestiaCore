//
//  BrowserItem.h
//  celestia
//
//  Created by Da Woon Jung on 2007-11-26
//  Copyright (C) 2007, Celestia Development Team
//

#import <Foundation/Foundation.h>

@class CelestiaDSO;
@class CelestiaStar;
@class CelestiaBody;
@class CelestiaLocation;
@class CelestiaUniverse;

NS_ASSUME_NONNULL_BEGIN

@interface BrowserItem : NSObject
{
    id data;
    NSMutableDictionary *children;
    NSArray *childNames;
    BOOL childrenChanged;
}

@property (readonly) NSString *name;
@property (readonly) id body;
@property (readonly) NSUInteger childCount;
@property (readonly) NSArray<NSString *> *allChildNames;

- (instancetype)initWithDSO:      (CelestiaDSO *)aDSO;
- (instancetype)initWithStar:     (CelestiaStar *)aStar;
- (instancetype)initWithBody:     (CelestiaBody *)aBody;
- (instancetype)initWithLocation: (CelestiaLocation *)aLocation;
- (instancetype)initWithName:             (NSString *)aName;
- (instancetype)initWithName:             (NSString *)aName
                    children:             (NSDictionary<NSString *, BrowserItem *> *)aChildren;

+ (void)addChildrenIfAvailable:(BrowserItem *)item inUniverse:(CelestiaUniverse *)universe;
+ (BOOL)isLeaf:(BrowserItem *)item inUniverse:(CelestiaUniverse *)universe;

- (void)addChild:(BrowserItem *)aChild;
- (nullable BrowserItem *)childNamed: (NSString *)aName NS_SWIFT_NAME(child(with:));

@end

NS_ASSUME_NONNULL_END

//
//  CelestiaBrowserItem.h
//  CelestiaCore
//
//  Created by Li Linfeng on 13/8/2019.
//  Copyright © 2019 李林峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CelestiaCatEntry;

NS_ASSUME_NONNULL_BEGIN

@class CelestiaBrowserItem;

@protocol CelestiaBrowserItemChildrenProvider <NSObject>
- (nullable NSDictionary<NSString *, CelestiaBrowserItem *> *)childrenForBrowserItem:(CelestiaBrowserItem *)item;
@end

@interface CelestiaBrowserItem : NSObject

@property (nullable, readonly) NSString *name;
@property (nullable, readonly) CelestiaCatEntry *entry;
@property (readonly) NSArray<CelestiaBrowserItem *> *children;

- (instancetype)initWithCatEntry:(CelestiaCatEntry *)entry provider:(nullable id<CelestiaBrowserItemChildrenProvider>)provider;
- (instancetype)initWithName:(NSString *)aName provider:(nullable id<CelestiaBrowserItemChildrenProvider>)provider;

- (instancetype)initWithName:(NSString *)aName
                    children:(NSDictionary<NSString *, CelestiaBrowserItem *> *)children;

- (void)setChildren:(NSDictionary<NSString *, CelestiaBrowserItem *> *)children;

- (nullable NSString *)childNameAt:(NSInteger)index NS_SWIFT_NAME(childName(at:));
- (nullable CelestiaBrowserItem *)childNamed: (NSString *)aName NS_SWIFT_NAME(child(with:));

@end

NS_ASSUME_NONNULL_END

//
//  CelestiaDSO.mm
//  celestia
//
//  Created by Da Woon Jung on 12/30/06.
//  Copyright 2006 Chris Laurel. All rights reserved.
//

#import "CelestiaDSO+Private.h"
#import "CelestiaCatEntry+Private.h"

@implementation CelestiaDSO (Private)

- (instancetype)initWithDSO:(DeepSkyObject *)aDSO
{
    self = [super initWithCatEntry:reinterpret_cast<CatEntry *>(aDSO)];
    return self;
}

- (DeepSkyObject *)DSO {
    return reinterpret_cast<DeepSkyObject *>([self entry]);
}

@end

@implementation CelestiaDSO

- (NSString *)type
{
    return [NSString stringWithUTF8String:[self DSO]->getType()];
}

@end

//
//  CelestiaDSO.mm
//  celestia
//
//  Created by Da Woon Jung on 12/30/06.
//  Copyright 2006 Chris Laurel. All rights reserved.
//

#import "CelestiaDSO+Private.h"
#import "CelestiaAstroObject+Private.h"
#import "CelestiaVector+Private.h"
#import "CelestiaUtil.h"

@implementation CelestiaDSO (Private)

- (instancetype)initWithDSO:(DeepSkyObject *)aDSO {
    self = [super initWithObject:reinterpret_cast<AstroObject *>(aDSO)];
    return self;
}

- (DeepSkyObject *)DSO {
    return reinterpret_cast<DeepSkyObject *>([self object]);
}

@end

@implementation CelestiaDSO

- (NSString *)type {
    return [NSString stringWithUTF8String:[self DSO]->getType()];
}

- (NSString *)webInfoURL {
    return [NSString stringWithUTF8String:[self DSO]->getInfoURL().c_str()];
}

- (CelestiaVector *)position {
    return [CelestiaVector vectorWithVector3d:[self DSO]->getPosition()];
}

@end

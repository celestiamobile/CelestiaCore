//
//  CelestiaScript.mm
//  CelestiaCore
//
//  Created by 李林峰 on 2019/8/12.
//  Copyright © 2019 李林峰. All rights reserved.
//

#import "CelestiaScript.h"
#import "celestia/scriptmenu.h"

@implementation CelestiaScript

- (instancetype)initWithItem:(ScriptMenuItem)item {
    self = [super init];
    if (self) {
        _filename = [NSString stringWithUTF8String:item.filename.c_str()];
        _title = [NSString stringWithUTF8String:item.title.c_str()];
    }
    return self;
}

+ (NSArray *)scriptsInDirectory:(NSString *)directory deepScan:(BOOL)deep {
    std::vector<ScriptMenuItem>* result = ScanScriptsDirectory([directory UTF8String], deep ? true : false);
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:result->size()];

    for (NSInteger i = 0; i < result->size(); i++) {
        [array addObject:[[CelestiaScript alloc] initWithItem:(*result)[i]]];
    }

    delete result;
    return array;
}

@end

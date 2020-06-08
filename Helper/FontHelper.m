//
//  FontHelper.m
//  CelestiaCore
//
//  Created by 李林峰 on 2020/6/8.
//  Copyright © 2019 李林峰. All rights reserved.
//

#import "FontHelper.h"

@implementation FallbackFont

- (instancetype)initWithFilePath:(NSString *)filePath collectionIndex:(NSInteger)collectionIndex {
    self = [super init];
    if (self) {
        _filePath = filePath;
        _collectionIndex = collectionIndex;
    }
    return self;
}

@end

FallbackFont *GetFontForLocale(NSString *locale, CTFontUIFontType fontType)
{
    // Probe to find font
    NSString *c = @"a";
    if ([locale isEqualToString:@"zh_CN"] || [locale isEqualToString:@"zh_TW"] || [locale isEqualToString:@"ja"])
        c = @"一";
    else if ([locale isEqualToString:@"ko"])
        c = @"가";

    NSString *fontPath = nil;
    NSInteger collectionIndex = 0;
    CTFontRef defaultFont = CTFontCreateUIFontForLanguage(fontType, 0, nil);
    if (defaultFont)
    {
        CTFontRef fb = CTFontCreateForStringWithLanguage(defaultFont, (CFStringRef)c, CFRangeMake(0, 1), NULL);
        if (fb)
        {
            CFURLRef url = (CFURLRef)CTFontCopyAttribute(fb, kCTFontURLAttribute); // Font path
            CFStringRef name = (CFStringRef)CTFontCopyAttribute(fb, kCTFontNameAttribute); // Font name
            if (url && name)
            {
                CFStringRef urlString = CFURLCreateStringByReplacingPercentEscapes(CFAllocatorGetDefault(), CFURLCopyPath(url), CFSTR(""));
                fontPath = (__bridge NSString *)urlString;
                // Find index in the font file
                CFArrayRef fontDescs = CTFontManagerCreateFontDescriptorsFromURL(url);
                CFIndex count = CFArrayGetCount(fontDescs);
                for (CFIndex i = 0; i < count; i++)
                {
                    CTFontDescriptorRef des = (CTFontDescriptorRef)CFArrayGetValueAtIndex(fontDescs, i);
                    CFStringRef currentName = (CFStringRef)CTFontDescriptorCopyAttribute(des, kCTFontNameAttribute);
                    if (CFStringCompare(name, currentName, 0) == kCFCompareEqualTo)
                    {
                        collectionIndex = i;
                        break;
                    }
                }
                if ([fontPath hasSuffix:@"ttf"])
                    collectionIndex = collectionIndex << 16;  // This is a variation
                CFRelease(fontDescs);
                CFRelease(urlString);
            }
            CFRelease(fb);
        }
        CFRelease(defaultFont);
    }
    if (fontPath != nil)
        return [[FallbackFont alloc] initWithFilePath:fontPath collectionIndex:collectionIndex];
    return nil;
}

//
//  FontHelper.m
//  CelestiaCore
//
//  Created by 李林峰 on 2020/6/8.
//  Copyright © 2019 李林峰. All rights reserved.
//

#import "FontHelper.h"
#include <CoreText/CoreText.h>

extern CTFontRef CTFontCreateForCharactersWithLanguage(CTFontRef currentFont, const UTF16Char *characters, CFIndex length, CFStringRef language, CFIndex *coveredLength);
extern CTFontDescriptorRef CTFontDescriptorCreateForUIType(CTFontUIFontType, CGFloat size, CFStringRef language);

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

FallbackFont *GetFontForLocale(NSString *locale)
{
    // Probe to find font
    UniChar c = 0x0061; // a
    if ([locale isEqualToString:@"zh_CN"] || [locale isEqualToString:@"zh_TW"] || [locale isEqualToString:@"ja"])
        c = 0x4E00; // 一 A common character in Japanese and Chinese.
    else if ([locale isEqualToString:@"ko"])
        c = 0xAC00; // 가

    NSString *fontPath = nil;
    NSInteger collectionIndex = 0;

    CTFontDescriptorRef defaultFontDes = CTFontDescriptorCreateForUIType(kCTFontUIFontSystem, 0, NULL);
    if (defaultFontDes)
    {
        CTFontRef defaultFont = CTFontCreateWithFontDescriptor(defaultFontDes, 0, NULL);
        CTFontRef fb = CTFontCreateForCharactersWithLanguage(defaultFont, &c, 1, NULL, NULL);
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
                CFRelease(fontDescs);
                CFRelease(urlString);
            }
            CFRelease(fb);
        }
        CFRelease(defaultFont);
        CFRelease(defaultFontDes);
    }
    if (fontPath != nil)
        return [[FallbackFont alloc] initWithFilePath:fontPath collectionIndex:collectionIndex];
    return nil;
}

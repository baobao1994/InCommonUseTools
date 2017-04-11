//
//  NSString+Addition.m
//  TigerLottery
//
//  Created by Legolas on 14/12/9.
//  Copyright (c) 2014年 adcocoa. All rights reserved.
//

#import "NSString+Addition.h"

@implementation NSString (Addition)

- (CGSize)adaptSizeWithFont:(UIFont *)font {
    CGSize size;
    if ([self respondsToSelector:@selector(sizeWithAttributes:)]) {
        size = [self sizeWithAttributes:@{NSFontAttributeName : font}];
    }else {
        size = [self sizeWithFont:font];
    }
    return size;
}

- (CGSize)adaptSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size {
    return [self adaptSizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
}

- (CGSize)adaptSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)mode {
    CGSize adaptSize;
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineBreakMode:mode];
        adaptSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : font, NSParagraphStyleAttributeName : style} context:nil].size;
    }else {
        adaptSize = [self sizeWithFont:font constrainedToSize:size lineBreakMode:mode];
    }
    return adaptSize;
}

- (NSMutableAttributedString *)colorAttributedString {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    NSString *scannerStr = [NSString stringWithString:self];
    NSScanner *scanner = [NSScanner scannerWithString:scannerStr];
    NSString *text;
    NSString *color;
    NSInteger location = 0;
    while (![scanner isAtEnd]) {
        [scanner scanUpToString:@"<color='" intoString:NULL];
        [scanner scanString:@"<color='" intoString:NULL];
        [scanner scanUpToString:@"'>" intoString:&color];
        [scanner scanString:@"'>" intoString:NULL];
        [scanner scanUpToString:@"</color>" intoString:&text];
        NSString *colorText = [NSString stringWithFormat:@"<color='%@'>%@</color>", color, text];
        if (colorText) {
            NSRange textRange = [scannerStr rangeOfString:colorText options:NSCaseInsensitiveSearch];
            if (textRange.location != NSNotFound) {
                location += textRange.location;
                
                NSMutableAttributedString *colorStr = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName : UIColorFromHexColor(strtoul([color UTF8String], 0, 16))}];
                [attributedString replaceCharactersInRange:NSMakeRange(location, textRange.length) withAttributedString:colorStr];
                location += text.length;
                scannerStr = [scannerStr substringFromIndex:textRange.location + textRange.length];
            }else {
                break;
            }
        }else {
            break;
        }
    }
    return attributedString;
}

+ (NSMutableAttributedString *)attributedStringWithSeparatedStrings:(NSArray *)separators trailingStrings:(NSArray *)trailings color:(UIColor *)color {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    for (int i = 0; i < separators.count; i++) {
        NSString *separator = [separators objectAtIndex:i];
        NSString *trailing = [trailings objectAtIndex:i];
        NSString *scannerStr = [NSString stringWithString:self];
        NSScanner *scanner = [NSScanner scannerWithString:scannerStr];
        NSString *colorText;
        NSInteger location = 0;
        while (![scanner isAtEnd]) {
            [scanner scanUpToString:separator intoString:NULL];
            [scanner scanString:separator intoString:NULL];
            [scanner scanUpToString:trailing intoString:&colorText];
            if (colorText) {
                NSRange textRange = [scannerStr rangeOfString:[NSString stringWithFormat:@"%@%@%@", separator, colorText, trailing] options:NSCaseInsensitiveSearch];
                if (textRange.location != NSNotFound) {
                    location += textRange.location;
                    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(location, textRange.length)];
                    location += textRange.length;
                    scannerStr = [scannerStr substringFromIndex:textRange.location + textRange.length];
                }else {
                    break;
                }
            }else {
                break;
            }
        }
    }
    
    return attributedString;
}

- (NSMutableAttributedString *)attributedStringWithSeparatedString:(NSString *)separator trailingString:(NSString *)trailing color:(UIColor *)color {
    NSMutableAttributedString *attributedString = [self attributedStringWithSeparatedStrings:@[separator] trailingStrings:@[trailing] color:color];
    return attributedString;
}

- (NSMutableAttributedString *)attributedStringWithSubString:(NSString *)subString color:(UIColor *)color font:(UIFont *)font {
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:self];
    NSRange range = [self rangeOfString:subString options:NSCaseInsensitiveSearch];
    if (color) {
        [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    }
    if (font) {
        [attributedStr addAttribute:NSFontAttributeName value:font range:range];
    }
    return attributedStr;
}

@end

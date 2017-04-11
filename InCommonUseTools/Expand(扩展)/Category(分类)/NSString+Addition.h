//
//  NSString+Addition.h
//  TigerLottery
//
//  Created by Legolas on 14/12/9.
//  Copyright (c) 2014年 adcocoa. All rights reserved.
//

@interface NSString (Addition)

- (CGSize)adaptSizeWithFont:(UIFont *)font;
- (CGSize)adaptSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGSize)adaptSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)mode;

- (NSMutableAttributedString *)colorAttributedString;
- (NSMutableAttributedString *)attributedStringWithSeparatedString:(NSString *)separator trailingString:(NSString *)trailing color:(UIColor *)color;
- (NSMutableAttributedString *)attributedStringWithSeparatedStrings:(NSArray *)separators trailingStrings:(NSArray *)trailings color:(UIColor *)color;
- (NSMutableAttributedString *)attributedStringWithSubString:(NSString *)subString color:(UIColor *)color font:(UIFont *)font;

@end

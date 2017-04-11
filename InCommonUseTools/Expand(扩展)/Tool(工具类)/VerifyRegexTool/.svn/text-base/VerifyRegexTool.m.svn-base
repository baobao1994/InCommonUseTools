//
//  VerifyRegexTool.m
//  TigerLottery
//
//  Created by Legolas on 16/7/15.
//  Copyright © 2016年 adcocoa. All rights reserved.
//

#import "VerifyRegexTool.h"

@implementation VerifyRegexTool

+ (BOOL)verifyIDCardNumber:(NSString *)number {
    number = [number stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([number length] != 18) {
        return NO;
    }
    NSString *mmdd = @"(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))";
    NSString *leapMmdd = @"0229";
    NSString *year = @"(19|20)[0-9]{2}";
    NSString *leapYear = @"(19|20)(0[48]|[2468][048]|[13579][26])";
    NSString *yearMmdd = [NSString stringWithFormat:@"%@%@", year, mmdd];
    NSString *leapyearMmdd = [NSString stringWithFormat:@"%@%@", leapYear, leapMmdd];
    NSString *yyyyMmdd = [NSString stringWithFormat:@"((%@)|(%@)|(%@))", yearMmdd, leapyearMmdd, @"20000229"];
    NSString *area = @"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}";
    NSString *regex = [NSString stringWithFormat:@"%@%@%@", area, yyyyMmdd  , @"[0-9]{3}[0-9Xx]"];
    
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![regexTest evaluateWithObject:number]) {
        return NO;
    }
    int summary = ([number substringWithRange:NSMakeRange(0,1)].intValue + [number substringWithRange:NSMakeRange(10,1)].intValue) *7
    + ([number substringWithRange:NSMakeRange(1,1)].intValue + [number substringWithRange:NSMakeRange(11,1)].intValue) *9
    + ([number substringWithRange:NSMakeRange(2,1)].intValue + [number substringWithRange:NSMakeRange(12,1)].intValue) *10
    + ([number substringWithRange:NSMakeRange(3,1)].intValue + [number substringWithRange:NSMakeRange(13,1)].intValue) *5
    + ([number substringWithRange:NSMakeRange(4,1)].intValue + [number substringWithRange:NSMakeRange(14,1)].intValue) *8
    + ([number substringWithRange:NSMakeRange(5,1)].intValue + [number substringWithRange:NSMakeRange(15,1)].intValue) *4
    + ([number substringWithRange:NSMakeRange(6,1)].intValue + [number substringWithRange:NSMakeRange(16,1)].intValue) *2
    + [number substringWithRange:NSMakeRange(7,1)].intValue *1 + [number substringWithRange:NSMakeRange(8,1)].intValue *6
    + [number substringWithRange:NSMakeRange(9,1)].intValue *3;
    NSInteger remainder = summary % 11;
    NSString *checkBit = @"";
    NSString *checkString = @"10X98765432";
    checkBit = [checkString substringWithRange:NSMakeRange(remainder,1)];// 判断校验位
    return [checkBit isEqualToString:[[number substringWithRange:NSMakeRange(17,1)] uppercaseString]];
}

@end

//
//  NSDate+Addition.m
//  TigerLottery
//
//  Created by Legolas on 14/12/10.
//  Copyright (c) 2014年 adcocoa. All rights reserved.
//

#import "NSDate+Addition.h"

@implementation NSDate (Addition)

- (NSString *)weekDay {
    NSDateComponents *components = [[NSCalendar autoupdatingCurrentCalendar] components:NSWeekdayCalendarUnit fromDate:self];
    NSInteger weekday = [components weekday];
    NSDictionary *weekdayDic = @{@(1) : @"星期日",
                                 @(2) : @"星期一",
                                 @(3) : @"星期二",
                                 @(4) : @"星期三",
                                 @(5) : @"星期四",
                                 @(6) : @"星期五",
                                 @(7) : @"星期六"};
    return [weekdayDic objectForKey:@(weekday)];
}

- (NSString *)formateDate:(NSString *)formate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formate];
    NSString *date = [dateFormatter stringFromDate:self];
    return date;
}

+ (CGFloat)differHourWithBeginTime:(NSTimeInterval)beginTime andEndTime:(NSTimeInterval)endTime {
    CGFloat hour = 0;
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:beginTime];
    NSString *beginTimeString = [dateFormatter stringFromDate:date];
    date = [NSDate dateWithTimeIntervalSince1970:endTime];
    NSString *endTimeString = [dateFormatter stringFromDate:date];
    NSDate *begin = [dateFormatter dateFromString:beginTimeString];
    NSDate *end = [dateFormatter dateFromString:endTimeString];
    NSTimeInterval value = [end timeIntervalSinceDate:begin];
    hour = value / 3600.0;
    return hour;
}

@end

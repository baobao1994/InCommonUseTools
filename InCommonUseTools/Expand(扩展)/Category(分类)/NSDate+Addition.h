//
//  NSDate+Addition.h
//  TigerLottery
//
//  Created by Legolas on 14/12/10.
//  Copyright (c) 2014年 adcocoa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Addition)

- (NSString *)weekDay;
- (NSString *)formateDate:(NSString *)formate;
+ (CGFloat)differHourWithBeginTime:(NSTimeInterval)beginTime andEndTime:(NSTimeInterval)endTime;

@end

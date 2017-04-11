//
//  WinMessage.h
//  TigerLottery
//
//  Created by Legolas on 16/8/1.
//  Copyright © 2016年 adcocoa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WinMessage : NSObject

@property (nonatomic, assign) NSInteger messageId;
@property (nonatomic, assign) NSInteger lotteryId;
@property (nonatomic, copy) NSString *content;

- (id)initWithDictionary:(NSDictionary *)dic;

@end

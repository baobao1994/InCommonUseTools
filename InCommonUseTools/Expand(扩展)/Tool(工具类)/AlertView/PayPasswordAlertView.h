//
//  PayPasswordAlertView.h
//  TigerLottery
//
//  Created by Legolas on 14/12/17.
//  Copyright (c) 2014年 adcocoa. All rights reserved.
//

@protocol PayPasswordAlertViewDelegate;

@interface PayPasswordAlertView : NSObject

@property (nonatomic, assign) id <PayPasswordAlertViewDelegate> delegate;

+ (PayPasswordAlertView *)shareInstance;
- (void)showWithTitle:(NSString *)title;
- (void)close;
- (void)cleanAllWord;
- (void)setupErrorMessage:(NSString *)message;

@end

@protocol PayPasswordAlertViewDelegate <NSObject>

- (void)didEnterPayPassword:(NSString *)payPassword;

@end
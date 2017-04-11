//
//  PayAlertView.h
//  TigerLottery
//
//  Created by Legolas on 14/12/17.
//  Copyright (c) 2014年 adcocoa. All rights reserved.
//

@protocol PayPasswordViewDelegate;

@interface PayPasswordView : UIView

@property (nonatomic, assign) id <PayPasswordViewDelegate> delegate;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *errorLabel;
@property (nonatomic, weak) IBOutlet UIButton *closeBtn;

- (void)cleanAllWord;
- (void)resignAllFirstResponder;

@end

@protocol PayPasswordViewDelegate <NSObject>

- (void)didEnterPayPassword:(NSString *)payPassword;

@end
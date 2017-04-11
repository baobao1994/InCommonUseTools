//
//  PayAlertView.m
//  TigerLottery
//
//  Created by Legolas on 14/12/17.
//  Copyright (c) 2014年 adcocoa. All rights reserved.
//

#import "PayPasswordView.h"

#define kPayPasswordFieldTag 100
#define kPasswordCount 6

@interface PayPasswordView () <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *firstField;
@property (nonatomic, weak) IBOutlet UIImageView *firstImg;
@property (nonatomic, weak) IBOutlet UIImageView *secondImg;
@property (nonatomic, weak) IBOutlet UIImageView *thirdImg;
@property (nonatomic, weak) IBOutlet UIImageView *fourthImg;
@property (nonatomic, weak) IBOutlet UIImageView *fifthImg;
@property (nonatomic, weak) IBOutlet UIImageView *sixthImg;

@end


@implementation PayPasswordView 

#pragma mark - Public Method

- (void)cleanAllWord {
    _firstField.text = @"";
    _firstImg.hidden = YES;
    _secondImg.hidden = YES;
    _thirdImg.hidden = YES;
    _fourthImg.hidden = YES;
    _fifthImg.hidden = YES;
    _sixthImg.hidden = YES;
    [_firstField becomeFirstResponder];
}

- (void)resignAllFirstResponder {
    [_firstField resignFirstResponder];
}

#pragma mark - UITextFieldDelegate

- (IBAction)didChangeText:(UITextField *)sender {
    _errorLabel.text = @"";
    for (int i = 0; i < kPasswordCount; i++) {
        UIImageView *img = (UIImageView *)[self viewWithTag:kPayPasswordFieldTag + i];
        img.hidden = (i >= sender.text.length);
    }
    
    if (_firstField.text.length >= kPasswordCount) {
        DELEGATE_CALLBACK_ONE_PARAMETER(_delegate, @selector(didEnterPayPassword:), _firstField.text);
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    BOOL isValidate = (range.location < kPasswordCount);
    return isValidate;
}

@end

//
//  UIViewController+PadNumKeyboard.m
//  TigerLottery
//
//  Created by Legolas on 16/1/5.
//  Copyright © 2016年 adcocoa. All rights reserved.
//

#import <objc/runtime.h>
#import "UIViewController+PadNumKeyboard.h"

static const NSString *DoneInKeyboardButtonKey = @"doneInKeyboardButton";

@implementation UIViewController(PadNumKeyboard)

@dynamic doneInKeyboardButton;

- (void)addKeyboardObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardDidShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)removeKeyboardObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)handleKeyboardDidShow:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    CGRect begin = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect end = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (begin.size.height > 0 && begin.origin.y - end.origin.y > 0) {
        CGFloat padNumKeyboardHeight = end.size.height;
        if (padNumKeyboardHeight <= 216) {
            CGFloat animationDuration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
            UIViewAnimationCurve animationCurve = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
            [self editingDidBegin];
            if (self.doneInKeyboardButton) {
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationDuration:animationDuration];
                [UIView setAnimationCurve:animationCurve];
                self.doneInKeyboardButton.transform = CGAffineTransformTranslate(self.doneInKeyboardButton.transform, 0, -53);
                [UIView commitAnimations];
            }
            if ([self respondsToSelector:@selector(resizeWithKeyboardHeight:)]) {
                NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
                CGRect keyBoardRect = [value CGRectValue];
                [self resizeWithKeyboardHeight:keyBoardRect.size.height];
            }
        }
    }
}

- (void)handleKeyboardWillHide:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    CGFloat padNumKeyboardHeight = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    if (padNumKeyboardHeight <= 216) {
        CGFloat animationDuration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
        if (self.doneInKeyboardButton.superview) {
            [UIView animateWithDuration:animationDuration animations:^{
                self.doneInKeyboardButton.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                [self.doneInKeyboardButton removeFromSuperview];
            }];
        }
        if ([self respondsToSelector:@selector(resizeWithKeyboardHeight:)]) {
            [self resizeWithKeyboardHeight:0];
        }
    }
}

- (void)editingDidBegin {
    [self configDoneInKeyBoardButton];
}

- (void)configDoneInKeyBoardButton {
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    if (self.doneInKeyboardButton == nil) {
        self.doneInKeyboardButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.doneInKeyboardButton setTitle:@"完成" forState:UIControlStateNormal];
        [self.doneInKeyboardButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.doneInKeyboardButton.frame = CGRectMake(0, screenHeight, 106, 53);
        self.doneInKeyboardButton.adjustsImageWhenHighlighted = NO;
        [self.doneInKeyboardButton addTarget:self action:@selector(finishAction) forControlEvents:UIControlEventTouchUpInside];
    }
    self.doneInKeyboardButton.frame = CGRectMake(0, screenHeight, 106, 53);
    [self performSelector:@selector(addDoneButton) withObject:nil afterDelay:0.0f];
}

- (void)addDoneButton {
    UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] lastObject];
    [tempWindow addSubview:self.doneInKeyboardButton];
}

- (void)finishAction {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

#pragma mark - Private Method

- (UIButton *)doneInKeyboardButton {
    return objc_getAssociatedObject(self, &DoneInKeyboardButtonKey);
}

- (void)setDoneInKeyboardButton:(UIButton *)doneInKeyboardButton {
    objc_setAssociatedObject(self, &DoneInKeyboardButtonKey, doneInKeyboardButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

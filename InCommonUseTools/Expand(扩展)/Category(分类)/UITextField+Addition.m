//
//  UITextField+Addition.m
//  Lemon
//
//  Created by Legolas on 13-12-27.
//  Copyright (c) 2013年 Adcocoa. All rights reserved.
//

#import "UITextField+Addition.h"

@implementation UITextField (Addition)

- (void)addKeyboardButtonsWithNextTitle:(NSString *)nextTitle doneTitle:(NSString *)doneTitle target:(id)target nextAction:(SEL)nextAction doneAction:(SEL)doneAction {
    UIToolbar *topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 36)];
    [topView setBarStyle:UIBarStyleDefault];
    
    UIBarButtonItem *btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc]initWithTitle:nextTitle style:UIBarButtonItemStyleBordered target:target action:nextAction];
    
    UIBarButtonItem * doneButton = nil;
    if (doneAction == nil) {
        doneButton = [[UIBarButtonItem alloc]initWithTitle:doneTitle style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyboard)];
    } else {
        doneButton = [[UIBarButtonItem alloc]initWithTitle:doneTitle style:UIBarButtonItemStyleDone target:target action:doneAction];
    }
    
    NSArray *buttonsArray = [NSArray arrayWithObjects:nextButton, btnSpace, doneButton,nil];
    
    [topView setItems:buttonsArray];
    [self setInputAccessoryView:topView];
}

- (void)dismissKeyboard {
    [self resignFirstResponder];
}


@end

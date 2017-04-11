//
//  PaddingTextField.m
//  TigerLottery
//
//  Created by Legolas on 14/12/2.
//  Copyright (c) 2014年 adcocoa. All rights reserved.
//

#import "PaddingTextField.h"

@implementation PaddingTextField

- (void)awakeFromNib {
    [super awakeFromNib];
    self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    self.leftViewMode = UITextFieldViewModeAlways;
}

@end

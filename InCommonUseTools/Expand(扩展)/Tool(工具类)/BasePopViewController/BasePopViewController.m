//
//  BasePopViewController.m
//  TigerLottery
//
//  Created by Legolas on 14/12/6.
//  Copyright (c) 2014年 adcocoa. All rights reserved.
//

#import "BasePopViewController.h"
#import "UINavigationController+Loading.h"

@interface BasePopViewController ()

@end

@implementation BasePopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigationItem];
}

- (void)dealloc {
    [self hideLoading];
}

- (void)createNavigationItem {
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [backBtn setImage:[UIImage imageNamed:@"ic_back.png"] forState:UIControlStateNormal];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backBtn addTarget:self action:@selector(popViewController:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)popViewController:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showLoading {
    [self.navigationController showLoading];
}

- (void)hideLoading {
    [self.navigationController hideLoading];
}

@end

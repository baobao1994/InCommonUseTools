//
//  SHTabbarController.m
//  SHCW
//
//  Created by 郭伟文 on 16/12/7.
//  Copyright © 2016年 Baobao. All rights reserved.
//

#import "SHTabbarController.h"
//#import "SHHomeViewController.h"
//#import "SHIMViewController.h"
//#import "SHBussinessViewController.h"
//#import "SHOAViewController.h"
//#import "SHMyViewController.h"
#import "SHNavigationController.h"

@interface SHTabbarController ()

@end

@implementation SHTabbarController

+ (void)initialize {
    UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];

    NSMutableDictionary *dictNormal = [NSMutableDictionary dictionary];
    dictNormal[NSForegroundColorAttributeName] = [UIColor grayColor];
    dictNormal[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    
    NSMutableDictionary *dictSelected = [NSMutableDictionary dictionary];
    dictSelected[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    dictSelected[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    
    [tabBarItem setTitleTextAttributes:dictNormal forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:dictSelected forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpAllChildVc];
}

- (void)setUpAllChildVc {
//    SHHomeViewController *HomeVC = [[SHHomeViewController alloc] init];
//    [self setUpOneChildVcWithVc:HomeVC Image:@"tabbar_home_normal" selectedImage:@"tabbar_home_select" title:@"首页"];
//
//    SHIMViewController *IMVC = [[SHIMViewController alloc] init];
//    [self setUpOneChildVcWithVc:IMVC Image:@"tabbar_score_normal" selectedImage:@"tabbar_score_select" title:@"消息"];
//
//    SHBussinessViewController *BussinessVC = [[SHBussinessViewController alloc] init];
//    [self setUpOneChildVcWithVc:BussinessVC Image:@"tabbar_prize_normal" selectedImage:@"tabbar_prize_select" title:@"交易"];
//
//    SHOAViewController *OAVC = [[SHOAViewController alloc] init];
//    [self setUpOneChildVcWithVc:OAVC Image:@"tabbar_order_normal" selectedImage:@"tabbar_order_select" title:@"OA办公"];
//    
//    SHMyViewController *MyVC = [[SHMyViewController alloc] init];
//    [self setUpOneChildVcWithVc:MyVC Image:@"tabbar_my_normal" selectedImage:@"tabbar_my_select" title:@"我的"];
}

#pragma mark - 初始化设置tabBar上面单个按钮的方法

- (void)setUpOneChildVcWithVc:(UIViewController *)Vc Image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title {
    SHNavigationController *navigationController = [[SHNavigationController alloc] initWithRootViewController:Vc];
    Vc.view.backgroundColor = RandomColor;
    
    UIImage *myImage = [UIImage imageNamed:image];
    myImage = [myImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    Vc.tabBarItem.image = myImage;
    
    UIImage *mySelectedImage = [UIImage imageNamed:selectedImage];
    mySelectedImage = [mySelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    Vc.tabBarItem.selectedImage = mySelectedImage;
    Vc.tabBarItem.title = title;
    Vc.navigationItem.title = title;
    
    [self addChildViewController:navigationController];
}

@end

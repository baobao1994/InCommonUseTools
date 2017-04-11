//
//  UIViewController+Loading.m
//  
//
//  Created by Legolas on 15/7/6.
//
//

#import "UIViewController+Loading.h"
#import <objc/runtime.h>
#import "TLMBProgressHUD.h"

static const NSString *HubViewKey = @"HubViewKey";
static const NSString *ErrorViewKey = @"ErrorViewKey";

@implementation UIViewController(Loading)

@dynamic hudView, errorView;

- (TLMBProgressHUD *)hudView {
    return objc_getAssociatedObject(self, &HubViewKey);
}

- (void)setHudView:(TLMBProgressHUD *)hudView {
    objc_setAssociatedObject(self, &HubViewKey, hudView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)errorView {
    return objc_getAssociatedObject(self, &ErrorViewKey);
}

- (void)setErrorView:(UIView *)errorView {
    objc_setAssociatedObject(self, &ErrorViewKey, errorView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)showLoading {
    if (self.hudView == nil) {
        self.hudView = [[TLMBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:self.hudView];
    }
    [self.hudView show:YES];
}

- (void)hideLoading {
    [self.hudView hide:YES];
}

- (void)showErrorViewWithFrame:(CGRect)frame {
    if (self.errorView == nil) {
        self.errorView = [[UIView alloc] initWithFrame:frame];
        self.errorView.backgroundColor = UIColorFromHexColor(0xf2f2f2);
        [self.view addSubview:self.errorView];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - 67) / 2, frame.size.height / 2 - 150, 67, 60)];
        imageView.image = [UIImage imageNamed:@"error.png"];
        [self.errorView addSubview:imageView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.frame.size.height + imageView.frame.origin.y + 15, frame.size.width, 30)];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [titleLabel setText:@"网络无法连接"];
        [titleLabel setTextColor:UIColorFromHexColor(0x333131)];
        [self.errorView addSubview:titleLabel];
        
        UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, titleLabel.frame.origin.y + titleLabel.frame.size.height, frame.size.width, 20)];
        [descriptionLabel setTextColor:UIColorFromHexColor(0x999191)];
        [descriptionLabel setTextAlignment:NSTextAlignmentCenter];
        [descriptionLabel setFont:[UIFont systemFontOfSize:12.0]];
        [descriptionLabel setText:@"抱歉，请点击刷新按钮再试一次"];
        [self.errorView addSubview:descriptionLabel];
        
        UIButton *refresh = [[UIButton alloc] initWithFrame:CGRectMake(0, descriptionLabel.frame.origin.y +  descriptionLabel.frame.size.height + 10, 128, 32)];
        refresh.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [refresh setBackgroundImage:[UIImage imageNamed:@"error_btn.png"] forState:UIControlStateNormal];
        [refresh setTitle:@"刷新" forState:UIControlStateNormal];
        [refresh setTitleColor:UIColorFromHexColor(0x999191) forState:UIControlStateNormal];
        [refresh addTarget:self action:@selector(refreshView) forControlEvents:UIControlEventTouchUpInside];
        refresh.center = CGPointMake(frame.size.width / 2, refresh.center.y);
        [self.errorView addSubview:refresh];
    }
    [self hideLoading];
    self.errorView.hidden = NO;
    [self.view bringSubviewToFront:self.errorView];
}

- (void)showErrorView {
    [self showErrorViewWithFrame:self.view.bounds];
}

- (void)hideErrorView {
    self.errorView.hidden = YES;
}

- (void)refreshView {
    [self.navigationController showLoading];
    [self hideErrorView];
}

@end

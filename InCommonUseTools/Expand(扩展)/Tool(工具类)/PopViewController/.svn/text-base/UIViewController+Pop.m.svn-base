//
//  UIViewController+Pop.m
//  
//
//  Created by Legolas on 15/7/6.
//
//

#import <objc/runtime.h>
#import "UIViewController+Pop.h"

static const NSString *MoveAnimationKey = @"MoveAnimationKey";
static const NSString *PopToIndexKey = @"PopToIndexKey";
static const NSString *PopToTagKey = @"PopToTagKey";

@implementation UIViewController(Pop)

@dynamic moveAnimation;
@dynamic popToIndex;
@dynamic popToTag;

#pragma mark - Public Method

- (void)createNavigationBackItem {
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [backBtn setImage:[UIImage imageNamed:@"ic_back.png"] forState:UIControlStateNormal];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backBtn addTarget:self action:@selector(popViewController:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)createNavigationRightItem:(NSString *)rightItemImageName {
    UIButton *helpBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    if (rightItemImageName) {
        [helpBtn setImage:[UIImage imageNamed:rightItemImageName] forState:UIControlStateNormal];
    } else {
        [helpBtn setImage:[UIImage imageNamed:@"help.png"] forState:UIControlStateNormal];
    }
    
    helpBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [helpBtn addTarget:self action:@selector(selectedNavigationRightItem:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:helpBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)pushViewContorller:(UIViewController *)viewContorller customInteractive:(BOOL)interactive {
    if (interactive) {
//        self.navigationController.delegate = self;
//        if (self.moveAnimation == nil) {
//            self.moveAnimation = [[MoveAnimation alloc] initWithNavigationController:self.navigationController];
//        }
//        self.moveAnimation.viewForInteraction = viewContorller.view;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
        viewContorller.hidesBottomBarWhenPushed = YES;
        [viewContorller createNavigationBackItem];
    }
    [self.navigationController pushViewController:viewContorller animated:YES];
}

- (void)popToViewContollerAtStackIndex:(NSInteger)index {
    if (index >= 0) {
        NSInteger delegateIndex = index - 1;
        if (delegateIndex >= 0) {
            UIViewController *vc = [self.navigationController.viewControllers objectAtIndex:delegateIndex];
            self.navigationController.delegate = vc;
        }
        UIViewController *popVC = [self.navigationController.viewControllers objectAtIndex:index];
        [self.navigationController popToViewController:popVC animated:YES];
    }
}

- (void)setupPopParam:(id)param popTag:(NSInteger)tag {}

- (void)selectedNavigationRightItem:(id)sender {}


#pragma mark - Navigation Controller Delegate

#pragma mark - Private Method

- (void)popViewController:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    NSInteger index = self.navigationController.viewControllers.count - 2;
    if (index >= 0) {
        UIViewController *vc = [self.navigationController.viewControllers objectAtIndex:index];
        self.navigationController.delegate = vc;
    }
}

- (MoveAnimation *)moveAnimation {
    return objc_getAssociatedObject(self, &MoveAnimationKey);
}

- (void)setMoveAnimation:(MoveAnimation *)moveAnimation {
    objc_setAssociatedObject(self, &MoveAnimationKey, moveAnimation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)popToIndex {
    return [objc_getAssociatedObject(self, &PopToIndexKey) integerValue];
}

- (void)setPopToIndex:(NSInteger)popToIndex {
    objc_setAssociatedObject(self, &PopToIndexKey, @(popToIndex), OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)popToTag {
    return [objc_getAssociatedObject(self, &PopToTagKey) integerValue];
}

- (void)setPopToTag:(NSInteger)popToTag {
    objc_setAssociatedObject(self, &PopToTagKey, @(popToTag), OBJC_ASSOCIATION_ASSIGN);
}

@end

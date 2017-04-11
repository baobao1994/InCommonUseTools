//
//  UIViewController+Pop.h
//  
//
//  Created by Legolas on 15/7/6.
//
//

#import <UIKit/UIKit.h>
@class MoveAnimation;

@interface UIViewController(Pop) <UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) MoveAnimation *moveAnimation;
@property (nonatomic, assign) NSInteger popToIndex;
@property (nonatomic, assign) NSInteger popToTag;

- (void)createNavigationBackItem;
- (void)createNavigationRightItem:(NSString *)rightItemImageName;
- (void)pushViewContorller:(UIViewController *)viewContorller customInteractive:(BOOL)interactive;
- (void)popToViewContollerAtStackIndex:(NSInteger)index;
- (void)setupPopParam:(id)param popTag:(NSInteger)tag;
- (void)selectedNavigationRightItem:(id)sender;

@end

//
//  PanelViewController.h
//  TigerLottery
//
//  Created by 郭伟文 on 16/8/25.
//  Copyright © 2016年 adcocoa. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChangePanelIndexDelegate <NSObject>

- (void)changeWithIndex:(NSInteger)index titleName:(NSString *)titleName;

@end

@interface PanelViewController : UIViewController

@property (nonatomic, strong) UIColor *titleBackGroundColor;
@property (nonatomic, strong) UIColor *titleNorColor;
@property (nonatomic, strong) UIColor *titleSelColor;
@property (nonatomic, strong) UIColor *titleLineColor;
@property (nonatomic, assign) BOOL isFullTitleLineWidth;
@property (nonatomic, assign) BOOL isHaveMenuView; //这个为YES的时候，下面两个参数必须有
@property (nonatomic, strong) NSArray *titleItemsNameArr;
@property (nonatomic, assign) NSInteger titleViewOffset;

@property (nonatomic, assign) BOOL isScrollChangePage;
@property (nonatomic, weak) id<ChangePanelIndexDelegate> delegate;

- (id)initWithControllers:(NSArray *)contollers withFrame:(CGRect)frame currentIndex:(NSInteger)index titleScrollowBackGroundImage:(NSString *)titleImageName;
- (void)changeViewFrameWithHeight:(CGFloat)height;

@end

//
//  ScratchCardView.h
//  TigerLottery
//
//  Created by 郭伟文 on 17/2/24.
//  Copyright © 2017年 adcocoa. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScratchCardView;

@protocol ScratchCardViewDelegate  <NSObject>

@optional
//刮开百分比
- (void)ScratchCardView:(ScratchCardView *)scratchCardView didScratchedWithPercent:(CGFloat)percent;
//刮开
- (void)didOpenScratch;

@end

@interface ScratchCardView : UIView

@property (nonatomic, strong) UIView *innerView;
@property (nonatomic, strong) UIView *surfaceView;
@property (nonatomic, assign) CGFloat percent;//(0~1)刮到多少则全部刮开
@property (nonatomic, assign) CGFloat numberPoint;//刮多少点则就全部刮开
@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, weak) id<ScratchCardViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame surfaceView:(UIView *)surfaceView innerView:(UIView *)innerView;
//开始绘制
- (void)startDrawing;
//重置
- (void)resetScratch;
//刮开
- (void)openScratch;

@end

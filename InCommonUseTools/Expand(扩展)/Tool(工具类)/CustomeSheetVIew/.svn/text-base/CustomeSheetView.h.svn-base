//
//  CustomeSheetView.h
//  TigerLottery
//
//  Created by Legolas on 15/3/2.
//  Copyright (c) 2015年 adcocoa. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomeSheetViewDelegate;

@interface CustomeSheetView : UIView

@property (nonatomic, assign) id<CustomeSheetViewDelegate> delegate;
@property (nonatomic, retain) UIView *contentView;
@property (nonatomic, assign) NSInteger cancelButtonIndex;

- (id)initWithDefaultToolBar;
- (void)show;
- (void)hide;

@end

@protocol CustomeSheetViewDelegate <NSObject>

@optional
- (void)actionSheet:(CustomeSheetView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

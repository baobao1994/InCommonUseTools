//
//  ModalMenuView.h
//  TigerLottery
//
//  Created by Legolas on 2017/2/28.
//  Copyright © 2017年 adcocoa. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MenuItemAlignment) {
    MenuItemAlignmentLeft,
    MenuItemAlignmentCenter,
};

@protocol ModalMenuViewDelegate;

@interface ModalMenuView : UIView

@property (nonatomic, assign) id<ModalMenuViewDelegate> delegate;
@property (nonatomic, copy) UIButton * (^buttonBlock)(NSInteger row, NSInteger column);
@property (nonatomic, copy) UIView * (^sectionBlock)(NSInteger section);
@property (nonatomic, assign) MenuItemAlignment itemAlignment;
@property (nonatomic, retain) NSArray *itemTitles;
@property (nonatomic, strong) NSArray *sectionTitles;
@property (nonatomic, assign) CGFloat itemPadding;
@property (nonatomic, copy) NSString *itemNormalImageName;
@property (nonatomic, copy) NSString *itemSelectedImageName;

- (void)setupWithItemCount:(NSInteger)itemCount;
- (void)selectModeAtIndex:(NSIndexPath *)indexPath;
- (void)showView:(BOOL)animation;
- (void)hideView:(BOOL)animation;

@end


@protocol ModalMenuViewDelegate <NSObject>

- (void)didSelectedModeAtIndexPath:(NSIndexPath *)indexPath;

@end

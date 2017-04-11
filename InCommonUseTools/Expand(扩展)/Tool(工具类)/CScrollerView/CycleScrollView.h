//
//  CycleScrollView.h
//  PagedScrollView
//
//  Created by Legolas on 14/12/17.
//  Copyright (c) 2014年 adcocoa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CycleScrollView : UIView

@property (nonatomic , readonly) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *imageUrls;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, copy) NSInteger (^totalPagesCount)(void);
@property (nonatomic, copy) UIView *(^fetchContentViewAtIndex)(NSInteger pageIndex);
@property (nonatomic, copy) NSString *(^titleAtIndex)(NSInteger pageIndex);
@property (nonatomic, copy) void (^TapActionBlock)(NSInteger pageIndex);

- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration;

@end
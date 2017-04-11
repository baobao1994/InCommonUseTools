//
//  PanelViewController.m
//  TigerLottery
//
//  Created by 郭伟文 on 16/8/25.
//  Copyright © 2016年 adcocoa. All rights reserved.
//

#import "PanelViewController.h"
#import "NSString+Addition.h"
#import "LiveTitleLabel.h"
#import "ConstString.h"
//#import "MenuView.h"

#define kTitleHeight (40)
#define kContentCount (_controllers.count)
#define kContentHeight (self.view.frame.size.height - kTitleHeight - 1)
#define kContentSizeWidth (kContentCount * UIScreenWidth)
#define kInitialContentOffsetX (_currentIndex * UIScreenWidth)
#define kLabelWitdh (UIScreenWidth / self.titleMixCount) //默认就最多放下5个按钮
#define kLabelHeight (36)
#define kLabelX(index) (index * kLabelWitdh)
#define kLabelY (2)
#define kMenuViewHeight (UIScreenHeight - kTitleHeight)

@interface PanelViewController () <UIScrollViewDelegate/*,MenuViewDelegate*/>

@property (nonatomic, strong) UIScrollView *titleScrollow;
@property (nonatomic, strong) UIScrollView *contentScrollow;
@property (nonatomic, strong) NSArray *controllers;
@property (nonatomic, assign) NSInteger titleMixCount;
@property (nonatomic, strong) NSMutableArray *controllerTitleArr;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) UIButton *popButton;
@property (nonatomic, strong) UIImageView *popImageView;
//@property (nonatomic, strong) MenuView *menuView;
@property (nonatomic, assign) CGFloat panelVCHeight;

@end

@implementation PanelViewController

- (id)initWithControllers:(NSArray *)contollers withFrame:(CGRect)frame currentIndex:(NSInteger)index titleScrollowBackGroundImage:(NSString *)titleImageName {
    if (self = [super init]) {
        self.view.frame = frame;
        _controllers = contollers;
        if (contollers.count > 5) {
            self.titleMixCount = 5;
        } else {
            self.titleMixCount = contollers.count;
        }
        _currentIndex = index;
        _titleNorColor = UIColorFromHexColor(0xADADAD);
        _titleSelColor = UIColorFromHexColor(0xFEFEFE);
        _titleLineColor = UIColorFromHexColor(0xFEFEFE);
        _titleBackGroundColor = [UIColor clearColor];
        _isFullTitleLineWidth = NO;
        UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, kTitleHeight)];
        backImageView.image = [UIImage imageNamed:titleImageName];
        [self.view addSubview:backImageView];
        [self setup];
    }
    return self;
}

- (void)setIsHaveMenuView:(BOOL)isHaveMenuView {
    if (isHaveMenuView) {
        _popButton = [[UIButton alloc] initWithFrame:CGRectMake(UIScreenWidth - _titleViewOffset, 0, _titleViewOffset, kTitleHeight)];
        [_popButton setTitle:@"" forState:UIControlStateNormal];
        [_popButton setBackgroundColor:[UIColor whiteColor]];
        [_popButton addTarget:self action:@selector(didSelectMorePopButton:) forControlEvents:UIControlEventTouchUpInside];
        _popImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"down"]];
        _popImageView.frame = CGRectMake(0, 0, 15, 15);
        _popImageView.center = _popButton.center;
        [self.view addSubview:_popButton];
        [self.view addSubview:_popImageView];
//        _menuView = [[MenuView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, kMenuViewHeight) withTitleItemsNameArr:_titleItemsNameArr];
//        _menuView.hidden = YES;
//        _menuView.delegate = self;
//        [self.view insertSubview:_menuView belowSubview:self.popButton];
    }
}

- (void)setTitleViewOffset:(NSInteger)titleViewOffset {
    _titleViewOffset = titleViewOffset;
}

- (void)setTitleNorColor:(UIColor *)titleNorColor {
    _titleNorColor = titleNorColor;
    [self addTitleLable];
}

- (void)setTitleSelColor:(UIColor *)titleSelColor {
    _titleSelColor = titleSelColor;
    [self addTitleLable];
}

- (void)setTitleLineColor:(UIColor *)titleLineColor {
    _titleLineColor = titleLineColor;
    [self addTitleLable];
}

- (void)setIsFullTitleLineWidth:(BOOL)isFullTitleLineWidth {
    _isFullTitleLineWidth = isFullTitleLineWidth;
    [self addTitleLable];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.view.backgroundColor =UIColorFromHexColor(0xEBECED);
}

- (void) setup {
    _titleScrollow = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, kTitleHeight)];
    _titleScrollow.showsHorizontalScrollIndicator = NO;
    _titleScrollow.showsVerticalScrollIndicator = NO;
    _titleScrollow.backgroundColor = _titleBackGroundColor;
    _titleScrollow.contentSize = CGSizeMake(kContentCount * kLabelWitdh + _titleViewOffset, 0);
    [self.view addSubview:_titleScrollow];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, kTitleHeight, UIScreenWidth, 0.5)];
    [self.view addSubview:line];
    _contentScrollow = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kTitleHeight + 1, UIScreenWidth, kContentHeight)];
    _panelVCHeight = kContentHeight;
    _contentScrollow.delegate = self;
    _contentScrollow.pagingEnabled = YES;
    _contentScrollow.backgroundColor = UIColorFromHexColor(0xEBECED);
    _contentScrollow.showsHorizontalScrollIndicator = NO;
    _contentScrollow.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_contentScrollow];
    [self addTitleLable];
    
    UIViewController *controller = [_controllers objectAtIndex:_currentIndex];
    controller.view.frame = CGRectMake(UIScreenWidth * _currentIndex, 0, UIScreenWidth, _contentScrollow.frame.size.height);
    controller.view.clipsToBounds = YES;
    [_contentScrollow addSubview:controller.view];
    _contentScrollow.contentSize = CGSizeMake(kContentSizeWidth, kContentHeight);
    _contentScrollow.contentOffset = CGPointMake(kInitialContentOffsetX, 0);
    
    LiveTitleLabel *titleLabel = self.titleScrollow.subviews[_currentIndex * 2];
    titleLabel.textColor = self.titleSelColor;
    titleLabel.scale = 1.0;
    LiveTitleLabel *titleLineLabel = self.titleScrollow.subviews[_currentIndex * 2 + 1];
    titleLineLabel.alpha = 1.0;
}

- (void)addTitleLable {
    for (UIView *subView in self.titleScrollow.subviews) {
        if ([subView isKindOfClass:[LiveTitleLabel class]]) {
            [subView removeFromSuperview];
        }
    }
    for (int i = 0; i < kContentCount; i++) {
        UIViewController *controller = [_controllers objectAtIndex:i];
        LiveTitleLabel *titleLabel = [[LiveTitleLabel alloc]init];
        CGSize titleLabelSize = [controller.title adaptSizeWithFont:[UIFont systemFontOfSize:17.0f]];
        titleLabel.text = controller.title;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.frame = CGRectMake(kLabelX(i), kLabelY, kLabelWitdh, kLabelHeight);
        titleLabel.font = [UIFont systemFontOfSize:17.0f];
        titleLabel.textColor = self.titleNorColor;
        titleLabel.norColor = self.titleNorColor;
        titleLabel.selColor = self.titleSelColor;
        titleLabel.scale = 0;
        [_titleScrollow addSubview:titleLabel];
        titleLabel.tag = i;
        titleLabel.userInteractionEnabled = YES;
        [titleLabel addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleLabelClick:)]];
        LiveTitleLabel *titleLine = [[LiveTitleLabel alloc] init];
        if (_isFullTitleLineWidth) {
            titleLine.frame = CGRectMake(kLabelX(i), kLabelHeight + 2, kLabelWitdh, 2);
        } else {
            titleLine.frame = CGRectMake((kLabelWitdh - titleLabelSize.width * 1.7)/ 2 + kLabelX(i), kLabelHeight + 2, titleLabelSize.width * 1.7, 2);
        }
        titleLine.backgroundColor = self.titleLineColor;
        titleLine.alpha = 0;
        [_titleScrollow addSubview:titleLine];
    }
    LiveTitleLabel *titleLabel = self.titleScrollow.subviews[_currentIndex * 2];
    titleLabel.textColor = self.titleSelColor;
    titleLabel.scale = 1.0;
    LiveTitleLabel *titleLineLabel = self.titleScrollow.subviews[_currentIndex * 2 + 1];
    titleLineLabel.alpha = 1.0;
}

#pragma mark - privateMethod

- (void)titleLabelClick:(UITapGestureRecognizer *)recognizer {
    LiveTitleLabel *titleLabel = (LiveTitleLabel *)recognizer.view;
    [self scrollTitleView:titleLabel];
}

- (void)scrollTitleView:(LiveTitleLabel *)titleLabel {
    CGFloat offsetX = titleLabel.tag * _contentScrollow.frame.size.width;
    CGFloat offsetY = _contentScrollow.contentOffset.y;
    CGPoint offset = CGPointMake(offsetX, offsetY);
    //有动画的闪过
    //    [_contentScrollow setContentOffset:offset animated:YES];//快速滑动--有动画
    //没有动画直接一闪而过
    [_contentScrollow setContentOffset:offset animated:NO];
    [self scrollViewDidScroll:_contentScrollow];
    [self scrollViewDidEndScrollingAnimation:_contentScrollow];
    [[NSNotificationCenter defaultCenter] postNotificationName:kLeaveTopNotificationName object:nil userInfo:@{kIsCanScroll:kCanScroll}];
}

- (void)hideView {
    [self didSelectMorePopButton:[UIButton new]];
} 

- (void)didSelectItemIndex:(NSInteger)index {
    LiveTitleLabel *liveTitleLabel = [self.titleScrollow viewWithTag:index];
    [self scrollTitleView:liveTitleLabel];
    [self hideView];
}

- (void)didSelectMorePopButton:(UIButton *)sender {
    //    _popButton.enabled = NO;
    //    if (_menuView.hidden) {
    //        [_menuView setHidden:NO];
    //        [UIView animateWithDuration:0.4 animations:^{
    //            _menuView.titleHeaderLabel.alpha = 1;
    //            _menuView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];//半透明
    //        } completion:^(BOOL finished) {
    //            _menuView.collectionView.hidden = NO;
    //            [UIView animateWithDuration:0.4 animations:^{
    //                [_menuView.collectionView setFrame:CGRectMake(0, 41, UIScreenWidth, _menuView.collectionView.frame.size.height)];
    //                _popImageView.transform = CGAffineTransformRotate(_popImageView.transform,M_PI);
    //            }completion:^(BOOL finished) {
    //                _popButton.enabled = YES;
    //            } ];
    //        }];
    //    }else {
    //        [UIView animateWithDuration:0.4 animations:^{
    //            [_menuView.collectionView setFrame:CGRectMake(0, - _menuView.collectionView.frame.size.height, UIScreenWidth, _menuView.collectionView.frame.size.height)];
    //            _popImageView.transform = CGAffineTransformRotate(_popImageView.transform,M_PI);
    //        }completion:^(BOOL finished) {
    //            [UIView animateWithDuration:0.4 animations:^{
    //                _menuView.titleHeaderLabel.alpha = 0;
    //                _menuView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];//全透明
    //            } completion:^(BOOL finished) {
    //                [_menuView setHidden:YES];
    //                _menuView.collectionView.hidden = YES;
    //                _popButton.enabled = YES;
    //            }];
    //        } ];
    //    }
}

#pragma mark - scrollView代理方法

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSUInteger index = scrollView.contentOffset.x / _contentScrollow.frame.size.width / 2 * 2;
    LiveTitleLabel *titleLable = (LiveTitleLabel *)_titleScrollow.subviews[index * 2];
    LiveTitleLabel *titleLineLable = (LiveTitleLabel *)_titleScrollow.subviews[index * 2 + 1];
    titleLineLable.alpha = 1.0;
    
    CGFloat offsetX = titleLable.center.x - _titleScrollow.frame.size.width * 0.5;
    CGFloat offsetMax = _titleScrollow.contentSize.width - _titleScrollow.frame.size.width;
    if (offsetX < 0) {
        offsetX = 0;
    }else if (offsetX > offsetMax){
        offsetX = offsetMax;
    }
    CGPoint offset = CGPointMake(offsetX, _titleScrollow.contentOffset.y);
    [_titleScrollow setContentOffset:offset animated:YES];
    [_titleScrollow.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger titleIndex, BOOL *stop) {
        if ((titleIndex / 2) != index) {
            LiveTitleLabel *titleLabel = _titleScrollow.subviews[titleIndex / 2 * 2];
            titleLabel.scale = 0.0;
            LiveTitleLabel *titleLine = _titleScrollow.subviews[titleIndex / 2 * 2 + 1];
            titleLine.alpha = 0.0;
        }
    }];
    [self.delegate changeWithIndex:index titleName:((UIViewController *)_controllers[index]).title];
    UIViewController *controller = self.controllers[index];
    if (controller.view.superview) {
        return;
    }
    controller.view.frame = CGRectMake(UIScreenWidth * index, 0, UIScreenWidth, _contentScrollow.frame.size.height);
    controller.view.clipsToBounds = YES;
    [_contentScrollow addSubview:controller.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat value = ABS(scrollView.contentOffset.x / scrollView.frame.size.width);
    NSUInteger index = scrollView.contentOffset.x / _contentScrollow.frame.size.width / 2 * 2;
    NSUInteger leftIndex = (int)value;
    NSUInteger rightIndex = leftIndex + 1;
    CGFloat scaleRight = value - leftIndex;
    CGFloat scaleLeft = 1 - scaleRight;
    LiveTitleLabel *titleLabelLeft = _titleScrollow.subviews[index * 2];
    titleLabelLeft.scale = scaleLeft;
    LiveTitleLabel *titleLine = _titleScrollow.subviews[index * 2 +1];
    titleLine.alpha = 0;
    
    if (rightIndex < _titleScrollow.subviews.count / 2) {
        LiveTitleLabel *titleLabel = _titleScrollow.subviews[index * 2 + 2];
        titleLabel.scale = scaleRight;
        LiveTitleLabel *titleLine = _titleScrollow.subviews[index * 2 +3];
        titleLine.alpha = 0.0;
    }
}

- (void)setIsScrollChangePage:(BOOL)isScrollChangePage {
    self.contentScrollow.scrollEnabled = isScrollChangePage;
}

#pragma mark - publicMethod

- (void)changeViewFrameWithHeight:(CGFloat)height {
    CGRect theRect = _contentScrollow.frame;
    theRect.size.height = _panelVCHeight + height;
    _contentScrollow.frame = theRect;
    for (UIViewController *controller in self.controllers) {
        controller.view.frame =CGRectMake(controller.view.frame.origin.x, controller.view.frame.origin.y, controller.view.frame.size.width, controller.view.frame.size.height + height);
    }
}

@end

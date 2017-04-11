//
//  ModalMenuView.m
//  TigerLottery
//
//  Created by Legolas on 2017/2/28.
//  Copyright © 2017年 adcocoa. All rights reserved.
//

#import "ModalMenuView.h"
#import "NSString+Addition.h"

#define kPlayModeTag 1000
#define kPlayModeWidth 96
#define kPlayModeHeight 24
#define kPlayModeOfRow 3
#define kPlayModeViewPadding 15

@interface ModalMenuView ()

@property (nonatomic, assign) NSInteger modeCount;

@property (nonatomic, retain) UIView *tapView;

@property (nonatomic, assign) NSInteger itemCount;
@property (nonatomic, assign) NSInteger sectionCount;

@end


@implementation ModalMenuView

- (instancetype)init {
    if (self = [super init]) {
        _sectionCount = 1;
        _itemPadding = kPlayModeViewPadding;
        _itemNormalImageName = @"btn_off_gray";
        _itemSelectedImageName = @"btn_on_red";
    }
    return self;
}

- (void)setupWithItemCount:(NSInteger)itemCount {
    _itemCount = itemCount;
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = UIColorFromHexColorA(0x000000, 0.5);
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:contentView];

    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat scale = [UIScreen mainScreen].bounds.size.width / 320;
    CGFloat playModeWith = kPlayModeWidth * scale;
    CGFloat playModeHeight = kPlayModeHeight * scale;
    CGFloat padding = (width - playModeWith * 3) / 4;
    CGFloat height = kPlayModeViewPadding;
    for (int section = 0; section < _sectionCount; section++) {
        NSInteger row = (_itemCount + kPlayModeOfRow - 1) / kPlayModeOfRow;
        
        if (_sectionBlock) {
            UIView *headView = _sectionBlock(section);
            [contentView addSubview:headView];
            height += headView.frame.size.height + 5;
        }else if (_sectionTitles.count > 0) {
            UIView *headView = [self defaultSectionView:section];
            [contentView addSubview:headView];
            height += headView.frame.size.height + 5;
        }
        
        for (int i = 0; i < row; i++) {
            for (int j = 0; j < kPlayModeOfRow; j++) {
                NSInteger index = i * kPlayModeOfRow + j;
                if (index < _itemCount) {
                    
                    float x = (padding + playModeWith) * j + padding;
                    float y = (padding + playModeHeight) * i + height;
                    float lastRowCount = _itemCount % kPlayModeOfRow;
                    if (row == 1 && lastRowCount > 0 && _itemAlignment == MenuItemAlignmentCenter) {
                        float viewPadding = (width - lastRowCount * (padding + playModeWith) + padding) / 2;
                        x += viewPadding - padding;
                    }
                    UIButton *modeBtn;
                    if (_buttonBlock) {
                        modeBtn = _buttonBlock(i, j);
                    }else {
                        modeBtn = [[UIButton alloc] initWithFrame:CGRectMake(x, y, playModeWith, playModeHeight)];
                        [modeBtn setBackgroundImage:[UIImage imageNamed:_itemNormalImageName] forState:UIControlStateNormal];
                        [modeBtn setBackgroundImage:[UIImage imageNamed:_itemSelectedImageName] forState:UIControlStateSelected];
                        [modeBtn setBackgroundImage:[UIImage imageNamed:_itemSelectedImageName] forState:UIControlStateHighlighted];
                        [modeBtn.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
                        [modeBtn setTitleColor:kGrayColor forState:UIControlStateNormal];
                        [modeBtn setTitleColor:kRedColor forState:UIControlStateSelected];
                        [modeBtn setTitleColor:kRedColor forState:UIControlStateHighlighted];
                        [modeBtn setTitle:[_itemTitles objectAtIndex:index] forState:UIControlStateNormal];
                        [modeBtn addTarget:self action:@selector(modeBtnSelect:) forControlEvents:UIControlEventTouchUpInside];
                    }
                    modeBtn.tag = index + kPlayModeTag * (section + 1);
                    [contentView addSubview:modeBtn];
                }
            }
        }
        
        height += (playModeHeight + padding) * row - padding + kPlayModeViewPadding;
    }
    contentView.frame = CGRectMake(0, 0, width, height);
    _tapView = [[UIView alloc] initWithFrame:CGRectMake(0, height, width, self.frame.size.height - height)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideView:)];
    [_tapView addGestureRecognizer:tap];

    [self addSubview:_tapView];
}

#pragma mark - Public Method

- (void)selectModeAtIndex:(NSIndexPath *)indexPath {
    [self modeBtnSelect:(UIButton *)[self viewWithTag:indexPath.row + kPlayModeTag * (indexPath.section + 1)]];
}

- (void)showView:(BOOL)animation {
    self.hidden = NO;
}

- (void)hideView:(BOOL)animation {
    self.hidden = YES;
}

#pragma mark - Action Method

- (void)modeBtnSelect:(UIButton *)sender {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    for (int section = 0; section < _sectionCount; section++) {
        for (int i = 0; i < _itemCount; i++) {
            UIButton *modeBtn = (UIButton *)[self viewWithTag:i + kPlayModeTag * (section + 1)];
            if (modeBtn != sender && modeBtn.selected) {
                modeBtn.selected = NO;
            }
            if (modeBtn.tag == sender.tag) {
                indexPath = [NSIndexPath indexPathForRow:i inSection:section];
            }
        }
    }
    if (!sender.selected) {
        sender.selected = YES;
        DELEGATE_CALLBACK_ONE_PARAMETER(_delegate, @selector(didSelectedModeAtIndexPath:), indexPath);
    }
}

#pragma mark - Private Method

- (UIView *)defaultSectionView:(NSInteger)section {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = kPlayModeViewPadding;
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, height, width, 21)];
    
    CGFloat lineHeight = 0.5;
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width - _itemPadding * 2, lineHeight)];
    lineView.center = CGPointMake(width / 2, sectionView.frame.size.height / 2);
    [sectionView addSubview:lineView];
    
    NSString *title = [_sectionTitles objectAtIndex:section];
    UIFont *font = [UIFont systemFontOfSize:16];
    CGSize size = [title adaptSizeWithFont:font];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width + _itemPadding * 2, 21)];
    titleLabel.backgroundColor = [UIColor whiteColor];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    titleLabel.center = lineView.center;
    [titleLabel setText:title];
    [sectionView addSubview:titleLabel];
    return sectionView;
}

@end

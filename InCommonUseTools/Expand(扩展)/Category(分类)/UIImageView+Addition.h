//
//  UIImageView+Addition.h
//  AppTalk
//
//  Created by huaiqing xie on 12-1-26.
//  Copyright (c) 2012年 ND. All rights reserved.
//

@interface UIImageView (Addition)

- (void)setCornerRadius:(float)cornerRadius;
- (void)setShadowOffset: (CGSize)size// 设置阴影的偏移量
                             radius: (CGFloat)radius// 设置阴影的半径
                              color: (UIColor *)color// 设置阴影的颜色为黑色
                           opacity: (CGFloat)opacity;// 设置阴影的不透明度
- (void)setCornerRadius:(float)cornerRadius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

@end

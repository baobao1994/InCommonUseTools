//
//  ScaningView.m
//  InCommonUseTools
//
//  Created by 郭伟文 on 2017/4/11.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "ScanningView.h"

@interface ScanningView ()

@property (strong, nonatomic) UIView *line;
@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) CGFloat origin;
@property (assign, nonatomic) BOOL isReachEdge;
@property (assign , nonatomic) XDScaningLineMoveMode lineMoveMode;
@property (assign, nonatomic) XDScaningLineMode lineMode;
@property (assign, nonatomic) XDScaningWarningTone warninTone;

@end

@implementation ScanningView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initConfig];
    }
    return self;
}

- (void)initConfig{
    self.backgroundColor = [UIColor clearColor];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(viewWillDisappear:) name:@"ViewWillDisappearNotification" object:nil];
    UIScreenEdgePanGestureRecognizer *g = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(a:)];
    [g setEdges:UIRectEdgeLeft];
    [self addGestureRecognizer:g];
    
    self.lineMode = XDScaningLineModeDeafult;
    self.lineMoveMode = XDScaningLineMoveModeDown;
    
    self.line = [self creatLine];
    [self addSubview:self.line];
    [self starMove];
}

- (void)a:(UIScreenEdgePanGestureRecognizer *)g{
    [self.delegate view:self didCatchGesture:g];
}

- (UIView *)creatLine{
    
    if (_lineMoveMode == XDScaningLineMoveModeNone) return nil;
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(ScreenSize.width*.5 - TransparentArea([ScanningView width], [ScanningView height]).width*.5, ScreenSize.height*.5 - TransparentArea([ScanningView width], [ScanningView height]).height*.5, TransparentArea([ScanningView width], [ScanningView height]).width, 2)];
    if (_lineMode == XDScaningLineModeDeafult) {
        line.backgroundColor = LineColor;
        self.origin = line.frame.origin.y;
    }
    
    if (_lineMode == XDScaningLineModeImge) {
        line.backgroundColor = [UIColor clearColor];
        self.origin = line.frame.origin.y;
        UIImageView *v = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line@2x.png"]];
        v.contentMode = UIViewContentModeScaleAspectFill;
        v.frame = CGRectMake(0, 0, line.frame.size.width, line.frame.size.height);
        [line addSubview:v];
    }
    
    if (_lineMode == XDScaningLineModeGrid) {
        line.clipsToBounds = YES;
        CGRect frame = line.frame;
        frame.size.height = TransparentArea([ScanningView width], [ScanningView height]).height;
        line.frame = frame;
        UIImageView *iv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"scan_net@2x.png"]];
        iv.frame = CGRectMake(0, -TransparentArea([ScanningView width], [ScanningView height]).height, line.frame.size.width, TransparentArea([ScanningView width], [ScanningView height]).height);
        [line addSubview:iv];
    }
    
    return line;
}

- (void)starMove{
    
    if (_lineMode == XDScaningLineModeDeafult) {  //注意！！！此模式非常消耗性能的哦
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.0125 target:self selector:@selector(showLine) userInfo:nil repeats:YES];
        [self.timer fire];
    }
    
    if (_lineMode == XDScaningLineModeImge) {
        
        [self showLine];
    }
    
    if (_lineMode == XDScaningLineModeGrid) {
        
        UIImageView *iv = _line.subviews[0];
        [UIView animateWithDuration:1.5 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            iv.transform = CGAffineTransformTranslate(iv.transform, 0, TransparentArea([ScanningView width], [ScanningView height]).height);
        } completion:^(BOOL finished) {
            iv.frame = CGRectMake(0, -TransparentArea([ScanningView width], [ScanningView height]).height, _line.frame.size.width, TransparentArea([ScanningView width], [ScanningView height]).height);
            [self starMove];
        }];
    }
}

- (void)showLine{
    
    if (_lineMode == XDScaningLineModeDeafult) {
        CGRect frame = self.line.frame;
        self.isReachEdge?(frame.origin.y -= LineMoveSpeed):(frame.origin.y += LineMoveSpeed);
        self.line.frame = frame;
        
        UIView *shadowLine = [[UIView alloc]initWithFrame:self.line.frame];
        shadowLine.backgroundColor = self.line.backgroundColor;
        [self addSubview:shadowLine];
        [UIView animateWithDuration:LineShadowLastInterval animations:^{
            shadowLine.alpha = 0;
        } completion:^(BOOL finished) {
            [shadowLine removeFromSuperview];
        }];
        
        if (_lineMoveMode == XDScaningLineMoveModeDown) {
            if (self.line.frame.origin.y - self.origin >= TransparentArea([ScanningView width], [ScanningView height]).height) {
                [self.line removeFromSuperview];
                CGRect frame = self.line.frame;
                frame.origin.y = ScreenSize.height*.5 - TransparentArea([ScanningView width], [ScanningView height]).height*.5;
                self.line.frame = frame;
            }
            
        }else if(_lineMoveMode==XDScaningLineMoveModeUpAndDown){
            if (self.line.frame.origin.y - self.origin >= TransparentArea([ScanningView width], [ScanningView height]).height) {
                self.isReachEdge = !self.isReachEdge;
            }else if (self.line.frame.origin.y == self.origin){
                self.isReachEdge = !self.isReachEdge;
            }
        }
    }
    
    if (_lineMode == XDScaningLineModeImge) {
        [self imagelineMoveWithMode:_lineMoveMode];
    }
}

- (void)imagelineMoveWithMode:(XDScaningLineMoveMode)mode{
    
    [UIView animateWithDuration:2 animations:^{
        CGRect frame = self.line.frame;
        frame.origin.y +=  TransparentArea([ScanningView width], [ScanningView height]).height-2;
        self.line.frame = frame;
    } completion:^(BOOL finished) {
        if (mode == XDScaningLineMoveModeDown) {
            CGRect frame = self.line.frame;
            frame.origin.y = ScreenSize.height*.5 - TransparentArea([ScanningView width], [ScanningView height]).height*.5;
            self.line.frame = frame;
            [self imagelineMoveWithMode:mode];
        }else{
            [UIView animateWithDuration:2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                CGRect frame = self.line.frame;
                frame.origin.y = ScreenSize.height*.5 - TransparentArea([ScanningView width], [ScanningView height]).height*.5;
                self.line.frame = frame;
            } completion:^(BOOL finished) {
                [self imagelineMoveWithMode:mode];
            }];
        }
    }];
    
}

- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 40/255.0, 40/255.0, 40/255.0, .5);
    CGContextFillRect(context, rect);
    NSLog(@"%@", NSStringFromCGSize(TransparentArea([ScanningView width], [ScanningView height])));
    CGRect clearDrawRect = CGRectMake(rect.size.width / 2 - TransparentArea([ScanningView width], [ScanningView height]).width / 2,
                                      rect.size.height / 2 - TransparentArea([ScanningView width], [ScanningView height]).height / 2,
                                      TransparentArea([ScanningView width], [ScanningView height]).width,TransparentArea([ScanningView width], [ScanningView height]).height);
    
    CGContextClearRect(context, clearDrawRect);
    [self addWhiteRect:context rect:clearDrawRect];
    [self addCornerLineWithContext:context rect:clearDrawRect];
}

- (void)addWhiteRect:(CGContextRef)ctx rect:(CGRect)rect {
    CGContextStrokeRect(ctx, rect);
    CGContextSetRGBStrokeColor(ctx, 1, 1, 1, 1);
    CGContextSetLineWidth(ctx, 0.8);
    CGContextAddRect(ctx, rect);
    CGContextStrokePath(ctx);
}

- (void)addCornerLineWithContext:(CGContextRef)ctx rect:(CGRect)rect{
    
    //画四个边角
    CGContextSetLineWidth(ctx, 2);
    CGContextSetRGBStrokeColor(ctx, 83 /255.0, 239/255.0, 111/255.0, 1);//绿色
    
    //左上角
    CGPoint poinsTopLeftA[] = {
        CGPointMake(rect.origin.x+0.7, rect.origin.y),
        CGPointMake(rect.origin.x+0.7 , rect.origin.y + 15)
    };
    CGPoint poinsTopLeftB[] = {CGPointMake(rect.origin.x, rect.origin.y +0.7),CGPointMake(rect.origin.x + 15, rect.origin.y+0.7)};
    [self addLine:poinsTopLeftA pointB:poinsTopLeftB ctx:ctx];
    //左下角
    CGPoint poinsBottomLeftA[] = {CGPointMake(rect.origin.x+ 0.7, rect.origin.y + rect.size.height - 15),CGPointMake(rect.origin.x +0.7,rect.origin.y + rect.size.height)};
    CGPoint poinsBottomLeftB[] = {CGPointMake(rect.origin.x , rect.origin.y + rect.size.height - 0.7) ,CGPointMake(rect.origin.x+0.7 +15, rect.origin.y + rect.size.height - 0.7)};
    [self addLine:poinsBottomLeftA pointB:poinsBottomLeftB ctx:ctx];
    //右上角
    CGPoint poinsTopRightA[] = {CGPointMake(rect.origin.x+ rect.size.width - 15, rect.origin.y+0.7),CGPointMake(rect.origin.x + rect.size.width,rect.origin.y +0.7 )};
    CGPoint poinsTopRightB[] = {CGPointMake(rect.origin.x+ rect.size.width-0.7, rect.origin.y),CGPointMake(rect.origin.x + rect.size.width-0.7,rect.origin.y + 15 +0.7 )};
    [self addLine:poinsTopRightA pointB:poinsTopRightB ctx:ctx];
    
    CGPoint poinsBottomRightA[] = {CGPointMake(rect.origin.x+ rect.size.width -0.7 , rect.origin.y+rect.size.height+ -15),CGPointMake(rect.origin.x-0.7 + rect.size.width,rect.origin.y +rect.size.height )};
    CGPoint poinsBottomRightB[] = {CGPointMake(rect.origin.x+ rect.size.width - 15 , rect.origin.y + rect.size.height-0.7),CGPointMake(rect.origin.x + rect.size.width,rect.origin.y + rect.size.height - 0.7 )};
    [self addLine:poinsBottomRightA pointB:poinsBottomRightB ctx:ctx];
    CGContextStrokePath(ctx);
}

- (void)addLine:(CGPoint[])pointA pointB:(CGPoint[])pointB ctx:(CGContextRef)ctx {
    CGContextAddLines(ctx, pointA, 2);
    CGContextAddLines(ctx, pointB, 2);
}

+ (NSInteger)width{
    if (Iphone4||Iphone5) {
        return Iphone45ScanningSize_width;
    }else if(Iphone6){
        return Iphone6ScanningSize_width;
    }else if(Iphone6Plus){
        return Iphone6PlusScanningSize_width;
    }else{
        return Iphone45ScanningSize_width;
    }
}

+ (NSInteger)height{
    if (Iphone4||Iphone5) {
        return Iphone45ScanningSize_height;
    }else if(Iphone6){
        return Iphone6ScanningSize_height;
    }else if(Iphone6Plus){
        return Iphone6PlusScanningSize_height;
    }else{
        return Iphone45ScanningSize_height;
    }
}

- (void)viewWillDisappear:(NSNotification *)noti{
    [self.timer invalidate];
    self.timer = nil;
}
- (void)dealloc{
    NSLog(@"%@dead", self.description);
}

@end


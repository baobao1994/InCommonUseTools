//
//  BroadcastView.h
//  MFun
//
//  Created by Legolas on 4/25/12.
//  Copyright (c) 2012 bodong NetDragon. All rights reserved.
//

@class WinMessage;

@interface BroadcastView : UIView {
    NSMutableArray *_info;
    BOOL _isRevolving;
}

@property (nonatomic, assign) id delegate;
@property (nonatomic, retain) NSMutableArray *info;
@property (nonatomic, readonly) BOOL isRevolving;

- (void)startPlay;
- (void)stopPlay;

@end


@protocol RevolvingDoorDelegate <NSObject>

@optional
- (void)allInfoRevolvingWillFinish;
- (void)didSelectedWinMessage:(WinMessage *)winMessage;

@end
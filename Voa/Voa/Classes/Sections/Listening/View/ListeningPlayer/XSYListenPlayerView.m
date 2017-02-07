//
//  XSYListenPlayerView.m
//  Voa
//
//  Created by xin on 2017/2/7.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "XSYListenPlayerView.h"
#import "UIButton+Helper.h"
#import <Masonry.h>

@interface XSYListenPlayerView ()
@property (nonatomic, strong) UIButton *pauseBtn;
@end

@implementation XSYListenPlayerView
- (instancetype)init{
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        self.backgroundColor = mainColor;
        [self addSubview:self.pauseBtn];
        
        [self addConstraints];
    }
    return self;
}

+ (instancetype)restartPlayerView{
    XSYListenPlayerView *playerView = [[XSYListenPlayerView alloc] init];
    playerView.frame = CGRectMake(screenWidth, 0, screenWidth, screenHeight);
    [[[UIApplication sharedApplication] keyWindow] addSubview:playerView];
    [UIView animateWithDuration:0.5 animations:^{
        playerView.frame = [UIScreen mainScreen].bounds;
    }];
    return playerView;
}

- (void)startPlayerView{
    
}

- (void)pausePlayerView{
    CGRect newFrame = self.frame;
    newFrame.origin.x = screenWidth * 0.9;
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = newFrame;
    }];
    // 暂停播放器
}

- (void)closePlayerView{
    
}

#pragma mark - clickPauseBtn -
- (void)clickPauseBtn:(UIButton *)pauseBtn{
    [self pausePlayerView];
}

- (void)addConstraints{
    [self.pauseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(20);
        make.top.equalTo(self.mas_top).offset(30);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
}

#pragma mark - lazy -
- (UIButton *)pauseBtn{
    if (_pauseBtn == nil) {
        _pauseBtn = [UIButton buttonWithTarget:self action:@selector(clickPauseBtn:) image:nil];
        [_pauseBtn setBackgroundColor:[UIColor redColor]];
    }
    return _pauseBtn;
}

@end

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
#import "XSYListeningContentModel.h"
#import "XSYNetworking.h"
#import "XSYDetailModel.h"
#import <SVProgressHUD.h>

static NSString *cellID = @"contentView";
static XSYListenPlayerView *_playerView;

@interface XSYListenPlayerView ()
@property (nonatomic, strong) UIButton *pauseBtn;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) UIView *bottomBar;
@property (nonatomic, strong) UIButton *playBtn;
@property (nonatomic, strong) UIButton *ch_enBtn;
@property (nonatomic, strong) UISlider *slider;
@property (nonatomic, strong) NSArray<XSYListeningContentModel *> *modelArr;
@property (nonatomic, strong) UITableView *contentView;

@property (nonatomic, assign) PlayerState playerState;
@property (nonatomic, assign) ListeningPlayMode playMode;

@end

@implementation XSYListenPlayerView
+ (instancetype)shared{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _playerView = [[XSYListenPlayerView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        // 增加右边手势
        UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:_playerView action:@selector(rightSwipe:)];
        [_playerView addGestureRecognizer:rightSwipe];
        _playerView.backgroundColor = mainColor;
        _playerView.layer.borderWidth = 5;
        _playerView.layer.cornerRadius = 30;
        _playerView.clipsToBounds = YES;
        _playerView.layer.borderColor = playViewGray.CGColor;
        [_playerView addSubview:_playerView.pauseBtn];
        [_playerView addSubview:_playerView.closeBtn];
        [_playerView addSubview:_playerView.bottomBar];
        [_playerView.bottomBar addSubview:_playerView.slider];
        [_playerView.bottomBar addSubview:_playerView.playBtn];
        [_playerView.contentView addSubview:_playerView.ch_enBtn];
        [_playerView addSubview:_playerView.contentView];
        
        
        [_playerView addConstraints];
    });
    return _playerView;
}

#pragma mark - loadData -
- (void)loadContenData{
    [XSYNetworking getVoaListeningContentWithVoaid:self.model.VoaId successBlock:^(NSArray<XSYListeningContentModel *> *response) {
        self.modelArr = response;
        NSLog(@"%@",self.modelArr);
    } failureBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络不佳"];
    }];
}

#pragma mark - main method -
+ (instancetype)startPlayerView{
    XSYListenPlayerView *playerView = [XSYListenPlayerView shared];
    playerView.frame = CGRectMake(screenWidth, 0, screenWidth, screenHeight);
    [[[UIApplication sharedApplication] keyWindow] addSubview:playerView];
    [UIView animateWithDuration:0.5 animations:^{
        playerView.frame = [UIScreen mainScreen].bounds;
    }completion:^(BOOL finished) {
        playerView.pauseBtn.selected = NO;
        playerView.playerState = More;
    }];
    return playerView;
}

- (void)morePlayerView{
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = [UIScreen mainScreen].bounds;
    }completion:^(BOOL finished) {
        self.playerState = More;
    }];
}

- (void)backPlayerView{
    CGRect newFrame = self.frame;
    newFrame.origin.x = screenWidth * 0.9;
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = newFrame;
    }completion:^(BOOL finished) {
        self.playerState = Back;
    }];
}

- (void)closePlayerView{
    CGRect newFrame = self.frame;
    newFrame.origin.x = screenWidth;
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = newFrame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        self.playMode = ListeningStopping;
    }];
}

#pragma mark - clickBtn -
- (void)clickPauseBtn:(UIButton *)pauseBtn{
    pauseBtn.selected = !pauseBtn.selected;
    if (self.pauseBtn.selected == YES) {
        [self backPlayerView];
    }else{
        [self morePlayerView];
    }
}

- (void)clickCh_enBtn:(UIButton *)ch_enBtn{
    ch_enBtn.selected = !ch_enBtn.selected;
}

- (void)clickCloseBtn:(UIButton *)closeBtn{
    [self closePlayerView];
}

- (void)sliderChange:(UISlider *)slider{
    NSLog(@"%s",__func__);
}

- (void)clickPlayBtn:(UIButton *)playBtn{
    playBtn.selected = !playBtn.selected;
    self.playMode = playBtn.selected == YES ? ListeningPausing : ListeningPlaying;
//    if (self.playMode == ListeningPlaying) {
//        [self loadContenData];
//    }
    NSLog(@"%s",__func__);
}

#pragma mark - gesture -
- (void)rightSwipe:(UISwipeGestureRecognizer *)rightSwift{
    CGRect newFrame = self.frame;
    newFrame.origin.x = screenWidth * 0.9;
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = newFrame;
    }completion:^(BOOL finished) {
        self.playerState = Back;
        self.pauseBtn.selected = YES;
    }];
}

- (void)ch_enBtnPan:(UIPanGestureRecognizer *)pan{
    CGPoint pointMove = [pan translationInView:pan.view];
    self.ch_enBtn.transform = CGAffineTransformTranslate(self.ch_enBtn.transform,pointMove.x, pointMove.y);
    [pan setTranslation:CGPointZero inView:pan.view];
}

#pragma mark - makeConstraints -
- (void)addConstraints{
    [self.pauseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(10);
        make.top.equalTo(self.mas_top).offset(30);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self).offset(-10);
        make.top.equalTo(self.pauseBtn);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [self.bottomBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self);
        make.height.mas_equalTo(screenHeight * 0.16);
    }];
    
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.bottomBar).offset(20);
        make.trailing.equalTo(self.bottomBar).offset(-20);
        make.top.equalTo(self.bottomBar).offset(10);
        make.height.mas_equalTo(20);
    }];
    
    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bottomBar);
        make.bottom.equalTo(self.bottomBar).offset(-20);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [self.ch_enBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.closeBtn);
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.top.equalTo(self.closeBtn.mas_bottom).offset(20);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.pauseBtn);
        make.trailing.equalTo(self.mas_trailing).offset(-10);
        make.top.equalTo(self.pauseBtn.mas_bottom).offset(10);
        make.bottom.equalTo(self.bottomBar.mas_top).offset(-10);
    }];
}

#pragma mark - lazy -
- (UIButton *)pauseBtn{
    if (_pauseBtn == nil) {
        _pauseBtn = [UIButton buttonWithTarget:self action:@selector(clickPauseBtn:) image:@"back" selectBackgroundImage:@"more"];
    }
    return _pauseBtn;
}

- (UIButton *)closeBtn{
    if (_closeBtn == nil) {
        _closeBtn = [UIButton buttonWithTarget:self action:@selector(clickCloseBtn:) image:@"close" selectBackgroundImage:nil];
    }
    return _closeBtn;
}

- (UIView *)bottomBar{
    if (_bottomBar == nil) {
        _bottomBar = [[UIView alloc] init];
        _bottomBar.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
    }
    return _bottomBar;
}

- (UISlider *)slider{
    if (_slider == nil) {
        _slider = [[UISlider alloc] init];
        _slider.minimumValue = 0.00;
        _slider.maximumValue = 1.00;
        _slider.continuous = YES;
        _slider.minimumTrackTintColor = mainColor;
        _slider.maximumTrackTintColor = [UIColor whiteColor];
        _slider.thumbTintColor = playViewGray;
        [_slider addTarget:self action:@selector(sliderChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _slider;
}

- (UIButton *)playBtn{
    if (_playBtn == nil) {
        _playBtn = [UIButton buttonWithTarget:self action:@selector(clickPlayBtn:) image:@"zanting" selectBackgroundImage:@"bofang"];
    }
    return _playBtn;
}

- (UIButton *)ch_enBtn{
    if (_ch_enBtn == nil) {
        _ch_enBtn = [UIButton buttonWithTarget:self action:@selector(clickCh_enBtn:) image:@"English" selectBackgroundImage:@"Ch_En"];
        [_ch_enBtn setBackgroundColor:[UIColor clearColor]];
        // 加个手势
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(ch_enBtnPan:)];
        [_ch_enBtn addGestureRecognizer:pan];
    }
    return _ch_enBtn;
}

- (UITableView *)contentView{
    if (_contentView == nil) {
        _contentView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _contentView.backgroundColor = [UIColor clearColor];
        // 注册
        [_contentView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    }
    return _contentView;
}
@end

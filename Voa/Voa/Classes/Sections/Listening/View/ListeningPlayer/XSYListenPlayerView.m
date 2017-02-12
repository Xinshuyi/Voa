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
#import <FSAudioStream.h>
#import "XSYListeningContentCell.h"
#import "UILabel+Helper.h"

static NSString *cellID = @"contentView";
static XSYListenPlayerView *_playerView;

@interface XSYListenPlayerView ()<UITableViewDelegate, UITableViewDataSource>
/** 播放器界面*/
@property (nonatomic, strong) FSAudioStream *audioStream;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) UIView *bottomBar;
@property (nonatomic, strong) UIButton *playBtn;
@property (nonatomic, strong) UIButton *ch_enBtn;
@property (nonatomic, strong) UISlider *slider;
@property (nonatomic, strong) UILabel *startLbl;
@property (nonatomic, strong) UILabel *endLbl;
/** 其他*/
@property (nonatomic, strong) UIButton *pauseBtn;
@property (nonatomic, strong) NSArray<XSYListeningContentModel *> *modelArr;
@property (nonatomic, strong) NSTimer *timer;


@property (nonatomic, strong) UITableView *contentView;
@property (nonatomic, strong) NSIndexPath *NewIndexPath;
@property (nonatomic, strong) NSIndexPath *pastIndexPath;
@property (nonatomic, assign) NSInteger lastIndex;



@property (nonatomic, assign) PlayerState playerState;
@property (nonatomic, assign) ListeningPlayMode playMode;
@end

@implementation XSYListenPlayerView
+ (instancetype)shared{
    if(_playerView == nil){
        _playerView = [[XSYListenPlayerView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        // 增加左边手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:_playerView action:@selector(tapLeft:)];
        [_playerView addGestureRecognizer:tap];
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
        [_playerView addSubview:_playerView.startLbl];
        [_playerView addSubview:_playerView.endLbl];
        [_playerView addConstraints];
    }
    return _playerView;
}

#pragma mark - loadData -
- (void)loadContenData{
    [XSYNetworking getVoaListeningContentWithVoaid:self.model.VoaId successBlock:^(NSArray<XSYListeningContentModel *> *response) {
        self.modelArr = response;
        [self.contentView reloadData];
        NSLog(@"%@",self.modelArr);
    } failureBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络不佳"];
    }];
}

#pragma mark - main method -
+ (instancetype)startPlayerView{
    XSYListenPlayerView *playerView = [XSYListenPlayerView shared];
    playerView.frame = CGRectMake(screenWidth, 0, screenWidth, screenHeight);
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

#pragma mark - setModel -
- (void)setModel:(XSYDetailModel *)model{
    _model = model;
    if (model != nil) {
        // 定时器清零
        if (self.timer != nil) {
            [self stopTimer];
        }
        [self startTimer];
        // 加载音频
        NSString *urlStr = [NSString stringWithFormat:@"http://static.iyuba.com/sounds/voa%@", self.model.Sound];
        self.audioStream.url = [NSURL URLWithString:urlStr];
        [self.audioStream play];
        // 监听播放器状态改变
        [self playStatusChanged];
        self.lastIndex = 0;
        // 加载中英文内容
        [self loadContenData];
    }
}

- (void)playStatusChanged{
    __weak XSYListenPlayerView *weakSelf = self;
    
    self.audioStream.onStateChange = ^(FSAudioStreamState state){
        switch (state) {
            case kFsAudioStreamRetrievingURL:
                
                break;
            case kFsAudioStreamPlaying:// 播放中
            {
                // 重启定时器
                [weakSelf startTimer];
                // slidermax value
                FSStreamPosition position = weakSelf.audioStream.duration;
                weakSelf.slider.maximumValue = (float)(position.minute * 60 + position.second);
                weakSelf.endLbl.text = [NSString stringWithFormat:@"%d:%02d",position.minute, position.second];
                NSLog(@"totalTime%f",weakSelf.slider.maximumValue);
            }
            case kFsAudioStreamBuffering:// 缓冲中
            {
            }
                break;
            case kFsAudioStreamSeeking:// 跳到指定位置中
                break;
            case kFsAudioStreamPaused:// 暂停
                
                break;
            case kFsAudioStreamStopped:
                break;
            case kFsAudioStreamFailed:
                
                break;
            case kFsAudioStreamRetryingStarted:
                //                    [MBProgressHUD showError:@"正在尝试重练"];
                break;
            default:
                break;
        }
    };
    
}

#pragma mark - timer -
- (void)startTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(handleTimer) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)handleTimer{
    FSStreamPosition position = self.audioStream.currentTimePlayed;
    self.slider.value = (float)(position.minute * 60 + position.second);
    NSInteger rightNum = [self selectRightNum:self.slider.value];
    self.NewIndexPath = [NSIndexPath indexPathForRow:rightNum inSection:0];
    self.startLbl.text = [NSString stringWithFormat:@"%d:%02d",position.minute,position.second];
    if (self.modelArr != nil) {
        [self.contentView selectRowAtIndexPath:self.NewIndexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    }
    NSLog(@"当前时间：%f",self.slider.value);
}

#pragma mark - 找到正确时间 -
- (NSInteger)selectRightNum:(CGFloat)value{
    if (self.modelArr != nil) {
        for (NSInteger i = 0; i < self.modelArr.count; i++) {
            XSYListeningContentModel *model = self.modelArr[i];
            if (i + 1 < self.modelArr.count) {
                XSYListeningContentModel *nextModel = self.modelArr[i + 1];
                if (nextModel.Timing.floatValue >= self.slider.value && model.Timing.intValue <= self.slider.value) {
                    self.lastIndex = i;
                    return i;
                }
            }
        }
        if (value < self.modelArr[0].Timing.floatValue) {
            return 0;
        }else{
            return self.modelArr.count - 1;
        }
    }
    return 0;
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
    [self.contentView reloadData];
}

- (void)clickCloseBtn:(UIButton *)closeBtn{
    [self closePlayerView];
    [self.audioStream stop];
}

- (void)sliderChange:(UISlider *)slider{
    NSLog(@"%s",__func__);
    FSStreamPosition position = {0};
    position.position = slider.value / slider.maximumValue;
    [self.audioStream seekToPosition:position];
}

- (void)clickPlayBtn:(UIButton *)playBtn{
    playBtn.selected = !playBtn.selected;
    self.playMode = playBtn.selected == YES ? ListeningPausing : ListeningPlaying;
    [self.audioStream pause];
    NSLog(@"%s",__func__);
}

#pragma mark - tableview datasoure and delegate -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XSYListeningContentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.model = self.modelArr[indexPath.row];
    cell.isEnglishOnly = !self.ch_enBtn.isSelected;
    return cell;
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

- (void)tapLeft:(UITapGestureRecognizer *)tap{
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = [UIScreen mainScreen].bounds;
    }completion:^(BOOL finished) {
        self.playerState = More;
        self.pauseBtn.selected = NO;
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
        make.leading.equalTo(self.startLbl.mas_trailing).offset(1);
        make.trailing.equalTo(self.endLbl.mas_leading).offset(-1);
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
    
    [self.startLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.slider);
        make.leading.equalTo(self).offset(6);
    }];
    
    [self.endLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.slider);
        make.trailing.equalTo(self).offset(-6);
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
        _ch_enBtn = [UIButton buttonWithTarget:self action:@selector(clickCh_enBtn:) image:@"Ch_En" selectBackgroundImage:@"English"];
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
        // 自定义行高
        _contentView.estimatedRowHeight = 2;
        _contentView.rowHeight = UITableViewAutomaticDimension;
        // datasource and delegate
        _contentView.dataSource = self;
        _contentView.delegate = self;
        // 注册
        [_contentView registerClass:[XSYListeningContentCell class] forCellReuseIdentifier:cellID];
        _contentView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _contentView;
}

- (FSAudioStream *)audioStream{
    if (_audioStream == nil) {
        FSStreamConfiguration *configuration = [[FSStreamConfiguration alloc] init];
        configuration.cacheEnabled = YES;
        configuration.seekingFromCacheEnabled = YES;
        // 设置缓存路径
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        configuration.cacheDirectory = path;
        
        _audioStream = [[FSAudioStream alloc] initWithConfiguration:configuration];
        [_audioStream setVolume:0.5];//设置声音
    }
    return _audioStream;
}

- (UILabel *)startLbl{
    if (_startLbl == nil) {
        _startLbl = [UILabel labelWithtextColor:playViewGray font:[UIFont systemFontOfSize:11]];
    }
    return _startLbl;
}

- (UILabel *)endLbl{
    if (_endLbl == nil) {
        _endLbl = [UILabel labelWithtextColor:playViewGray font:[UIFont systemFontOfSize:11]];
    }
    return _endLbl;
}
@end

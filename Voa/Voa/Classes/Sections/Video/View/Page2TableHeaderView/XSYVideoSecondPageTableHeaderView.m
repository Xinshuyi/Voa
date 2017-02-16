//
//  XSYVideoSecondPageTableHeaderView.m
//  Voa
//
//  Created by xin on 2017/2/16.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "XSYVideoSecondPageTableHeaderView.h"
#import "XSYVideoSecondPageMainModel.h"
#import <Masonry.h>
#import "UILabel+Helper.h"
#import "CZAdditions.h"
#import <UIImageView+WebCache.h>

typedef NS_ENUM(NSUInteger, ShadowViewStatus) {
    ShadowViewStatusHidden,
    ShadowViewStatusShow
};

@interface XSYVideoSecondPageTableHeaderView ()
@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic, strong) UILabel *playCountLabel;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *tagsLabel;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UILabel *shadowView;
@property (nonatomic, assign) ShadowViewStatus isShadowShow;

@end

@implementation XSYVideoSecondPageTableHeaderView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = mainColor;
        [self addSubview:self.topImageView];
        [self.topImageView addSubview:self.playCountLabel];
        [self addSubview:self.typeLabel];
        [self addSubview:self.tagsLabel];
        [self addSubview:self.leftImageView];
        [self addSubview:self.descLabel];
        [self.descLabel addSubview:self.shadowView];
        [self addConstraint];
    }
    return self;
}

#pragma mark - addConstraints -
- (void)addConstraint{
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(15);
        make.trailing.equalTo(self).offset(-15);
        make.top.equalTo(self).offset(20);
        make.height.equalTo(self).multipliedBy(0.55);
    }];
    
    [self.playCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.topImageView).offset(-8);
        make.trailing.equalTo(self.topImageView).offset(-8);
    }];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topImageView.mas_bottom).offset(5);
        make.leading.equalTo(self.topImageView).offset(10);
    }];

    [self.tagsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.topImageView);
        make.top.equalTo(self.typeLabel.mas_bottom).offset(5);
    }];
    
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.topImageView);
        make.top.equalTo(self.typeLabel.mas_bottom).offset(5);
        make.bottom.equalTo(self).offset(-10);
        make.width.equalTo(self.topImageView).multipliedBy(0.25);
    }];
    
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.leftImageView.mas_trailing).offset(8);
        make.top.equalTo(self.tagsLabel).offset(5);
        make.trailing.equalTo(self.topImageView);
        make.bottom.equalTo(self.leftImageView);
    }];
    
    [self.shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.mas_trailing);
        make.top.equalTo(self.descLabel);
        make.size.equalTo(self.descLabel);
    }];
}

#pragma gesture and events
- (void)tapMoreDescLabel{
    if (self.isShadowShow == ShadowViewStatusHidden) {
        [self.shadowView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.descLabel);
        }];
        [UIView animateWithDuration:0.5 animations:^{
            [self.shadowView layoutIfNeeded];
        } completion:^(BOOL finished) {
            self.isShadowShow = ShadowViewStatusShow;
        }];
    }
}

- (void)tapShadowView{
    if (self.isShadowShow == ShadowViewStatusShow) {
        if ([self.delegate respondsToSelector:@selector(secondPageTableHeaderView:disTapMoreShadowView:WithModel:)]) {
            [self.delegate secondPageTableHeaderView:self disTapMoreShadowView:self.shadowView WithModel:_model];
            
            [self.shadowView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.leading.equalTo(self.mas_trailing);
                make.top.equalTo(self.descLabel);
                make.size.equalTo(self.descLabel);
            }];
            [UIView animateWithDuration:0.5 animations:^{
                [self.shadowView layoutIfNeeded];
            } completion:^(BOOL finished) {
                self.isShadowShow = ShadowViewStatusHidden;
            }];
        }
    }
    
}

#pragma mark - setmethod -
- (void)setModel:(XSYVideoSecondPageMainModel *)model{
    _model = model;
    [self.topImageView sd_setImageWithURL:[NSURL URLWithString:model.largeimgurl] placeholderImage:[UIImage imageNamed:@"placeHolderImage"]];
    self.playCountLabel.text = [NSString stringWithFormat:@"播放总数 : %ld",model.playcount];
    self.typeLabel.text = [NSString stringWithFormat:@"标签 : %@",model.type];
    self.tagsLabel.text = [NSString stringWithFormat:@"%@",model.tags];
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:model.imgpath] placeholderImage:[UIImage imageNamed:@"placeHolderImage"]];
    self.descLabel.text = model.desc;
}

- (void)setContentOffsetY:(CGFloat)contentOffsetY{
    _contentOffsetY = contentOffsetY;
    [self.topImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(20 + contentOffsetY);
        make.height.equalTo(self).multipliedBy(0.55).offset(-contentOffsetY);
    }];
}

#pragma mark - lazy -
- (UIImageView *)topImageView{
    if (_topImageView == nil) {
        _topImageView = [[UIImageView alloc] init];
        _topImageView.contentMode = UIViewContentModeScaleAspectFill;
        _topImageView.clipsToBounds = YES;
    }
    return _topImageView;
}

- (UILabel *)playCountLabel{
    if (_playCountLabel == nil) {
        _playCountLabel = [UILabel labelWithtextColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:17]];
        _playCountLabel.backgroundColor = [UIColor redColor];
        _playCountLabel.layer.cornerRadius = 5;
        _playCountLabel.clipsToBounds = YES;
    }
    return _playCountLabel;
}

- (UILabel *)typeLabel{
    if (_typeLabel == nil) {
        _typeLabel = [UILabel labelWithtextColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:20]];
        _typeLabel.layer.cornerRadius = 7;
        _typeLabel.clipsToBounds = YES;
        _typeLabel.backgroundColor = [UIColor cz_colorWithRed:108 green:118 blue:78];
    }
    return _typeLabel ;
}

- (UILabel *)tagsLabel{
    if (_tagsLabel == nil) {
        _tagsLabel = [UILabel labelWithtextColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:15]];
        _tagsLabel.backgroundColor = [UIColor darkGrayColor];
        _tagsLabel.layer.cornerRadius = 5;
        _tagsLabel.clipsToBounds = YES;
    }
    return _tagsLabel;
}

- (UIImageView *)leftImageView{
    if (_leftImageView == nil) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.contentMode = UIViewContentModeScaleAspectFill;
        _leftImageView.clipsToBounds = YES;
    }
    return _leftImageView;
}

- (UILabel *)descLabel{
    if (_descLabel == nil) {
        _descLabel = [UILabel labelWithtextColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:15]];
        _descLabel.numberOfLines = 5;
        _descLabel.userInteractionEnabled = YES;
        // 添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMoreDescLabel)];
        [_descLabel addGestureRecognizer:tap];
    }
    return _descLabel;
}

- (UILabel *)shadowView{
    if (_shadowView == nil) {
        _shadowView = [UILabel labelWithtextColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:20] text:@"查看更多"];
        _shadowView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
        _shadowView.textAlignment = NSTextAlignmentCenter;
        // 添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapShadowView)];
        _shadowView.userInteractionEnabled = YES;
        [_shadowView addGestureRecognizer:tap];
    }
    return _shadowView;
}
@end

//
//  XSYMineHeaderView.m
//  Voa
//
//  Created by xin on 2017/2/13.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "XSYMineHeaderView.h"
#import <Masonry.h>
#import "UILabel+Helper.h"

@interface XSYMineHeaderView ()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *nameLbl;
@property (nonatomic, strong) UILabel *detailLbl;

@end

@implementation XSYMineHeaderView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.lineView];
        [self addSubview:self.iconView];
        [self addSubview:self.nameLbl];
        [self addSubview:self.detailLbl];
        [self addConstraints];
    }
    return self;
}

- (void)addConstraints{
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self);
        make.height.mas_offset(0.5);
        make.bottom.equalTo(self).offset(- screenHeight * 0.05);
    }];
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(8);
        make.top.equalTo(self).offset(8);
        make.size.mas_equalTo(CGSizeMake(screenHeight * 0.1, screenHeight * 0.1));
    }];
    
    [self.nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.iconView);
        make.leading.equalTo(self.iconView.mas_trailing).offset(8);
    }];
    
    [self.detailLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.iconView);
        make.top.equalTo(self.lineView.mas_bottom).offset(8);
    }];
}

#pragma mark - lazy -
- (UIImageView *)iconView{
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"placeHolderImage"]];
        _iconView.contentMode = UIViewContentModeScaleAspectFill;
        _iconView.layer.cornerRadius = screenHeight * 0.05;
        _iconView.layer.masksToBounds = YES;
    }
    return _iconView;
}

- (UILabel *)nameLbl{
    if (_nameLbl == nil) {
        _nameLbl = [UILabel labelWithtextColor:mainColor font:[UIFont systemFontOfSize:15]];
        _nameLbl.text = @"怡宝宝";
    }
    return _nameLbl;
}

- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = backgroundGray;
    }
    return _lineView;
}

- (UILabel *)detailLbl{
    if (_detailLbl == nil) {
        _detailLbl = [UILabel labelWithtextColor:mainColor font:[UIFont systemFontOfSize:12]];
        _detailLbl.text = @"吃饭睡觉打狗子";
    }
    return _detailLbl;
}
@end

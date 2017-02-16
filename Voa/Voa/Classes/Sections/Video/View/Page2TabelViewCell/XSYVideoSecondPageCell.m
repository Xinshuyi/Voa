//
//  XSYVideoSecondPageCell.m
//  Voa
//
//  Created by xin on 2017/2/16.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "XSYVideoSecondPageCell.h"
#import "XSYVideoSecondPageListsModel.h"
#import "UILabel+Helper.h"
#import <UIImageView+WebCache.h>
#import <Masonry.h>

@interface XSYVideoSecondPageCell ()
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subtitleLabel;
@property (nonatomic, strong) UILabel *subtitle_languageLabel;
@end

@implementation XSYVideoSecondPageCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.subtitleLabel];
        [self.contentView addSubview:self.subtitle_languageLabel];
        [self addConstraints];
    }
    return self;
}

#pragma mark - addConstraints -
- (void)addConstraints{
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(20);
        make.centerY.equalTo(self.contentView);
        make.width.equalTo(self.contentView).multipliedBy(0.35);
        make.height.equalTo(self.iconView.mas_width).multipliedBy(0.618);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.iconView.mas_trailing).offset(15);
        make.top.equalTo(self.iconView);
        make.trailing.lessThanOrEqualTo(self.contentView).offset(-8);
    }];
    
    [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.iconView);
        make.top.equalTo(self.iconView.mas_bottom).offset(8);
        make.bottom.equalTo(self.contentView).offset(-8);
    }];
    
    [self.subtitle_languageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.subtitleLabel);
        make.trailing.equalTo(self.titleLabel);
    }];
}

#pragma mark - set method -
- (void)setModel:(XSYVideoSecondPageListsModel *)model{
    _model = model;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.imgpath] placeholderImage:[UIImage imageNamed:@"placeHolderImage"]];
    self.titleLabel.text = model.title;
    self.subtitleLabel.text = [NSString stringWithFormat:@"%@原声",model.subtitle];
    self.subtitle_languageLabel.text = [NSString stringWithFormat:@"%@字幕",model.subtitle_language];
}

#pragma mark - lazy -
- (UIImageView *)iconView{
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] init];
        _iconView.contentMode = UIViewContentModeScaleAspectFill;
        _iconView.layer.masksToBounds = YES;
    }
    return _iconView;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [UILabel labelWithtextColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:20]];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UILabel *)subtitleLabel{
    if (_subtitleLabel == nil) {
        _subtitleLabel = [UILabel labelWithtextColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:15]];
    }
    return _subtitleLabel;
}

- (UILabel *)subtitle_languageLabel{
    if (_subtitle_languageLabel == nil) {
        _subtitle_languageLabel = [UILabel labelWithtextColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:17]];
    }
    return _subtitle_languageLabel;
}
@end

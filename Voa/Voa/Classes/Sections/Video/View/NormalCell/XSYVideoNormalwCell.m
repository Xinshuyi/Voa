//
//  XSYVideoNormalwCell.m
//  Voa
//
//  Created by xin on 2017/2/15.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "XSYVideoNormalwCell.h"
#import "UILabel+Helper.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import "XSYVideoFirstPageTopicModel.h"

@interface XSYVideoNormalwCell ()
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *desc_subLabel;
@property (nonatomic, strong) UIView *shadowView;
@end

@implementation XSYVideoNormalwCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.iconView];
        [self.iconView addSubview:self.shadowView];
        [self.shadowView addSubview:self.titleLabel];
        [self.shadowView addSubview:self.desc_subLabel];
        [self addConstraints];
    }
    return self;
}

#pragma mark - addConstraints -
- (void)addConstraints{
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [self.shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.iconView);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.shadowView).offset(3);
        make.bottom.equalTo(self.desc_subLabel.mas_top).offset(-5);
    }];
    
    [self.desc_subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.titleLabel);
        make.bottom.equalTo(self.contentView).offset(-2);
    }];
}

#pragma mark - set method -
- (void)setModel:(XSYVideoFirstPageTopicModel *)model{
    _model = model;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.picUrl] placeholderImage:[UIImage imageNamed:@"placeHolderImage"]];
    self.titleLabel.text = model.title;
    self.desc_subLabel.text = [NSString stringWithFormat:@"%@ %@",model.subtitle,model.desc];
}

#pragma mark - lazy -
- (UIImageView *)iconView{
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] init];
        _iconView.contentMode = UIViewContentModeScaleAspectFill;
        _iconView.clipsToBounds = YES;
    }
    return _iconView;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [UILabel labelWithtextColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:10]];
    }
    return _titleLabel;
}

- (UILabel *)desc_subLabel{
    if (_desc_subLabel == nil) {
        _desc_subLabel = [UILabel labelWithtextColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:8]];
    }
    return _desc_subLabel;
}

- (UIView *)shadowView{
    if (_shadowView == nil) {
        _shadowView = [[UIView alloc] init];
        _shadowView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    }
    return _shadowView;
}
@end

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
@end

@implementation XSYVideoNormalwCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.desc_subLabel];
        [self addConstraints];
    }
    return self;
}

#pragma mark - addConstraints -
- (void)addConstraints{
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.equalTo(self.contentView);
        make.height.equalTo(self.contentView.mas_width).multipliedBy(0.618);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView);
        make.top.equalTo(self.iconView.mas_bottom);
        make.trailing.equalTo(self.contentView);
        make.bottom.equalTo(self.desc_subLabel.mas_top).offset(-5);
    }];
    
    [self.desc_subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.titleLabel);
        make.bottom.equalTo(self.contentView).offset(-2);
        make.trailing.equalTo(self.contentView);
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
        _titleLabel = [UILabel labelWithtextColor:[UIColor blackColor] font:[UIFont systemFontOfSize:14]];
    }
    return _titleLabel;
}

- (UILabel *)desc_subLabel{
    if (_desc_subLabel == nil) {
        _desc_subLabel = [UILabel labelWithtextColor:[UIColor blackColor] font:[UIFont systemFontOfSize:10]];
    }
    return _desc_subLabel;
}

@end

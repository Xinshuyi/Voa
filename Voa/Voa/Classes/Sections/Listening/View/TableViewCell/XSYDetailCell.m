//
//  XSYDetailCell.m
//  Voa
//
//  Created by xin on 2017/2/6.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "XSYDetailCell.h"
#import <Masonry.h>
#import "UILabel+Helper.h"
#import "XSYDetailModel.h"
#import <UIImageView+WebCache.h>

@interface XSYDetailCell ()

@property (nonatomic, strong) UILabel *titleView;
@property (nonatomic, strong) UILabel *titleCnView;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UIView *shadowView;
@property (nonatomic, strong) UILabel *readCountLbl;
@property (nonatomic, strong) UILabel *timeLbl;


@end

@implementation XSYDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.iconView];
        [self.iconView addSubview:self.shadowView];
        [self.shadowView addSubview:self.titleView];
        [self.shadowView addSubview:self.titleCnView];
        [self.shadowView addSubview:self.readCountLbl];
        [self.shadowView addSubview:self.timeLbl];
        [self addConstraints];
    }
    return self;
}

- (void)addConstraints{
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];

    [self.shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.iconView)
        ;
    }];
    
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.shadowView);
        make.centerY.equalTo(self.shadowView).offset(-15);
        make.leading.equalTo(self.contentView).offset(20);
        make.trailing.equalTo(self.contentView).offset(-20);
    }];
    
    [self.titleCnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.shadowView);
        make.centerY.equalTo(self.shadowView).offset(15);
        make.leading.equalTo(self.contentView).offset(20);
        make.trailing.equalTo(self.contentView).offset(-20);
    }];
    
    [self.readCountLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.shadowView).offset(-10);
        make.bottom.equalTo(self.timeLbl.mas_top).offset(-5);
    }];

    [self.timeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.readCountLbl);
        make.bottom.equalTo(self.shadowView).offset(-5);
    }];
}


- (void)setModel:(XSYDetailModel *)model{
    _model = model;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.Pic] placeholderImage:[UIImage imageNamed:@"placeHolderImage"]];
    self.titleView.text = model.Title;
    self.titleCnView.text = model.Title_cn;
    self.readCountLbl.text = [NSString stringWithFormat:@"%@次播放",model.ReadCount];
    self.timeLbl.text = model.CreatTime;
}


#pragma mark - lazy -

- (UILabel *)titleView{
    if (_titleView == nil) {
        _titleView = [UILabel labelWithtextColor:[UIColor whiteColor] font:[UIFont boldSystemFontOfSize:18]];
        _titleView.textAlignment = NSTextAlignmentCenter;
    }
    return _titleView;
}

- (UILabel *)titleCnView{
    if (_titleCnView == nil) {
        _titleCnView = [UILabel labelWithtextColor:[UIColor whiteColor] font:[UIFont boldSystemFontOfSize:15]];
        _titleCnView.textAlignment = NSTextAlignmentCenter;
    }
    return _titleCnView;
}

- (UIImageView *)iconView{
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] init];
        _iconView.contentMode = UIViewContentModeScaleAspectFill;
        _iconView.layer.masksToBounds = YES;
    }
    return _iconView;
}

- (UIView *)shadowView{
    if (_shadowView == nil) {
        _shadowView = [[UIView alloc] init];
        _shadowView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    }
    return _shadowView;
}

- (UILabel *)readCountLbl{
    if (_readCountLbl == nil) {
        _readCountLbl = [UILabel labelWithtextColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:10]];
    }
    return _readCountLbl;
}

- (UILabel *)timeLbl{
    if (_timeLbl == nil) {
        _timeLbl = [UILabel labelWithtextColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:10]];
    }
    return _timeLbl;
}
@end

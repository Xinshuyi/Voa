//
//  XSYEssayCell.m
//  Voa
//
//  Created by xin on 2017/2/12.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "XSYEssayCell.h"
#import "UILabel+Helper.h"
#import <Masonry.h>
#import "XSYEssayMainModel.h"
#import "XSYEssayDataModel.h"
#import "XSYEssayImageModel.h"
#import <UIImageView+WebCache.h>
#import <SDWebImageManager.h>

@interface XSYEssayCell ()
@property (nonatomic, strong) UILabel *contenLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *iconView;
@end

@implementation XSYEssayCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.contenLabel];
        [self addConstraints];
    }
    return self;
}

- (void)addConstraints{
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.contentView).offset(10);
    }];
    
    [self.contenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.timeLabel);
        make.top.equalTo(self.iconView.mas_bottom).offset(10);
    }];
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.timeLabel);
        make.top.equalTo(self.timeLabel.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
}

#pragma mark - setModel -
- (void)setModel:(XSYEssayMainModel *)model{
    _model = model;
    self.timeLabel.text = model.createdAt;
    self.contenLabel.text = model.dataModel.text;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.dataModel.image.url] placeholderImage:[UIImage imageNamed:@"placeHolderImage"]];
    // 重写计算图片尺寸
    CGSize imageSize = [self calculateIMAGESizeWithModel:model];
    [self.iconView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(imageSize);
    }];
}
#pragma mark - 计算图片尺寸 -
- (CGSize)calculateIMAGESizeWithModel:(XSYEssayMainModel *)model{
    // 获取图片
    UIImage *image = [[[SDWebImageManager sharedManager] imageCache] imageFromDiskCacheForKey:model.dataModel.image.url];
    CGSize imageSize;
    if (image.size.width > screenWidth) {
        imageSize.height = image.size.width / screenWidth * screenHeight;
        imageSize.width = screenWidth;
    }else{
        imageSize.height = image.size.height;
        imageSize.width = image.size.width;
    }
    return imageSize;
}

#pragma mark - lazy -
- (UILabel *)contenLabel{
    if (_contenLabel == nil) {
        _contenLabel = [UILabel labelWithtextColor:mainColor font:[UIFont systemFontOfSize:14]];
        _contenLabel.preferredMaxLayoutWidth = screenWidth - 20;
        _contenLabel.numberOfLines = 0;
    }
    return _contenLabel;
}

- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [UILabel labelWithtextColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:12]];
    }
    return _timeLabel;
}

- (UIImageView *)iconView{
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] init];
    }
    return _iconView;
}
@end

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
#import "XSYCopyingLabel.h"
#import "SDPhotoBrowser.h"

@interface XSYEssayCell ()<SDPhotoBrowserDelegate>
@property (nonatomic, strong) UITextView *contenLabel;
@property (nonatomic, strong) XSYCopyingLabel *timeLabel;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UIImageView *lineView;
@property (nonatomic, strong) UIView *shadowView;
@end

@implementation XSYEssayCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.contenLabel];
        [self.contentView addSubview:self.lineView];
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
        make.trailing.equalTo(self.contentView).offset(-10);
    }];
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.timeLabel);
        make.top.equalTo(self.timeLabel.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(screenWidth - 20, (screenWidth - 20) * 0.618));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.contentView);
        make.height.mas_equalTo(15);
        make.top.equalTo(self.contenLabel.mas_bottom).offset(10);
        make.bottom.equalTo(self.contentView);
    }];
}

#pragma mark - setModel -
- (void)setModel:(XSYEssayMainModel *)model{
    _model = model;
    NSRange timeRang = [model.createdAt rangeOfString:@"T"];
    NSString *timeStr = [model.createdAt substringToIndex:timeRang.location];
    self.timeLabel.text = timeStr;
    self.contenLabel.text = model.dataModel.text;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.dataModel.image.url] placeholderImage:[UIImage imageNamed:@"placeHolderImage"]];
//    // 重写计算图片尺寸
//    CGSize imageSize = [self calculateIMAGESizeWithModel:model];
//    [self.iconView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(imageSize);
//    }];
}
#pragma mark - 计算图片尺寸 -
- (CGSize)calculateIMAGESizeWithModel:(XSYEssayMainModel *)model{
    // 获取图片
    UIImage *image = [[[SDWebImageManager sharedManager] imageCache] imageFromDiskCacheForKey:model.dataModel.image.URL];
    CGSize imageSize;
    if (image.size.width > screenWidth -20) {
        imageSize.height = (CGFloat)(image.size.height /  image.size.width) * (screenWidth - 20);
        imageSize.width = screenWidth -20;
    }else{
        imageSize.height = image.size.height;
        imageSize.width = image.size.width;
    }
    return imageSize;
}

#pragma mark - gesture - 
- (void)tapIconView:(UITapGestureRecognizer *)tap{
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.sourceImagesContainerView = self;
    browser.imageCount = 1;
    browser.currentImageIndex = 0;
    browser.delegate = self;
    [browser show];
}

#pragma mark - delegate -
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index{
    return [NSURL URLWithString:self.model.dataModel.image.url];
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index{
    return self.iconView.image;
}

#pragma mark - lazy -
- (UITextView *)contenLabel{
    if (_contenLabel == nil) {
        _contenLabel = [[UITextView alloc] init];
        _contenLabel.textColor = [UIColor blackColor];
        _contenLabel.font = [UIFont systemFontOfSize:15];
        _contenLabel.editable = NO;
        _contenLabel.scrollEnabled = NO;
    }
    return _contenLabel;
}

- (XSYCopyingLabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [[XSYCopyingLabel alloc] init];
        _timeLabel.textColor = [UIColor lightGrayColor];
        _timeLabel.font = [UIFont systemFontOfSize:13];
    }
    return _timeLabel;
}

- (UIImageView *)iconView{
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] init];
        _iconView.contentMode = UIViewContentModeScaleAspectFill;
        _iconView.layer.masksToBounds = YES;
        // shoushi
        _iconView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapIconView:)];
        [_iconView addGestureRecognizer:tap];
    }
    return _iconView;
}

- (UIImageView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fenjiexian1"]];
        _lineView.layer.masksToBounds = YES;
    }
    return _lineView;
}

- (UIView *)shadowView{
    if (_shadowView == nil) {
        _shadowView = [[UIView alloc] init];
        _shadowView.backgroundColor = [UIColor blackColor];
    }
    return _shadowView;
}
@end

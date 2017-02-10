//
//  XSYListeningContentCell.m
//  Voa
//
//  Created by xin on 2017/2/9.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "XSYListeningContentCell.h"
#import "UILabel+Helper.h"
#import <Masonry.h>
#import "XSYListeningContentModel.h"

@interface XSYListeningContentCell ()

@property (nonatomic, strong) UILabel *SentenceLbl;
@property (nonatomic, strong) UILabel *sentence_cnLbl;

@end

@implementation XSYListeningContentCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.SentenceLbl];
        [self.contentView addSubview:self.sentence_cnLbl];
        [self addConstraints];
    }
    return self;
}

- (void)addConstraints{
    [self.SentenceLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(screenWidth * 0.05);
        make.trailing.equalTo(self.contentView).offset(-screenWidth * 0.05);
        make.top.equalTo(self.contentView).offset(5);
    }];
    
    [self.sentence_cnLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.SentenceLbl);
        make.top.equalTo(self.SentenceLbl.mas_bottom).offset(5);
        make.bottom.equalTo(self.contentView).offset(-5);
    }];
}

- (UILabel *)SentenceLbl{
    if (_SentenceLbl == nil) {
        _SentenceLbl = [UILabel labelWithtextColor:playViewGray font:[UIFont systemFontOfSize:15]];
        _SentenceLbl.numberOfLines = 0;
        _SentenceLbl.preferredMaxLayoutWidth = screenWidth * 0.9;
    }
    return _SentenceLbl;
}

- (UILabel *)sentence_cnLbl{
    if (_sentence_cnLbl == nil) {
        _sentence_cnLbl = [UILabel labelWithtextColor:playViewGray font:[UIFont systemFontOfSize:15]];
        _sentence_cnLbl.numberOfLines = 0;
        _sentence_cnLbl.preferredMaxLayoutWidth = screenWidth * 0.9;
    }
    return _sentence_cnLbl;
}

- (void)setModel:(XSYListeningContentModel *)model{
    _model = model;
    self.SentenceLbl.text = model.Sentence;
    self.sentence_cnLbl.text = model.sentence_cn;
}

- (void)setIsEnglishOnly:(BOOL)isEnglishOnly{
    _isEnglishOnly = isEnglishOnly;
    if (_isEnglishOnly) {
        self.sentence_cnLbl.hidden = YES;
    }else{
        self.sentence_cnLbl.hidden = NO;
    }
}

@end

//
//  XSYMineCollectionCell.m
//  Voa
//
//  Created by xin on 2017/2/13.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "XSYMineCollectionCell.h"
#import "XSYMineButton.h"
#import "UIButton+Helper.h"
#import "UILabel+Helper.h"

@interface XSYMineCollectionCell ()
@property (nonatomic, strong) XSYMineButton *btn;
@property (nonatomic, strong) UIView *shadowView;
@property (nonatomic, strong) UILabel *textLbl;
@end

@implementation XSYMineCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.btn];
    }
    return self;
}

#pragma mark - button event  and gesture -

- (void)buttonTouchDown:(UIButton *)btn{
        [btn addSubview:self.shadowView];
        [UIView animateWithDuration:0.1 animations:^{
            self.shadowView.frame = self.contentView.bounds;
        } completion:^(BOOL finished) {
            self.textLbl.center = self.shadowView.center;
        }];
}

- (void)tapShadowView:(UITapGestureRecognizer *)tap{
    
    CGFloat WH = self.contentView.bounds.size.width;
    [UIView animateWithDuration:0.1 animations:^{
        CGRect newFrame = CGRectMake(0, WH, WH, WH);
        self.shadowView.frame = newFrame;
    } completion:^(BOOL finished) {
        self.textLbl.center = self.shadowView.center;
        [self.shadowView removeFromSuperview];
    }];
}

- (void)setTitle:(NSString *)title{
    _title = title;
    [self.btn setTitle:title forState:UIControlStateNormal];
}

- (void)setImageStr:(NSString *)imageStr{
    _imageStr = imageStr;
    [self.btn setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
}

#pragma mark - lazy -
- (XSYMineButton *)btn{
    if (_btn == nil) {
        _btn = [[XSYMineButton alloc] initWithFrame:self.contentView.bounds];
        _btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _btn.titleLabel.text = self.title;
        [_btn setTitleColor:mainColor forState:UIControlStateNormal];
        _btn.imageView.image = [UIImage imageNamed:self.imageStr];
        [_btn addTarget:self action:@selector(buttonTouchDown:) forControlEvents:UIControlEventTouchDown];
    }
    return _btn;
}

- (UIView *)shadowView{
    if (_shadowView == nil) {
        CGFloat WH = self.contentView.bounds.size.width;
        _shadowView = [[UIView alloc] initWithFrame:CGRectMake( 0, WH, WH, WH)];
        _shadowView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        _shadowView.layer.cornerRadius = 10;
        _shadowView.clipsToBounds = YES;
        // 添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapShadowView:)];
        [_shadowView addGestureRecognizer:tap];
        _textLbl = [UILabel labelWithtextColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:13] text:@"敬请期待"];
        _textLbl.center = _shadowView.center;
        _textLbl.bounds = CGRectMake(0, 0, WH, WH * 0.2);
        _textLbl.textAlignment = NSTextAlignmentCenter;
        [_shadowView addSubview:_textLbl];
    }
    return _shadowView;
}
@end

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
#import "XSYMineModel.h"

@interface XSYMineCollectionCell ()
@property (nonatomic, strong) XSYMineButton *btn;
@property (nonatomic, strong) UIView *shadowView;
@property (nonatomic, strong) UILabel *textLbl;
@property (nonatomic, assign) BOOL isShadow;

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

- (void)buttonTouchDown:(XSYMineButton *)btn{
    [btn addSubview:self.shadowView];
    [UIView animateWithDuration:0.1 animations:^{
        self.shadowView.frame = self.contentView.bounds;
    } completion:^(BOOL finished) {
        self.textLbl.center = self.shadowView.center;
        self.isShadow = YES;
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 2秒后异步执行这里的代码...
        [self dispearShadowView];
    });
}

- (void)tapShadowView:(UITapGestureRecognizer *)tap{
    [self dispearShadowView];
}
- (void)dispearShadowView{
    CGFloat WH = self.contentView.bounds.size.width;
    [UIView animateWithDuration:0.1 animations:^{
        CGRect newFrame = CGRectMake(0, WH, WH, WH);
        self.shadowView.frame = newFrame;
    } completion:^(BOOL finished) {
        self.textLbl.center = self.shadowView.center;
        [self.shadowView removeFromSuperview];
        self.isShadow = NO;
    }];
}
#pragma mark - set method -
- (void)setModel:(XSYMineModel *)model{
    _model = model;
    [self.btn setImage:[UIImage imageNamed:model.image] forState:UIControlStateNormal];
    [self.btn setTitle:model.title forState:UIControlStateNormal];
    self.isShadow = YES;
}

#pragma mark - lazy -
- (XSYMineButton *)btn{
    if (_btn == nil) {
        _btn = [[XSYMineButton alloc] initWithFrame:self.contentView.bounds];
        _btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
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

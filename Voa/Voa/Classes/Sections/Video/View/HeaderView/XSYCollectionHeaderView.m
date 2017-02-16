//
//  XSYCollectionHeaderView.m
//  Voa
//
//  Created by xin on 2017/2/15.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "XSYCollectionHeaderView.h"
#import "UILabel+Helper.h"
#import <Masonry.h>

@interface XSYCollectionHeaderView ()
@property (nonatomic, strong) UILabel *titleView;
@end

@implementation XSYCollectionHeaderView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _titleView = [UILabel labelWithtextColor:mainColor font:[UIFont boldSystemFontOfSize:16]];
        _titleView.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleView];
        [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.trailing.bottom.equalTo(self);
        }];
    }
    return self;
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleView.text = title;
}
@end

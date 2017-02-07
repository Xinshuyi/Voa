//
//  XSYListeningCell.m
//  Voa
//
//  Created by xin on 2017/2/7.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "XSYListeningCell.h"
#import "CZAdditions.h"
#import "DetailTableViewController.h"

@implementation XSYListeningCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor cz_randomColor];
        [self.contentView addSubview:self.vc.view];
    }
    return self;
}

- (void)layoutSubviews{
    self.vc.view.frame = self.contentView.frame;
}

- (DetailTableViewController *)vc{
    if (_vc == nil) {
        _vc = [[DetailTableViewController alloc] init];
    }
    return _vc;
}

- (void)setModel:(XSYParentModel *)model{
    _model = model;
    self.vc.model = model;
    [self.vc refreshUI];
}

@end

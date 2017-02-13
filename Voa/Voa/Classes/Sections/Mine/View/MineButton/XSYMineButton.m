//
//  XSYMineButton.m
//  Voa
//
//  Created by xin on 2017/2/13.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "XSYMineButton.h"

@implementation XSYMineButton

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat imageX = self.bounds.size.width * 0.25;
    CGFloat imageY = self.bounds.size.width * 0.15;
    CGFloat imageWH = self.bounds.size.width * 0.5;
    self.imageView.frame =  CGRectMake(imageX, imageY, imageWH, imageWH);
    CGFloat titleX = self.bounds.size.width * 0.25;
    CGFloat titleY = self.bounds.size.width * 0.75;
    CGFloat titleW = self.bounds.size.width * 0.5;
    CGFloat titltH = self.bounds.size.width * 0.15;
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titltH);
}

@end

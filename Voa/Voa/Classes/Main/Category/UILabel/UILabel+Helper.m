//
//  UILabel+Extension.m
//  
//
//  Created by zhq on 15/11/2.
//  Copyright © 2015年 . All rights reserved.
//

#import "UILabel+Helper.h"

@implementation UILabel (Helper)
+ (UILabel *)labelWithtextColor:(UIColor *)color font:(UIFont *)font
{
    UILabel *label = [self labelWithtextColor:color font:font text:nil];
    return label;
}

+ (UILabel *)labelWithtextColor:(UIColor *)color font:(UIFont *)font text:(NSString *)text
{
    UILabel *label = [[UILabel alloc] init];
    label.textColor = color;
    label.font = font;
    label.text = text;
    return label;
}
@end

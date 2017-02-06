//
//  UIButton+Extension.m
//  
//
//  Created by zhq on 15/11/2.
//  Copyright © 2015年 . All rights reserved.
//

#import "UIButton+Helper.h"

@implementation UIButton (Extension)
+ (UIButton *)buttonWithTarget:(id)target action:(SEL)action image:(NSString *)image title:(NSString *)title titleFont:(UIFont *)font titleColor:(UIColor *)color 
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (action) {
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    
    // 设置图片
    if (image) {
        [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    }

    if (title) {
        [btn setTitle:title forState:UIControlStateNormal];

    }
    
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    return btn;
}

+ (UIButton *)buttonWithTarget:(id)target action:(SEL)action image:(NSString *)image title:(NSString *)title titleFont:(UIFont *)font titleColor:(UIColor *)color borderColor:(UIColor *)bordercolor borderWidth:(int)borderWidth
{
    UIButton *btn = [self buttonWithTarget:target action:action image:image title:title titleFont:font titleColor:color];
    btn.layer.borderWidth = borderWidth;
    btn.layer.borderColor = bordercolor.CGColor;
    return btn;
}

+ (UIButton *)buttonWithTarget:(id)target action:(SEL)action image:(NSString *)image
{
    UIButton *btn = [self buttonWithTarget:target action:action image:image title:nil titleFont:nil titleColor:nil];

    return btn;

}

+ (UIButton *)buttonWithTarget:(id)target action:(SEL)action image:(NSString *)image borderColor:(UIColor *)bordercolor
{
    UIButton *btn = [self buttonWithTarget:target action:action image:image title:nil titleFont:nil titleColor:nil borderColor:bordercolor borderWidth:1];
    return btn;

}
+ (UIButton *)buttonWithTarget:(id)target action:(SEL)action image:(NSString *)image title:(NSString *)title titleFont:(UIFont *)font titleColor:(UIColor *)color backgroundColor:(UIColor *)backgroundColor
{
    UIButton *btn = [self buttonWithTarget:target action:action image:image title:title titleFont:font titleColor:color];
    [btn setBackgroundColor:backgroundColor];
    return btn;

}

@end

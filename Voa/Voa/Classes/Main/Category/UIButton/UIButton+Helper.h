//
//  UIButton+Extension.h
//  快速创建UIButton
//
//  Created by zhq on 15/11/2.
//  Copyright © 2016年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Helper)

+ (UIButton *)buttonWithTarget:(id)target action:(SEL)action image:(NSString *)image title:(NSString *)title titleFont:(UIFont *)font titleColor:(UIColor *)color;

+ (UIButton *)buttonWithTarget:(id)target action:(SEL)action image:(NSString *)image title:(NSString *)title titleFont:(UIFont *)font titleColor:(UIColor *)color borderColor:(UIColor *)bordercolor borderWidth:(int)borderWidth;

+ (UIButton *)buttonWithTarget:(id)target action:(SEL)action image:(NSString *)image borderColor:(UIColor *)bordercolor;

+ (UIButton *)buttonWithTarget:(id)target action:(SEL)action image:(NSString *)image;

+ (UIButton *)buttonWithTarget:(id)target action:(SEL)action image:(NSString *)image title:(NSString *)title titleFont:(UIFont *)font titleColor:(UIColor *)color backgroundColor:(UIColor *)backgroundColor;

+ (UIButton *)buttonWithTarget:(id)target action:(SEL)action image:(NSString *)backgroundImage selectBackgroundImage:(NSString *)selectBackgroundImage;

@end

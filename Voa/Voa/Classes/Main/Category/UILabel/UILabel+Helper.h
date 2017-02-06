//
//  UILabel+Extension.h
//  快速创建UILabel
//
//  Created by zhq on 15/11/2.
//  Copyright © 2015年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Helper)

+ (UILabel *)labelWithtextColor:(UIColor *)color font:(UIFont *)font;
+ (UILabel *)labelWithtextColor:(UIColor *)color font:(UIFont *)font text:(NSString *)text;

@end

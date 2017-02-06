//
//  UIBarButtonItem+Extension.m
//  listen to this
//
//  Created by apple on 15-9-19.
//  Copyright (c) 2015年 zhq. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "UIView+Extension.h"

@implementation UIBarButtonItem (Extension)
/**
 *  创建一个item
 *
 *  @param target    点击item后调用哪个对象的方法
 *  @param action    点击item后调用target的哪个方法
 *  @param image     图片
 *  @param highImage 高亮的图片
 *
 *  @return 创建完的item
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image isLeft:(BOOL)isLeft
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    // 设置图片
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    btn.adjustsImageWhenHighlighted = NO;
    if (isLeft) {
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }else{
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    
    // 设置尺寸
    btn.size = CGSizeMake(btn.currentImage.size.width + 20, btn.currentImage.size.height + 10);
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end

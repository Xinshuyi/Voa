//
//  UIBarButtonItem+Extension.h
//  listen to this
//
//  Created by apple on 15-9-19.
//  Copyright (c) 2015年 zhq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image isLeft:(BOOL)isLeft;
@end

//
//  XSYVideoSecondPageMainModel.m
//  Voa
//
//  Created by xin on 2017/2/16.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "XSYVideoSecondPageMainModel.h"

@implementation XSYVideoSecondPageMainModel
// 替换系统关键字 新的 -》 系统关键字
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"desc" : @"description"};
}

// 模型中有一个数组属性 数组包含其他模型
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"videoList" : @"XSYVideoSecondPageListsModel"};
}
@end

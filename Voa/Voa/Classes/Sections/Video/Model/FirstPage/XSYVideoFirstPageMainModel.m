//
//  XSYVideoFirstPageMainModel.m
//  Voa
//
//  Created by xin on 2017/2/15.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "XSYVideoFirstPageMainModel.h"

@implementation XSYVideoFirstPageMainModel
// 模型中有一个数组属性 数组包含其他模型
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"vos" : @"XSYVideoFirstPageTopicModel"};
}
@end

//
//  XSYVideoFirstPageTopicModel.m
//  Voa
//
//  Created by xin on 2017/2/15.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "XSYVideoFirstPageTopicModel.h"

@implementation XSYVideoFirstPageTopicModel
// 替换系统关键字 新的 -》 系统关键字
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"desc" : @"description"};
}
@end

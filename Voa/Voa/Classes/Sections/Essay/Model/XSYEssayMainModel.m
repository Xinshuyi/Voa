//
//  XSYEssayMainModel.m
//  Voa
//
//  Created by xin on 2017/2/11.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "XSYEssayMainModel.h"
#import <MJExtension.h>

@implementation XSYEssayMainModel
// 模型里面有模型
//+ (NSDictionary *)mj_objectClassInArray
//{
//    return @{@"dataModel" : @"XSYEssayDataModel"};
//}

// 替换系统关键字 新的 -》 系统关键字
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"dataModel" : @"data"};
}
@end

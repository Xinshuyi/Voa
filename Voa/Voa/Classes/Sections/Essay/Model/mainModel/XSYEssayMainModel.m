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
//    return @{@"dataModel" : @"data"};
//}

// 替换系统关键字 新的 -》 系统关键字
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"dataModel" : @"data"};
}

- (instancetype)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        _createdAt = [decoder decodeObjectForKey:@"createdAt"];
        _messageId = [decoder decodeObjectForKey:@"messageId"];
        _dataModel = [decoder decodeObjectForKey:@"dataModel"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_createdAt forKey:@"createdAt"];
    [aCoder encodeObject:_messageId forKey:@"messageId"];
    [aCoder encodeObject:_dataModel forKey:@"dataModel"];
}

@end

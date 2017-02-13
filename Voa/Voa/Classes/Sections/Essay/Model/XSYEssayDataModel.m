//
//  XSYEssayPicModel.m
//  Voa
//
//  Created by xin on 2017/2/11.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "XSYEssayDataModel.h"
#import <MJExtension.h>
@implementation XSYEssayDataModel

// 模型里面有模型
//+ (NSDictionary *)mj_objectClassInArray
//{
//    return @{@"XSYEssayImageModel" : @"image"};
//}
- (instancetype)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        _text = [decoder decodeObjectForKey:@"text"];
        _image = [decoder decodeObjectForKey:@"image"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_text forKey:@"text"];
    [aCoder encodeObject:_image forKey:@"image"];
}

@end

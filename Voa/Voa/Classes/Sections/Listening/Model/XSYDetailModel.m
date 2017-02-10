//
//  XSYDetailModel.m
//  Voa
//
//  Created by xin on 2017/2/6.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "XSYDetailModel.h"

@implementation XSYDetailModel

- (instancetype)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        _Title = [decoder decodeObjectForKey:@"Title"];
        _Title_cn = [decoder decodeObjectForKey:@"Title_cn"];
        _Pic = [decoder decodeObjectForKey:@"Pic"];
        _ReadCount = [decoder decodeObjectForKey:@"ReadCount"];
        _CreatTime = [decoder decodeObjectForKey:@"CreatTime"];
        _VoaId = [decoder decodeObjectForKey:@"VoaId"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_Title forKey:@"Title"];
    [aCoder encodeObject:_Title_cn forKey:@"Title_cn"];
    [aCoder encodeObject:_Pic forKey:@"Pic"];
    [aCoder encodeObject:_ReadCount forKey:@"ReadCount"];
    [aCoder encodeObject:_CreatTime forKey:@"CreatTime"];
    [aCoder encodeObject:_VoaId forKey:@"VoaId"];
}



@end

//
//  XSYVoaCacheTool.h
//  Voa
//  听力缓存工具
//  Created by xin on 2017/2/10.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XSYVoaCacheTool : NSObject

+ (NSArray *)getVoaModelArray;

+ (void)saveVoaModelArray:(NSArray *)voaModelArray;

@end

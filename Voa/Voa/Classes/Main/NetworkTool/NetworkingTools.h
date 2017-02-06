//
//  NetworkingTools.h
//  OC中网络访问框架的封装
//
//  Created by xin on 2017/1/5.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

// 枚举 区分get还是post
typedef NS_ENUM(NSUInteger, HTTPMethod) {
    GET,
    POST,
};
typedef void(^CompleteBlock)(id response, NSError *error);

@interface NetworkingTools : AFHTTPSessionManager

+ (instancetype)shared;

// 封装网络请求的方法
                 // get还是post
- (void) request:(HTTPMethod)method urlString:(NSString *)urlString parameters:(id)parameters completeBlock:(CompleteBlock)completeBlock;

// 具体的url还可以继续封装方法 
@end

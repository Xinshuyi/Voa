//
//  NetworkingTools.m
//  OC中网络访问框架的封装
//
//  Created by xin on 2017/1/5.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "NetworkingTools.h"

@implementation NetworkingTools
+ (instancetype)shared{
    static NetworkingTools *tools = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tools = [[self alloc] init];
        // 响应序列化器 接收格式
        // 默认只支持 application/json", @"text/json", @"text/javascript三种格式
        // 增加@"text/html"格式
        tools.responseSerializer.acceptableContentTypes = [tools.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        tools.responseSerializer.acceptableContentTypes = [tools.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
    });
    return tools;
}

- (void)request:(HTTPMethod)method urlString:(NSString *)urlString parameters:(id)parameters completeBlock:(CompleteBlock)completeBlock{
    
    void(^successCallback)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //成功的回调
        completeBlock(responseObject,nil);
    };
    
    void(^failureCallBack)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completeBlock(nil,error);
        //错误的统一输出
        NSLog(@"%@",error);
    };
    
    
    if (method == GET ) {
        [self GET:urlString parameters:parameters progress:nil success:successCallback failure:failureCallBack];
    }else{
        [self POST:urlString parameters:parameters progress:nil success:successCallback
           failure:failureCallBack];
    }
}

@end

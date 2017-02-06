//
//  XSYNetworking.m
//  Voa
//
//  Created by xin on 2017/2/6.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "XSYNetworking.h"
#import <MJExtension.h>
#import "NetworkingTools.h"
#import "XSYDetailModel.h"

@implementation XSYNetworking
+ (void)getVoaNormalSpeedWithPage:(NSInteger)page parentID:(NSString *)parentID maxID:(NSString *)maxID successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    NSString *urlStr = @"http://apps.iyuba.com/iyuba/titleChangSuApi2.jsp";
    NSDictionary *para = @{@"maxid":maxID, @"type":@"iOS",@"format":@"json",@"pages":[NSString stringWithFormat:@"%zd",page],@"pageNum":@"20",@"parentID":parentID};
    [[NetworkingTools shared] request:GET urlString:urlStr parameters:para completeBlock:^(id response, NSError *error) {
        if (error == nil) {
            NSArray *array = response[@"data"];
            NSArray *modelArr = [XSYDetailModel mj_objectArrayWithKeyValuesArray:array];
            if (successBlock) {
                successBlock(modelArr);
            }
        }else{
            if (failureBlock) {
                failureBlock(error);
            }
        }
    }];
}
@end

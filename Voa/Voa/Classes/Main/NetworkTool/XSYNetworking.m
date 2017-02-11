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
#import "XSYListeningContentModel.h"
#import "XSYVoaCacheTool.h"
#import <RealReachability.h>

@implementation XSYNetworking

+ (void)getVoaNormalSpeedWithPage:(NSInteger)page parentID:(NSString *)parentID maxID:(NSString *)maxID successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    NSString *urlStr = @"http://apps.iyuba.com/iyuba/titleChangSuApi2.jsp";
    NSDictionary *para = @{@"maxid":maxID, @"type":@"iOS",@"format":@"json",@"pages":[NSString stringWithFormat:@"%zd",page],@"pageNum":@"10",@"parentID":parentID};
    ReachabilityStatus status = [GLobalRealReachability
                                 currentReachabilityStatus];
    if (status == RealStatusNotReachable) {
    
        // 从数据库获取

        if ([parentID isEqualToString:@"0"]) {
            parentID = @"100";
        }

        NSArray *dataArray = [XSYVoaCacheTool getVoaModelArrayWithParentID:parentID];
        if (successBlock) {
            successBlock(dataArray);
        }
        return;
    }

    [[NetworkingTools shared] request:GET urlString:urlStr parameters:para completeBlock:^(id response, NSError *error) {
        if (error == nil) {
            NSArray *array = response[@"data"];
            NSArray *modelArr = [XSYDetailModel mj_objectArrayWithKeyValuesArray:array];
            for (XSYDetailModel *model in modelArr) {
                model.parentID = [parentID  isEqualToString: @"0"] ? @"100" : parentID;
            }
            // 存储到数据库
            if (page == 1) {
                [XSYVoaCacheTool saveVoaModelArrayWithArray:modelArr WithParentID:parentID];
            }
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

+ (void)getVoaLowSpeedWithPage:(NSInteger)page parentID:(NSString *)parentID maxID:(NSString *)maxID successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    NSString *urlStr = @"http://apps.iyuba.com/iyuba/titleApi2.jsp";
    NSDictionary *para = @{@"type":@"iOS",@"format":@"json",@"maxid":maxID,@"pages":[NSString stringWithFormat:@"%zd",page],@"pageNum":@"10",@"parentID":parentID};
    ReachabilityStatus status = [GLobalRealReachability
                                 currentReachabilityStatus];
    if (status == RealStatusNotReachable) {
        // 从数据库获取
        NSArray *dataArray = [XSYVoaCacheTool getVoaModelArrayWithParentID:parentID];
        if (successBlock) {
            successBlock(dataArray);
        }
        return;
    }

    [[NetworkingTools shared] request:GET urlString:urlStr parameters:para completeBlock:^(id response, NSError *error) {
        if (error == nil) {
            NSArray *array = response[@"data"];
            NSArray *modelArr = [XSYDetailModel mj_objectArrayWithKeyValuesArray:array];
            
            // 存储到数据库
            if (page == 1) {
                [XSYVoaCacheTool saveVoaModelArrayWithArray:modelArr WithParentID:parentID];
            }
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

+ (void)getVoaListeningWithSpeedValue:(SpeedValue)speedValue Page:(NSInteger)page parentID:(NSString *)parentID maxID:(NSString *)maxID successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    if (speedValue == NormalSpeed) {
        [self getVoaNormalSpeedWithPage:page parentID:parentID maxID:maxID successBlock:^(id response) {
            if (successBlock) {
                successBlock(response);
            }
        } failureBlock:^(NSError *error) {
            if (failureBlock) {
                failureBlock(error);
            }
        }];
    }else{
        [self getVoaLowSpeedWithPage:page parentID:parentID maxID:maxID successBlock:^(id response) {
            if (successBlock) {
                successBlock(response);
            }
        } failureBlock:^(NSError *error) {
            if (failureBlock) {
                failureBlock(error);
            }
        }];
    }
}

+ (void)getVoaListeningContentWithVoaid:(NSString *)voaid successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    NSString *urlString = @"http://apps.iyuba.com/iyuba/textNewApi.jsp";
    NSDictionary *para = @{@"voaid":voaid,@"format":@"json"};
    [[NetworkingTools shared] request:GET urlString:urlString parameters:para completeBlock:^(id response, NSError *error) {
        if (error == nil) {
            NSArray *array = response[@"data"];
            NSArray *modelArr = [XSYListeningContentModel mj_objectArrayWithKeyValuesArray:array];
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

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
#import "XSYEssayMainModel.h"
#import "XSYEssayDataModel.h"
#import "XSYEssayImageModel.h"
#import <SDWebImageManager.h>
#import "XSYEssayDataTool.h"
#import "XSYVideoFirstPageMainModel.h"
#import "XSYVideoSecondPageMainModel.h"

typedef void (^DownLoadIMAGEBlock) (BOOL isDownload);
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
    ReachabilityStatus status = [GLobalRealReachability currentReachabilityStatus];
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

// 文章模块
+ (void)getVoaEssayWithLimit:(NSUInteger)limit successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    NSString *urlStr = @"http://english.avosapps.com/feed";
    NSDictionary *para = @{@"limit":[NSString stringWithFormat:@"%ld",limit],@"s":@"englishnewss"};
    ReachabilityStatus status = [GLobalRealReachability currentReachabilityStatus];
    if (status == RealStatusNotReachable) {
        
        // 从数据库获取
        NSArray *dataArray = [XSYEssayDataTool getEssayModelArray];
        if (successBlock) {
            successBlock(dataArray);
        }
        return;
    }

    [[NetworkingTools shared] request:GET urlString:urlStr parameters:para completeBlock:^(id response, NSError *error) {
        if (error == nil) {
            NSArray<XSYEssayMainModel *> *modelArr = [XSYEssayMainModel mj_objectArrayWithKeyValuesArray:response];
            // 存储到数据库
            if (limit == 5) {
                [XSYEssayDataTool saveEssayModelArrayWithArray:modelArr];
            }

            if (successBlock) {
                successBlock(modelArr);
            }
            // 下载图片
//            [self downloadIMAGE:modelArr downBlock:^(BOOL isDownload) {
//                if (isDownload == YES) {
//                    if (successBlock) {
//                        successBlock(modelArr);
//                    }
//                }else{
//                    if (failureBlock) {
//                        failureBlock(error);
//                    }
//                }
//            }];
        }else{
            if (failureBlock) {
                failureBlock(error);
            }
        }
    }];
}

// 下载图片
+ (void)downloadIMAGE:(NSArray<XSYEssayMainModel *> *)array downBlock:(DownLoadIMAGEBlock)downBlock{
    // 使用调度组
    dispatch_group_t group = dispatch_group_create();

    for (int i = 0; i < array.count; i ++) {
        NSString *imageURLStr = array[i].dataModel.image.url;
        NSURL *imageURL = [NSURL URLWithString:imageURLStr];
        // 入组
        dispatch_group_enter(group);
        // 下载图片
        [[SDWebImageManager sharedManager] downloadImageWithURL:imageURL options:SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            // 下载成功后出组
            dispatch_group_leave(group);
        }];
        // 群组结束
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            // 代表图片全数下载成功
            if(downBlock){
                downBlock(YES);
            }
        });
    }
}

+ (void)getVideoDataWithSuccessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    
    NSArray *dictArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"homePage" ofType:@"plist"]];
    NSArray *modelArr = [XSYVideoFirstPageMainModel mj_objectArrayWithKeyValuesArray:dictArr];
    NSLog(@"%@",modelArr);
    if (successBlock) {
        successBlock(modelArr);
    }
    
//    NSString *urlStr = @"http://c.open.163.com/mobile/recommend/v1.do?mt=iphone";
//
//    NSURL *url = [NSURL URLWithString:urlStr];
//    
//    NSURLSession *session = [NSURLSession sharedSession];
//    
//    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        
//        NSStringEncoding enc = kCFStringEncodingUTF8;
//        
//        NSString* strdata = [[NSString alloc]initWithData:data encoding:enc];//在将NSString类型转为NSData
//        
//        NSData * newData = [strdata dataUsingEncoding:NSUTF8StringEncoding];//这样解决的乱码问题。
//        
//        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:newData options:kNilOptions error:&error ];
//            NSLog(@"%@",json);
//    }];
//    [dataTask resume];

//    [[NetworkingTools shared] request:GET urlString:urlStr parameters:nil completeBlock:^(id response, NSError *error) {
//        if (error == nil) {
//            NSArray *modelArr = [XSYVideoFirstPageMainModel mj_objectArrayWithKeyValuesArray:response];
//            if (successBlock) {
//                successBlock(modelArr);
//            }
//        }else{
//            if (failureBlock) {
//                failureBlock(error);
//            }
//        }
//
//    }];
}

+ (void)getVideoSecondPageWithContentID:(NSString *)contentID SuccessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    if ([contentID containsString:@"_"]) {
        // 截取字符串
        NSRange range = [contentID rangeOfString:@"_"];
        contentID = [contentID substringToIndex:range.location];
        NSLog(@"%@",contentID);
    }
    NSString *urlStr = [NSString stringWithFormat:@"http://so.open.163.com/movie/%@/getMovies4Ipad.htm",contentID];
    [[NetworkingTools shared] request:GET urlString:urlStr parameters:nil completeBlock:^(id response, NSError *error) {

        if (error == nil) {
            XSYVideoSecondPageMainModel *model = [XSYVideoSecondPageMainModel mj_objectWithKeyValues:response];
            if (successBlock) {
                successBlock(model);
            }
        }else{
            if (failureBlock) {
                failureBlock(error);
            }
        }
    }];
}
@end

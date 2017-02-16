//
//  XSYNetworking.h
//  Voa
//
//  Created by xin on 2017/2/6.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SuccessBlock)(id response);
typedef void(^FailureBlock)(NSError *error);
@interface XSYNetworking : NSObject

/**
 常速
 */
+ (void)getVoaNormalSpeedWithPage:(NSInteger)page
                         parentID:(NSString *)parentID
                            maxID:(NSString *)maxID
                     successBlock:(SuccessBlock)successBlock
                     failureBlock:(FailureBlock)failureBlock;
/**
 慢速
 */
+ (void)getVoaLowSpeedWithPage:(NSInteger)page
                      parentID:(NSString *)parentID
                         maxID:(NSString *)maxID
                  successBlock:(SuccessBlock)successBlock
                  failureBlock:(FailureBlock)failureBlock;


/**
 整合常速和慢速
 */
+ (void)getVoaListeningWithSpeedValue:(SpeedValue)speedValue
                                 Page:(NSInteger)page
                             parentID:(NSString *)parentID
                                maxID:(NSString *)maxID
                         successBlock:(SuccessBlock)successBlock
                         failureBlock:(FailureBlock)failureBlock;



/**
 中文整合英文
 */
+ (void)getVoaListeningContentWithVoaid:(NSString *)voaid
                    successBlock:(SuccessBlock)successBlock
                    failureBlock:(FailureBlock)failureBlock;


/**
 文章
 */
+ (void)getVoaEssayWithLimit:(NSUInteger)limit
                successBlock:(SuccessBlock)successBlock
                failureBlock:(FailureBlock)failureBlock;


/**
视频首页
 */
+ (void)getVideoDataWithSuccessBlock:(SuccessBlock)successBlock        failureBlock:(FailureBlock)failureBlock;


/**
 视频第二页详情
 */
+ (void)getVideoSecondPageWithContentID:(NSString *)contentID
                           SuccessBlock:(SuccessBlock)successBlock
                           failureBlock:(FailureBlock)failureBlock;

@end

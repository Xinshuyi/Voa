//
//  XSYListenPlayerView.h
//  Voa
//
//  Created by xin on 2017/2/7.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XSYDetailModel;
@interface XSYListenPlayerView : UIView

@property (nonatomic, strong) XSYDetailModel *model;

/**
 关闭了再打开
 */
+ (instancetype)startPlayerView;

/**
 暂停了再打开
 */
- (void)morePlayerView;

/**
 退回播放器界面但是没有退出
 */
- (void)backPlayerView;


/**
 关闭
 */
- (void)closePlayerView;
@end

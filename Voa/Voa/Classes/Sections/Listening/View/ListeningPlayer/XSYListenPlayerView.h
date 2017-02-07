//
//  XSYListenPlayerView.h
//  Voa
//
//  Created by xin on 2017/2/7.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSYListenPlayerView : UIView

/**
 关闭了再打开
 */
+ (instancetype)restartPlayerView;

/**
 暂停了再打开
 */
- (void)startPlayerView;

/**
 暂停
 */
- (void)pausePlayerView;


/**
 关闭
 */
- (void)closePlayerView;
@end

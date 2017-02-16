//
//  XSYVideoSecondPageTableHeaderView.h
//  Voa
//
//  Created by xin on 2017/2/16.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XSYVideoSecondPageMainModel,XSYVideoSecondPageTableHeaderView;
@protocol XSYVideoSecondPageTableHeaderViewProtocol <NSObject>

- (void)secondPageTableHeaderView:(XSYVideoSecondPageTableHeaderView *)secondPageTableHeaderView disTapMoreShadowView:(UIView *)shadowView WithModel:(XSYVideoSecondPageMainModel *)model;

@end

@interface XSYVideoSecondPageTableHeaderView : UIView

@property (nonatomic, strong) XSYVideoSecondPageMainModel *model;

@property (nonatomic, assign) CGFloat contentOffsetY;

@property (nonatomic, weak) id<XSYVideoSecondPageTableHeaderViewProtocol> delegate;

@end

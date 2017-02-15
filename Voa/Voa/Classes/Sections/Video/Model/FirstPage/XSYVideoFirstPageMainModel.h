//
//  XSYVideoFirstPageMainModel.h
//  Voa
//
//  Created by xin on 2017/2/15.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XSYVideoFirstPageTopicModel;

@interface XSYVideoFirstPageMainModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSArray *vos;

@end

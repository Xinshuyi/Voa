//
//  XSYVideoSecondPageMainModel.h
//  Voa
//
//  Created by xin on 2017/2/16.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XSYVideoSecondPageListsModel;

@interface XSYVideoSecondPageMainModel : NSObject
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *imgpath;
@property (nonatomic, copy) NSString *largeimgurl;
@property (nonatomic, assign) NSInteger playcount;
@property (nonatomic, copy) NSString *tags;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) NSArray<XSYVideoSecondPageListsModel *> *videoList;
@end

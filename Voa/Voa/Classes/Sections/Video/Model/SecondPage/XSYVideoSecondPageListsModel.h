//
//  XSYVideoSecondPageListsModel.h
//  Voa
//
//  Created by xin on 2017/2/16.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XSYVideoSecondPageSubListModel;

@interface XSYVideoSecondPageListsModel : NSObject
@property (nonatomic, copy) NSString *imgpath;
@property (nonatomic, copy) NSString *repovideourlmp4;
@property (nonatomic, strong) NSArray<XSYVideoSecondPageSubListModel *> *subList;

@end

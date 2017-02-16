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
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *subtitle_language;
@property (nonatomic, strong) NSArray<XSYVideoSecondPageSubListModel *> *subList;

@end

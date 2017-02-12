//
//  XSYEssayMainModel.h
//  Voa
//
//  Created by xin on 2017/2/11.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class XSYEssayDataModel;
@interface XSYEssayMainModel : NSObject
@property (nonatomic, copy) NSString *createdAt;
@property (nonatomic, strong) XSYEssayDataModel *dataModel;
@property (nonatomic, copy) NSString *messageId;


@end

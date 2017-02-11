//
//  XSYEssayMainModel.h
//  Voa
//
//  Created by xin on 2017/2/11.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XSYEssayPicModel;
@interface XSYEssayMainModel : NSObject
@property (nonatomic, copy) NSString *createdAt;
@property (nonatomic, strong) XSYEssayPicModel *dataModel;

@end

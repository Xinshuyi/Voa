//
//  XSYDetailModel.h
//  Voa
//
//  Created by xin on 2017/2/6.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XSYDetailModel : NSObject<NSCoding>
@property (nonatomic, copy) NSString *Title;
@property (nonatomic, copy) NSString *Title_cn;
@property (nonatomic, copy) NSString *Pic;
@property (nonatomic, copy) NSString *DescCn;
@property (nonatomic, copy) NSString *ReadCount;
@property (nonatomic, copy) NSString *CreatTime;
@property (nonatomic, copy) NSString *Sound;
@property (nonatomic, copy) NSString *VoaId;

@end

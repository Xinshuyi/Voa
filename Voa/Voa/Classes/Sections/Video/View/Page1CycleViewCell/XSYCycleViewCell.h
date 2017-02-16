//
//  XSYCycleViewCell.h
//  Voa
//
//  Created by xin on 2017/2/15.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XSYVideoFirstPageTopicModel,XSYCycleViewCell;

@protocol XSYCycleViewCellProtocol <NSObject>

- (void)cycleViewCell:(XSYCycleViewCell *)cell didSelectTheItemWithModel:(XSYVideoFirstPageTopicModel *)model;

@end

@interface XSYCycleViewCell : UICollectionViewCell

@property (nonatomic, strong) NSArray<XSYVideoFirstPageTopicModel *> *vos;
@property (nonatomic, weak) id<XSYCycleViewCellProtocol> delegate;


@end

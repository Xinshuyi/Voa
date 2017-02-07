//
//  XSYListeningCell.h
//  Voa
//
//  Created by xin on 2017/2/7.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XSYParentModel;
@class DetailTableViewController;

@interface XSYListeningCell : UICollectionViewCell

@property (nonatomic, strong) XSYParentModel *model;
@property (nonatomic, strong) DetailTableViewController *vc;

@end

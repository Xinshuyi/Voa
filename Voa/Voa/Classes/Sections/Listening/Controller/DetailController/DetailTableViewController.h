//
//  DetailTableViewController.h
//  Voa
//
//  Created by xin on 2017/2/6.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XSYParentModel;

@interface DetailTableViewController : UITableViewController

/**
 具体板块名称和接口参数
 */
@property (nonatomic, strong) XSYParentModel *model;

- (void)refreshUI;

@end

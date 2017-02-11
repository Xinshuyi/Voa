//
//  EssayController.m
//  Voa
//
//  Created by xin on 2017/2/4.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "EssayController.h"

static NSString *const essayCellID = @"essayCellID";

@interface EssayController ()
@property(nonatomic, assign) NSUInteger limitScale;
@end

@implementation EssayController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 注册 http://english.avosapps.com/feed?&limit=100&s=englishnewss
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:essayCellID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

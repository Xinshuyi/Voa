//
//  XSYVideoSecondController.m
//  Voa
//
//  Created by xin on 2017/2/16.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "XSYVideoSecondController.h"
#import "XSYVideoFirstPageTopicModel.h"
#import "XSYNetworking.h"
#import <SVProgressHUD.h>

@interface XSYVideoSecondController ()

@end

@implementation XSYVideoSecondController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = mainColor;
    [self loadData];
}

- (void)loadData{
    [XSYNetworking getVideoSecondPageWithContentID:self.model.contentId SuccessBlock:^(id response) {
        NSLog(@"%@",response);
    } failureBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络不佳"];
    }];
}

- (void)setModel:(XSYVideoFirstPageTopicModel *)model{
    _model = model;
    self.title = model.title;
}
@end

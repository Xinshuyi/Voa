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
#import "XSYVideoSecondPageMainModel.h"
#import "XSYVideoSecondPageListsModel.h"
#import "XSYVideoSecondPageTableHeaderView.h"
#import "CZAdditions.h"

static NSString *secondPageVideoCellID = @"secondPageVideoCellID";

@interface XSYVideoSecondController ()<XSYVideoSecondPageTableHeaderViewProtocol>
@property (nonatomic, strong) XSYVideoSecondPageMainModel *selfModel;
@property (nonatomic, strong) XSYVideoSecondPageTableHeaderView *headerView;

@end

@implementation XSYVideoSecondController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = mainColor;
    [self loadData];
    // 注册
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:secondPageVideoCellID];
    // 头视图
    _headerView = [[XSYVideoSecondPageTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, 0, screenHeight *0.618)];
    _headerView.delegate = self;
    self.tableView.tableHeaderView = _headerView;
    
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)loadData{
    [XSYNetworking getVideoSecondPageWithContentID:self.model.contentId SuccessBlock:^(id response) {
        NSLog(@"%@",response);
        self.selfModel = response;
        _headerView.model = self.selfModel;
        [self.tableView reloadData];
    } failureBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络不佳"];
    }];
}

#pragma mark - delegate and datasource -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"----%f",scrollView.contentOffset.y);
    self.headerView.contentOffsetY = scrollView.contentOffset.y;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.selfModel.videoList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:secondPageVideoCellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor cz_randomColor];
    return cell;
}

- (void)secondPageTableHeaderView:(XSYVideoSecondPageTableHeaderView *)secondPageTableHeaderView disTapMoreShadowView:(UIView *)shadowView WithModel:(XSYVideoSecondPageMainModel *)model{
    NSLog(@"%@",model);
}

#pragma mark - set method -
- (void)setModel:(XSYVideoFirstPageTopicModel *)model{
    _model = model;
    self.title = model.title;
}
@end

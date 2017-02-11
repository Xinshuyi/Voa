//
//  DetailTableViewController.m
//  Voa
//
//  Created by xin on 2017/2/6.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "DetailTableViewController.h"
#import "CZAdditions.h"
#import <MJRefresh.h>
#import "XSYDetailModel.h"
#import "XSYDetailCell.h"
#import "XSYParentModel.h"
#import "XSYNetworking.h"
#import "XSYRefreshHeader.h"
#import <SVProgressHUD.h>
#import "XSYListenPlayerView.h"

static NSString *detailCellID = @"detailCellID";
@interface DetailTableViewController ()
@property (nonatomic, strong) NSMutableArray <XSYDetailModel *> *modelArr;
@property (nonatomic, assign) NSInteger page;
@end

@implementation DetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 注册
    [self.tableView registerClass:[XSYDetailCell class] forCellReuseIdentifier:detailCellID];
    self.tableView.rowHeight = screenWidth * 0.618;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    // Set header
    XSYRefreshHeader *header = [XSYRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
  
    self.tableView.mj_header = header;
    [self.tableView.mj_header beginRefreshing];
    
    // set footer
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.mj_footer = footer;
}

#pragma mark - refreshUI to keep data new -

- (void)refreshUI{
    [self.tableView.mj_header beginRefreshing];
    NSLog(@"!!!!%s",__func__);
}

#pragma mark - load data -

- (void)loadNewData{
    self.page = 1;
    [XSYNetworking getVoaListeningWithSpeedValue:self.model.speedValue Page:self.page parentID:self.model.parentID maxID:@"0" successBlock:^(NSMutableArray<XSYDetailModel *> *response) {
        self.modelArr = response;
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failureBlock:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"网络不佳"];
    }];
}

- (void)loadMoreData{
    self.page++;
    [XSYNetworking getVoaListeningWithSpeedValue:self.model.speedValue Page:self.page parentID:self.model.parentID maxID:@"0" successBlock:^(NSMutableArray<XSYDetailModel *> *response) {
        [self.modelArr addObjectsFromArray:response];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    } failureBlock:^(NSError *error) {
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"网络不佳"];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XSYDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:detailCellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor cz_randomColor];
    cell.model = self.modelArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    XSYDetailModel *model = self.modelArr[indexPath.row];
    if (model.Sound != nil) {
        XSYListenPlayerView *playerView = [XSYListenPlayerView startPlayerView];
        playerView.model = model;
    }else{
        [SVProgressHUD showErrorWithStatus:@"请检查网络"];
    }
}
@end

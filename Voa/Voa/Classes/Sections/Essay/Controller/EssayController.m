//
//  EssayController.m
//  Voa
//
//  Created by xin on 2017/2/4.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "EssayController.h"
#import <MJRefresh.h>
#import "XSYEssayMainModel.h"
#import "XSYEssayImageModel.h"
#import "XSYNetworking.h"
#import "XSYEssayDataModel.h"
#import <SVProgressHUD.h>

#define LimitNum 5

static NSString *const essayCellID = @"essayCellID";

@interface EssayController ()
@property(nonatomic, assign) NSUInteger limitScale;
@property (nonatomic, strong) NSMutableArray<XSYEssayMainModel*> *modelArr;

@end

@implementation EssayController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 注册
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:essayCellID];
    // refreshcontrol
    // Set header
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    self.tableView.mj_header = header;
    [self.tableView.mj_header beginRefreshing];
    
    // set footer
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.mj_footer = footer;

    
}

#pragma mark - loadData -
- (void)loadNewData{
    self.limitScale = 1;
    [XSYNetworking getVoaEssayWithLimit:self.limitScale * LimitNum successBlock:^(NSMutableArray<XSYEssayMainModel*> * response) {
        self.modelArr = response;
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    } failureBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络不佳"];
    }];
    
}

- (void)loadMoreData{
    self.limitScale ++ ;
    [XSYNetworking getVoaEssayWithLimit:self.limitScale * LimitNum successBlock:^(id response) {
        self.modelArr = response;
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    } failureBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络不佳"];
    }];
}

#pragma mark - datasource and delegate -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:essayCellID forIndexPath:indexPath];
    cell.textLabel.text = self.modelArr[indexPath.row].createdAt;
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

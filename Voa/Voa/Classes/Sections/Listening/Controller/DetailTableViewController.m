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
#import "XSYNetworking.h"
#import "XSYRefreshHeader.h"

static NSString *detailCellID = @"detailCellID";
@interface DetailTableViewController ()
@property (nonatomic, strong) NSMutableArray <XSYDetailModel *> *modelArr;
@end

@implementation DetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 注册
    [self.tableView registerClass:[XSYDetailCell class] forCellReuseIdentifier:detailCellID];
    self.tableView.rowHeight = 200;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    XSYRefreshHeader *header = [XSYRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
  
    // Set header
    self.tableView.mj_header = header;
    
}

- (void)loadNewData{
    [XSYNetworking getVoaNormalSpeedWithPage:1 parentID:@"0" maxID:@"0" successBlock:^(NSArray <XSYDetailModel *> *response) {
        self.modelArr = [NSMutableArray arrayWithArray:response];
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    } failureBlock:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 12;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XSYDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:detailCellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor cz_randomColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end

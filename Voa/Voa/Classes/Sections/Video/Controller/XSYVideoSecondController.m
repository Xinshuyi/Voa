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
#import "XSYVideoDetailController.h"
#import "XSYVideoSecondPageCell.h"
#import "XSYVideoMovieController.h"

static NSString *secondPageVideoCellID = @"secondPageVideoCellID";

@interface XSYVideoSecondController ()<XSYVideoSecondPageTableHeaderViewProtocol>
@property (nonatomic, strong) XSYVideoSecondPageMainModel *selfModel;
@property (nonatomic, strong) XSYVideoSecondPageTableHeaderView *headerView;
@property (nonatomic, strong) XSYVideoMovieController *moviePlayer;

@end

@implementation XSYVideoSecondController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = mainColor;
    self.tableView.rowHeight = screenWidth * 0.5;
    [self loadData];
    // 注册
    [self.tableView registerClass:[XSYVideoSecondPageCell class] forCellReuseIdentifier:secondPageVideoCellID];
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
    XSYVideoSecondPageCell *cell = [tableView dequeueReusableCellWithIdentifier:secondPageVideoCellID forIndexPath:indexPath];
    cell.model = self.selfModel.videoList[indexPath.row];
    cell.backgroundColor = mainColor;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"视频详情";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.moviePlayer = [[XSYVideoMovieController alloc] initWithContentURL:[NSURL URLWithString:self.selfModel.videoList[indexPath.row].repovideourlmp4]];
    NSLog(@"%@",self.selfModel.videoList[indexPath.row].repovideourlmp4);

    [self presentViewController:self.moviePlayer animated:YES completion:nil];
}

- (void)secondPageTableHeaderView:(XSYVideoSecondPageTableHeaderView *)secondPageTableHeaderView disTapMoreShadowView:(UIView *)shadowView WithModel:(XSYVideoSecondPageMainModel *)model{
    NSLog(@"%@",model);
    XSYVideoDetailController *vc = [[XSYVideoDetailController alloc] init];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - set method -
- (void)setModel:(XSYVideoFirstPageTopicModel *)model{
    _model = model;
    self.title = model.title;
}
@end

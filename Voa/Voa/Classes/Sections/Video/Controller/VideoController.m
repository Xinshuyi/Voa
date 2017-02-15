//
//  VideoController.m
//  Voa
//
//  Created by xin on 2017/2/4.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "VideoController.h"
#import "XSYNetworking.h"
#import "XSYVideoFirstPageMainModel.h"
#import "XSYVideoFirstPageTopicModel.h"
#import <SVProgressHUD.h>
#import "XSYVideoFlowLayout.h"
#import "XSYVideoFirstPageTopicModel.h"
#import "CZAdditions.h"
#import <Masonry.h>
#import "XSYCollectionHeaderView.h"
#import "XSYCycleViewCell.h"
#import "XSYVideoNormalwCell.h"

static NSString *videoCycleCellID = @"videoCycleCellID";
static NSString *videoNormalCellID = @"videoNormalCellID";
static NSString *headerCellID = @"headerCell";

@interface VideoController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSArray <XSYVideoFirstPageMainModel *> *modelArr;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation VideoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadData];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.top.equalTo(self.mas_topLayoutGuideBottom);
        make.bottom.equalTo(self.view);
    }];
}

#pragma mark - 加载数据 -
- (void)loadData{
    [XSYNetworking getVideoDataWithSuccessBlock:^(id response) {
        self.modelArr = response;
        [self.collectionView reloadData];
    } failureBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络不佳"];
    }];
}

#pragma mark - delegate and datasource -
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.modelArr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return self.modelArr[section].vos.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    XSYCollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerCellID forIndexPath:indexPath];
    headerView.backgroundColor = [UIColor whiteColor];
    headerView.title = self.modelArr[indexPath.section].name;
    return headerView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.item == 0) {
        XSYCycleViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:videoCycleCellID forIndexPath:indexPath];
        cell.vos = [self.modelArr firstObject].vos;
        return cell;
    }
    XSYVideoNormalwCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:videoNormalCellID forIndexPath:indexPath];
    cell.model = self.modelArr[indexPath.section].vos[indexPath.item];
    cell.backgroundColor = [UIColor cz_randomColor];
    return cell;
}

// 设置section头视图大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeZero;
    }
    return CGSizeMake(screenWidth, screenHeight * 0.05);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item == 0 && indexPath.section == 0) {
        return CGSizeMake(screenWidth, screenWidth * 0.618);

    }
    CGFloat WH = self.collectionView.bounds.size.width / 3 - 2;
    return CGSizeMake(WH, WH);
}

#pragma mark - lazy -
- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        XSYVideoFlowLayout *layout = [[XSYVideoFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        // 注册
        [_collectionView registerClass:[XSYCycleViewCell class] forCellWithReuseIdentifier:videoCycleCellID];
        [_collectionView registerClass:[XSYVideoNormalwCell class] forCellWithReuseIdentifier:videoNormalCellID];
        [_collectionView registerClass:[XSYCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerCellID];
    }
    return _collectionView;
}

@end

//
//  MineController.m
//  Voa
//
//  Created by xin on 2017/2/4.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "MineController.h"
#import "XSYMineHeaderView.h"
#import <Masonry.h>
#import "XSYMineFlowLayout.h"
#import "CZAdditions.h"
#import "XSYMineCollectionCell.h"

static NSString *mineCellID = @"mineCellID";

@interface MineController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) XSYMineHeaderView *headerView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray<NSDictionary *> *dataArr;


@end

@implementation MineController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.collectionView];
    [self addConstraints];
    
}

- (void)addConstraints{
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.top.equalTo(self.mas_topLayoutGuideBottom);
        make.height.mas_equalTo(screenHeight * 0.18);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.top.equalTo(self.headerView.mas_bottom);
        make.bottom.equalTo(self.view);
    }];
}

#pragma mark - datasource an delegate -
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 16;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    XSYMineCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:mineCellID forIndexPath:indexPath];
    cell.imageStr = self.dataArr[indexPath.item][@"image"];
    cell.title = self.dataArr[indexPath.item][@"title"];
    return cell;
}

#pragma mark - lazy -
- (XSYMineHeaderView *)headerView{
    if (_headerView == nil) {
        _headerView = [[XSYMineHeaderView alloc] init];
    }
    return _headerView;
}

- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        XSYMineFlowLayout *flowLayout = [[XSYMineFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        // 注册
        [_collectionView registerClass:[XSYMineCollectionCell class] forCellWithReuseIdentifier:mineCellID];
        _collectionView.backgroundColor = backgroundGray;
    }
    return _collectionView;
}

- (NSArray<NSDictionary *> *)dataArr{
    if (_dataArr == nil) {
        NSArray<NSString *> *titleArr = @[@"桃",@"之",@"夭",@"夭",@"灼",@"灼",@"其",@"华",@"之",@"子",@"于",@"归",@"宜",@"室",@"宜",@"家"];
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 1; i <= 16; i ++) {
            NSDictionary *dict = @{@"image":[NSString stringWithFormat:@"heart-%d",i],@"title":titleArr[i - 1]};
            [array addObject:dict];
        }
        _dataArr = array;
    }
    return _dataArr;
}
@end

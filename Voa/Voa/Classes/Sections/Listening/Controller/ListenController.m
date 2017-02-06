//
//  ListenController.m
//  Voa
//
//  Created by xin on 2017/2/4.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "ListenController.h"
#import "TopView.h"
#import "MyFlowLayout.h"
#import "CZAdditions.h"

static NSString *ListenCellID = @"ListenCellID";

@interface ListenController ()<UICollectionViewDelegate, UICollectionViewDataSource, TopViewDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) TopView *topView;
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation ListenController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI{
    // 分版面的view
    _topView = [[TopView alloc] init];
    _topView.frame = CGRectMake(0, 0, screenWidth, TopViewHeight);
    _topView.contentSize = CGSizeMake(screenWidth * ScreenWidthScale, 0);
    _topView.Delegate = self;
    [self.view addSubview:_topView];
    
    // collectionView
    MyFlowLayout *layout = [[MyFlowLayout alloc] init];

    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, TopViewHeight, screenWidth, collectionViewHeight) collectionViewLayout:layout];
    self.collectionView.contentSize = CGSizeMake(screenWidth * topViewButtonNum, 0);
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor grayColor];
    self.collectionView.bounces = NO;
    self.collectionView.pagingEnabled = YES;
    // datasource delegate
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    // 注册
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ListenCellID];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return topViewButtonNum;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ListenCellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor cz_randomColor];
    return cell;
}

- (void)topView:(TopView *)top didClickButton:(UIButton *)button{
    NSLog(@"%zd",button.tag);
    CGFloat offsetX = button.tag * screenWidth;
    CGPoint offset = self.collectionView.contentOffset;
    offset.x = offsetX;
    [self.collectionView setContentOffset:offset animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.collectionView]){
        self.topView.offsetNum = round(scrollView.contentOffset.x/screenWidth);
    }
}


@end

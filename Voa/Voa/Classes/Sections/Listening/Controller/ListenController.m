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
#import "XSYParentModel.h"

typedef NS_ENUM(NSUInteger, SpeedValue) {
    NormalSpeed,
    LowSpeed
};

static NSString *ListenCellID = @"ListenCellID";

@interface ListenController ()<UICollectionViewDelegate, UICollectionViewDataSource, TopViewDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) TopView *topView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, assign) SpeedValue speedValue;
@property (nonatomic, strong) NSMutableArray<XSYParentModel *> *normalSpeedArr;
@property (nonatomic, strong) NSMutableArray<XSYParentModel *> *lowSpeedArr;
@end

@implementation ListenController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI{
    // titleview
    _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"常速",@"慢速"]];
    _segmentedControl.bounds = CGRectMake(0, 0, screenWidth * 0.4, 25);
    _segmentedControl.selectedSegmentIndex = 0;
    self.navigationItem.titleView = _segmentedControl;
    [_segmentedControl addTarget:self action:@selector(segmentControlChange:) forControlEvents:UIControlEventValueChanged];
    // 分版面的view
    _topView = [[TopView alloc] initWithModelArr:self.speedValue == NormalSpeed ? self.normalSpeedArr : self.lowSpeedArr];
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

#pragma mark - segmentControl -
- (void)segmentControlChange:(UISegmentedControl *)segmentControl{
    NSInteger value = segmentControl.selectedSegmentIndex;
    self.speedValue = value == 0 ? NormalSpeed : LowSpeed;
    self.topView.modelArr = self.speedValue == NormalSpeed ? self.normalSpeedArr : self.lowSpeedArr;
    NSLog(@"%zd",self.speedValue);
    [self.topView initialization];
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger num = self.speedValue == NormalSpeed ? self.normalSpeedArr.count : self.lowSpeedArr.count;
    return num;
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
//    [self.collectionView reloadData];
}

# pragma mark - lazy -
- (NSMutableArray<XSYParentModel *> *)normalSpeedArr{
    if (_normalSpeedArr == nil) {
        NSArray *name = @[@"全部",@"美国",@"非洲",@"亚洲",@"中东",@"欧洲",@"科技",@"娱乐",@"经济",@"健康"];
        NSArray *ID =@[@"0",@"101",@"102",@"103",@"104",@"105",@"106",@"107",@"108",@"109"];
        _normalSpeedArr = [NSMutableArray array];
        NSInteger num = name.count;
        for (int i = 0; i < num; i ++) {
            XSYParentModel *model = [[XSYParentModel alloc] init];
            model.detailTitle = name[i];
            model.parentID = ID[i];
            [_normalSpeedArr addObject:model];
        }
    }
    return _normalSpeedArr;
}

- (NSMutableArray<XSYParentModel *> *)lowSpeedArr{
    if (_lowSpeedArr == nil) {
        NSArray *name = @[@"全部",@"美国",@"世界",@"生活",@"娱乐",@"健康",@"教务",@"商务",@"科技",@"历史",@"单词故事"];
        NSArray *ID =@[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"];
        _lowSpeedArr = [NSMutableArray array];
        NSInteger num = name.count;
        for (int i = 0; i < num; i ++) {
            XSYParentModel *model = [[XSYParentModel alloc] init];
            model.detailTitle = name[i];
            model.parentID = ID[i];
            [_lowSpeedArr addObject:model];
        }
    }
    return _lowSpeedArr;
}


@end

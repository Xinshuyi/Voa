//
//  XSYCycleViewCell.m
//  Voa
//
//  Created by xin on 2017/2/15.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "XSYCycleViewCell.h"
#import <SDCycleScrollView.h>
#import "XSYVideoFirstPageMainModel.h"
#import "XSYVideoFirstPageTopicModel.h"
#import <Masonry.h>

@interface XSYCycleViewCell ()<SDCycleScrollViewDelegate>
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@end

@implementation XSYCycleViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _cycleScrollView = [[SDCycleScrollView alloc] init];
        _cycleScrollView.placeholderImage = [UIImage imageNamed:@"placeHolderImage"];
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _cycleScrollView.pageDotColor = playViewGray;
        _cycleScrollView.currentPageDotColor = mainColor;
        _cycleScrollView.delegate = self;
        [self.contentView addSubview:_cycleScrollView];
        [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)setVos:(NSArray<XSYVideoFirstPageTopicModel *> *)vos{
    _vos = vos;
    NSMutableArray *urlStrArr = [NSMutableArray array];
    NSMutableArray *titleArr = [NSMutableArray array];
    for (int i = 0; i < vos.count; i++) {
        [urlStrArr addObject:vos[i].picUrl];
        [titleArr addObject:[NSString stringWithFormat:@"今日推荐 : %@",vos[i].title]];
    }
    self.cycleScrollView.imageURLStringsGroup = urlStrArr;
    self.cycleScrollView.titlesGroup = titleArr;
}

#pragma mark - cycleView delegate -

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    if ([self.delegate respondsToSelector:@selector(cycleViewCell:didSelectTheItemWithModel:)]) {
        [self.delegate cycleViewCell:self didSelectTheItemWithModel:self.vos[index]];
    }
}

@end

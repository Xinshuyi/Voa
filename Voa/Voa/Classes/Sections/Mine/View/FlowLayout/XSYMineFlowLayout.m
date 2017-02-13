//
//  XSYMineFlowLayout.m
//  Voa
//
//  Created by xin on 2017/2/13.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "XSYMineFlowLayout.h"

@implementation XSYMineFlowLayout
- (void)prepareLayout{
    CGFloat WH = self.collectionView.bounds.size.width / 4 - 0.5;
    self.itemSize = CGSizeMake(WH, WH);
    self.minimumLineSpacing = 2 / 3.0;
    self.minimumInteritemSpacing = 2 / 3.0;
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.sectionInset = UIEdgeInsetsMake(8, 0, 0, 0);
}
@end

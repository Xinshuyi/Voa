//
//  XSYVideoFlowLayout.m
//  Voa
//
//  Created by xin on 2017/2/15.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "XSYVideoFlowLayout.h"

@implementation XSYVideoFlowLayout
- (void)prepareLayout{
    CGFloat W = self.collectionView.bounds.size.width / 3 - 2;
    CGFloat H = W * 0.618;
    self.itemSize = CGSizeMake(W, H);
    self.minimumLineSpacing = 3;
    self.minimumInteritemSpacing = 3;
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
}
@end

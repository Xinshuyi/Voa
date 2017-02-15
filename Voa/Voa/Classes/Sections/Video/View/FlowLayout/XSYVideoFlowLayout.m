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
    CGFloat WH = self.collectionView.bounds.size.width / 3 - 2;
    self.itemSize = CGSizeMake(WH, WH);
    self.minimumLineSpacing = 3;
    self.minimumInteritemSpacing = 3;
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
}
@end

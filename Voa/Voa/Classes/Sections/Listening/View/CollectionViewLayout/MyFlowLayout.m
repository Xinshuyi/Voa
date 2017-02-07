//
//  MyFlowLayout.m
//  Voa
//
//  Created by xin on 2017/2/5.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "MyFlowLayout.h"

@implementation MyFlowLayout
- (void)prepareLayout{
    self.itemSize = CGSizeMake(screenWidth, screenHeight - TopViewHeight - 64 - 44);
    self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumLineSpacing = 0;
}
@end

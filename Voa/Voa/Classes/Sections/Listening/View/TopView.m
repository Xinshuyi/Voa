//
//  TopView.m
//  Voa
//
//  Created by xin on 2017/2/5.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "TopView.h"
#import "XSYParentModel.h"

#define MarginHorizontal 10
#define MarginVertical 5
#define BtnWidth (self.contentSize.width - (topViewButtonNum + 1) * MarginHorizontal)/(topViewButtonNum * 1.0)
#define BtnHeight self.bounds.size.height - 2 * MarginVertical

@interface TopView ()
@property (nonatomic, strong) NSMutableArray<UIButton *> *btnArr;
@property (nonatomic, strong) UIButton *lastBtn;
@end

@implementation TopView
- (instancetype)initWithModelArr:(NSArray<XSYParentModel *> *)modelArr{
    if (self = [super init]) {
        self.showsHorizontalScrollIndicator = NO;
        self.backgroundColor = [UIColor whiteColor];
        for (int i = 0; i < modelArr.count; i++) {
            UIButton *btn = [[UIButton alloc] init];
            btn.tag = i;
            [btn setTitle:modelArr[i].detailTitle forState:UIControlStateNormal];
            [btn setBackgroundColor:mainColor];
            [self addSubview:btn];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
            // 监听按钮
            [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self.btnArr addObject:btn];
        }
    }
    self.btnArr[0].selected = YES;
    self.lastBtn = self.btnArr[0];
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    NSInteger i = 0;
    for (UIButton *btn in self.btnArr) {
        CGFloat btnX = MarginHorizontal + i * (MarginHorizontal + BtnWidth);
        btn.frame = CGRectMake( btnX, MarginVertical, BtnWidth, BtnHeight);
        i++;
    }
}

- (void)clickBtn:(UIButton *)button{
    if (button.selected == NO) {
        button.selected = !button.selected;
        self.lastBtn.selected = NO;
        self.lastBtn = button;
        CGPoint contentOffset = CGPointMake(button.tag * (MarginHorizontal + BtnWidth), 0);
        [self setContentOffset:contentOffset animated:YES];
    }
        if ([self.Delegate respondsToSelector:@selector(topView:didClickButton:)]) {
        [self.Delegate topView:self didClickButton:button];
    }
}

- (void)initialization{
    if (![self.btnArr[0] isEqual:self.lastBtn]){
        self.btnArr[0].selected = YES;
        self.lastBtn.selected = NO;
        self.lastBtn = self.btnArr[0];
        [self setContentOffset:CGPointZero animated:YES];
    }
}

- (void)setOffsetNum:(CGFloat)offsetNum{
    _offsetNum = offsetNum;
    NSInteger numTag = round(offsetNum);
    
    if (![self.btnArr[numTag] isEqual:self.lastBtn]) {
        self.btnArr[numTag].selected = YES;
        self.lastBtn.selected = NO;
        self.lastBtn = self.btnArr[numTag];
        CGPoint contentOffset = CGPointMake(offsetNum * (MarginHorizontal + BtnWidth), 0);
        [self setContentOffset:contentOffset animated:YES];
    }
}
- (void)setModelArr:(NSMutableArray<XSYParentModel *> *)modelArr{
    _modelArr = modelArr;
    NSInteger delata = modelArr.count - self.btnArr.count;
    if (delata > 0) {
        for (int i = 0; i < delata; i ++) {
            UIButton *moreBtn = [[UIButton alloc] init];
            [self addSubview:moreBtn];
            [self.btnArr addObject:moreBtn];
            moreBtn.tag = i + self.btnArr.count - 1;
            [moreBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
            // 监听按钮
            [moreBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        }
    }else{
        for (int i = 0; i < -delata; i ++) {
            [self.btnArr.lastObject removeFromSuperview];
            [self.btnArr removeLastObject];
        }
    }
    for (int i = 0; i < modelArr.count; i ++) {
        [self.btnArr[i] setTitle:modelArr[i].detailTitle forState:UIControlStateNormal];
        [self.btnArr[i] setBackgroundColor:mainColor];
    }
}

- (NSMutableArray<UIButton *> *)btnArr{
    if (_btnArr == nil) {
        _btnArr = [NSMutableArray array];
    }
    return _btnArr;
}
@end

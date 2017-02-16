//
//  XSYVideoDetailController.m
//  Voa
//
//  Created by xin on 2017/2/16.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "XSYVideoDetailController.h"
#import <Masonry.h>
#import "XSYVideoSecondPageMainModel.h"

@interface XSYVideoDetailController ()

@end

@implementation XSYVideoDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.model.title;
    self.view.backgroundColor = mainColor;
    UITextView *textView = [[UITextView alloc] init];
    textView.text = self.model.desc;
    textView.scrollEnabled = NO;
    textView.editable = NO;
    textView.backgroundColor = mainColor;
    textView.textColor = [UIColor whiteColor];
    textView.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.leading.equalTo(self.view).offset(15);
        make.trailing.equalTo(self.view).offset(-15);
    }];
}

@end

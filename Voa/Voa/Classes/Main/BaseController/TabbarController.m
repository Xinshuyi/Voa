//
//  TabbarController.m
//  Voa
//
//  Created by xin on 2017/2/3.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "TabbarController.h"
#import "UIColor+CZAddition.h"
#import "NavigationController.h"
#import "EssayController.h"
#import "ListenController.h"
#import "MineController.h"
#import "VideoController.h"

@interface TabbarController ()

@end

@implementation TabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.tintColor = mainColor;
    // 2.tabBar 条的颜色
    self.tabBar.barTintColor = [UIColor whiteColor];
    
    // 3.创建tabBar的子控制器，设置item的图片 选中图片,title同时确定了两个主控制器的标题 这里的自控制器如果是collection控制器 一定要重写- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout
    [self creatChildNavigationControllerWithVC:[ListenController new] title:@"听力" image:@"tingli" selectedImage:@"tingli_selected"];
    
    [self creatChildNavigationControllerWithVC:[VideoController new] title:@"视频" image:@"shiping" selectedImage:@"shiping_selected"];
    
    [self creatChildNavigationControllerWithVC:[EssayController new] title:@"文章" image:@"wenzhang" selectedImage:@"wenzhang_selected"];
    
    [self creatChildNavigationControllerWithVC:[MineController new] title:@"我" image:@"wo" selectedImage:@"wo_selected"];
    
    // 透明度为不透明，默认就是透明的，在设计环境下 有两种要求
    // 1. 要求不透明 在tableview布满屏幕的情况下，设置与上下导航栏的约束
    // 2 .要求透明 设置和view的edges相同
    self.tabBar.translucent = NO;
}

- (void)creatChildNavigationControllerWithVC:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    vc.title = title;
    vc.view.backgroundColor = [UIColor whiteColor];
    UINavigationController *controller = [[NavigationController alloc] initWithRootViewController:vc];
    controller.tabBarItem.image =[[UIImage imageNamed: image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.selectedImage =[[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置tabbarItem 文字的颜色 这两个方法较好 甚至能改变三个不同tabbar的字体的两种颜色
    //    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
    //    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor greenColor]} forState:UIControlStateNormal];
    //tabbar标题需要文字和图片 要是光设置图片没有文字 标题文字的位置就会留空 非常难看 如何解决
    // 使得图片下移
    //controller.tabBarItem.imageInsets = UIEdgeInsetsMake(5.0, 0, -5.0, 0);
    [self addChildViewController:controller];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    NSInteger tabbarIndex = [tabBar.items indexOfObject:item];
    NSInteger index = 0;
    for (UIView *subview in tabBar.subviews) {
        if ([subview isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (index == tabbarIndex) {
                for (UIView *v in subview.subviews) {
                    if ([v isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
                        v.transform = CGAffineTransformMakeScale(0.4, 0.4);
                        // 做动画
                        [UIView animateWithDuration:0.5 animations:^{
                            v.transform = CGAffineTransformIdentity;
                        }];
                    }
                }
            }
            index ++;
        }
    }
}



@end

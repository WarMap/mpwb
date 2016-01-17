//
//  MPMainViewController.m
//  MPWeiBo
//
//  Created by John on 15/12/27.
//  Copyright © 2015年 John. All rights reserved.
//

#import "MPMainViewController.h"
#import "MPTabBar.h"
#import "MPHomeViewController.h"
#import "MPDiscoverViewController.h"
#import "MPProfileViewController.h"
#import "MPMessageViewController.h"
#import "MPNavigationController.h"
#import "UIImage+Utils.h"
@interface MPMainViewController()
@property (nonatomic, strong) MPTabBar *customTabBar;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) MPHomeViewController *home;

@end
@implementation MPMainViewController

+(void)initialize {
    [[UITabBar appearanceWhenContainedInInstancesOfClasses:@[self]] setBarTintColor:[UIColor whiteColor]];
    [[UITabBar appearanceWhenContainedInInstancesOfClasses:@[self]] setTintColor:[UIColor orangeColor]];
}
- (NSMutableArray *)items
{
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    // 添加所有子控制器
    [self setUpAllChildViewController];
    // 自定义tabBar
    [self setUpTabBar];
}

#pragma mark - 设置tabBar
- (void)setUpTabBar
{
    // 自定义tabBar
    MPTabBar *tabBar = [[MPTabBar alloc] initWithFrame:self.tabBar.bounds];
    tabBar.backgroundColor = [UIColor whiteColor];
    // 设置代理
    tabBar.delegate = self;
    // 给tabBar传递tabBarItem模型
    tabBar.items = self.items;
    self.customTabBar = tabBar;
    [self.tabBar addSubview:self.customTabBar];
}

#pragma mark - 当点击tabBar上的按钮调用
- (void)tabBar:(MPTabBar *)tabBar didClickButton:(NSInteger)index
{
    self.selectedIndex = index;
}


#pragma mark - 添加所有的子控制器
- (void)setUpAllChildViewController
{
    // 首页
    MPHomeViewController *home = [[MPHomeViewController alloc] init];
    [self setUpOneChildViewController:home image:[UIImage imageNamed:@"tabbar_home"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_home_selected"] title:@"首页"];
    _home = home;
    
    // 消息
    MPMessageViewController *message = [[MPMessageViewController alloc] init];
    [self setUpOneChildViewController:message image:[UIImage imageNamed:@"tabbar_message_center"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_message_center_selected"] title:@"消息"];
    
    // 发现
    MPDiscoverViewController *discover = [[MPDiscoverViewController alloc] init];
    [self setUpOneChildViewController:discover image:[UIImage imageNamed:@"tabbar_discover"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_discover_selected"] title:@"发现"];
    
    // 我
    MPProfileViewController *profile = [[MPProfileViewController alloc] init];
    [self setUpOneChildViewController:profile image:[UIImage imageNamed:@"tabbar_profile"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_profile_selected"] title:@"我"];
}
// navigationItem决定导航条上的内容
// 导航条上的内容由栈顶控制器的navigationItem决定

#pragma mark - 添加一个子控制器
- (void)setUpOneChildViewController:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title
{
    vc.title = title;
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selectedImage;
    // 保存tabBarItem模型到数组
    [self.items addObject:vc.tabBarItem];
    MPNavigationController *nav = [[MPNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}




- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.customTabBar.items = self.tabBar.items;
    for (UIView *tabbar in self.tabBar.subviews) {
        if ([tabbar isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbar removeFromSuperview];
        }
    }
}
@end

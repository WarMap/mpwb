//
//  MPNavigationController.m
//  MPWeiBo
//
//  Created by John on 16/1/13.
//  Copyright © 2016年 John. All rights reserved.
//

#import "MPNavigationController.h"
#import "UIViewController+Utils.h"
#import "MPTabBar.h"
@interface MPNavigationController()<UINavigationControllerDelegate>
@property (nonatomic, strong) id popDelegate;

@end
@implementation MPNavigationController

+ (void)initialize
{
    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[self]] setTintColor:[UIColor orangeColor]];  
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _popDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count) { // 不是根控制器
        
        viewController.hidesBottomBarWhenPushed = YES;
        
        [viewController leftBarButtonItemWithTitle:nil image:[UIImage imageNamed:@"navigationbar_back"] highImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] target:self action:@selector(popToPre)  forControlEvents:UIControlEventTouchUpInside];
        
        [viewController rightBarButtonItemWithTitle:nil image:[UIImage imageNamed:@"navigationbar_more"] highImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] target:self action:@selector(popToRoot)  forControlEvents:UIControlEventTouchUpInside];
    }
    
    [super pushViewController:viewController animated:animated];
    
}
- (void)popToRoot
{
    [self popToRootViewControllerAnimated:YES];
}
- (void)popToPre
{
    [self popViewControllerAnimated:YES];
}


- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController == self.viewControllers[0]) { // 是根控制器
        self.interactivePopGestureRecognizer.delegate = _popDelegate;
    }else{ // 非根控制器
        self.interactivePopGestureRecognizer.delegate = nil;
    }
} 
@end

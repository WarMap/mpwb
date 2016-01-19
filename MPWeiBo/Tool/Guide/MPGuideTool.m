
//
//  MPGuideTool.m
//  MPWeiBo
//
//  Created by John on 16/1/17.
//  Copyright © 2016年 John. All rights reserved.
//

#import "MPGuideTool.h"
#import "MPNewFeatureController.h"
#import "MPMainViewController.h"

#define MPVersionKey @"version"
#define MPUserDefaults [NSUserDefaults standardUserDefaults]

@implementation MPGuideTool


+ (void)guideRootViewController:(UIWindow *)window
{
    // 判断是否有新版本
    // 获取之前的版本
    NSString *oldVersion = [MPUserDefaults objectForKey:MPVersionKey];
    // 获取当前版本
    NSString *verKey = (__bridge NSString *)kCFBundleVersionKey;
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[verKey];
    
    if (![oldVersion isEqualToString:currentVersion]) { // 有新版本
        // 存储新版本
        [MPUserDefaults setObject:currentVersion forKey:MPVersionKey
         ];
        [MPUserDefaults synchronize];
        
        MPNewFeatureController *newFeatureVc = [[MPNewFeatureController alloc] init];
        window.rootViewController = newFeatureVc;
    }else{
        
        MPMainViewController *tabBarVc = [[MPMainViewController alloc] init];
        window.rootViewController = tabBarVc;
    }
    
}
@end

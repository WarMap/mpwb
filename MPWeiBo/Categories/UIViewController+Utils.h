//
//  UIViewController+Utils.h
//  MPWeiBo
//
//  Created by John on 16/1/13.
//  Copyright © 2016年 John. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>


@interface UIViewController (Utils)

@property (nonatomic,strong) MBProgressHUD *hud;
- (void)showHud:(NSString *)text;
- (void)showOnlyText:(NSString *)text dismiss:(BOOL)dismiss;
- (void)dismiss;

-(void)setCustomTitle:(NSString *)title;
- (void)rightBarButtonItemWithTitle:(NSString *)title image:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
- (void)leftBarButtonItemWithTitle:(NSString *)title image:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

@end

//
//  UIViewController+Utils.m
//  MPWeiBo
//
//  Created by John on 16/1/13.
//  Copyright © 2016年 John. All rights reserved.
//

#import "UIViewController+Utils.h"
#import "Macro.h"
#import "NSString+Size.h"
#import "UIColor+HEX.h"
#import <objc/runtime.h>

@implementation UIViewController (Utils)

- (MBProgressHUD *)hud
{
    return objc_getAssociatedObject(self, _cmd) ;
}

- (void)setHud:(MBProgressHUD *)hud
{
    objc_setAssociatedObject(self, @selector(hud), hud, OBJC_ASSOCIATION_RETAIN);
}

- (void)showHud:(NSString *)text{
    if (!self.hud) {
        self.hud = [[MBProgressHUD alloc]initWithView:self.view];
        self.hud.opacity = 0.4;
        self.hud.minSize = CGSizeMake(120, 120);
        [self.view addSubview:self.hud];
    }
    [self.view bringSubviewToFront:self.hud];
    self.hud.labelText = text;
    [self.hud show:YES];
}

- (void)showOnlyText:(NSString *)text dismiss:(BOOL)dismiss {
    [self showHud:text];
    
    if (dismiss) {
        double delayInSeconds = 1.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void) { [self dismiss]; });
    }
}

- (void)dismiss {
    self.hud.alpha = 0.f;
    self.hud.mode = MBProgressHUDModeIndeterminate;
    self.hud.labelText = @"";
    self.hud.detailsLabelText = @"";
}


- (void)setCustomTitle:(NSString *)title {
    self.navigationItem.title = @"";
    CGFloat width = [title sizeWithFont:[UIFont systemFontOfSize:18] constrainedToHeight:40].width;
    UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectMake((MainScreenWidth - width)/2, 0, width+5, 40)];
    titleView.text = title;
    titleView.textAlignment = NSTextAlignmentCenter;
    [titleView setTextColor:[UIColor colorWithHexString:@"454545"]];
    [titleView setFont:[UIFont boldSystemFontOfSize:18]];
    self.navigationItem.titleView = titleView;
}
- (void)rightBarButtonItemWithTitle:(NSString *)title image:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (title) {
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    }
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn setBackgroundImage:highImage forState:UIControlStateHighlighted];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:controlEvents];
    self.navigationItem.rightBarButtonItem =  [[UIBarButtonItem alloc] initWithCustomView:btn];
}
- (void)leftBarButtonItemWithTitle:(NSString *)title image:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (title) {
        [btn setTitle:title forState:UIControlStateNormal];
    }
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn setBackgroundImage:highImage forState:UIControlStateHighlighted];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:controlEvents];
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end

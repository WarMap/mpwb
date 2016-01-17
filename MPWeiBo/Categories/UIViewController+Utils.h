//
//  UIViewController+Utils.h
//  MPWeiBo
//
//  Created by John on 16/1/13.
//  Copyright © 2016年 John. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Utils)

-(void)setCustomTitle:(NSString *)title;
- (void)rightBarButtonItemWithTitle:(NSString *)title image:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
- (void)leftBarButtonItemWithTitle:(NSString *)title image:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

@end

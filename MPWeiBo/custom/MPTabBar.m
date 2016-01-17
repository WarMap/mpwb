//
//  MPTabBar.m
//  MPWeiBo
//
//  Created by John on 16/1/13.
//  Copyright © 2016年 John. All rights reserved.
//

#import "MPTabBar.h"

@interface MPTabBar()
@property (nonatomic, strong) UIButton *midButton;

@end

@implementation MPTabBar

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = width/(self.items.count + 1);
    CGFloat btnH = height;
    
    int i = 0;
    for (UIView *tabBarButton in self.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (i == 2) {
                i = 3;
            }
            btnX = i * btnW;
            tabBarButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
            ++i;
        }
    }
    self.midButton.center = CGPointMake(width * 0.5, height * 0.5);
    
}
- (UIButton *)midButton {
    if (_midButton == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_add"] forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [btn sizeToFit];
        _midButton = btn;
        [self addSubview:_midButton];
    }
    return _midButton;
}


@end

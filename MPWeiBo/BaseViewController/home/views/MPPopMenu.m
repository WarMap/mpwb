
//
//  MPPopMenu.m
//  MPWeiBo
//
//  Created by John on 16/1/14.
//  Copyright © 2016年 John. All rights reserved.
//

#import "MPPopMenu.h"
#import "UIImage+Utils.h"
#import "Macro.h"
#import "UIView+Frame.h"

@implementation MPPopMenu
// 显示弹出菜单
+ (instancetype)showInRect:(CGRect)rect
{
    MPPopMenu *menu = [[self alloc] initWithFrame:rect];
    menu.userInteractionEnabled = YES;
    menu.image = [UIImage imageWithResizeableImageName:@"popover_background"];
    
    [MPKeyWindow addSubview:menu];
    
    return menu;
}

// 隐藏弹出菜单
+ (void)hide
{
    for (UIView *popMenu in MPKeyWindow.subviews) {
        if ([popMenu isKindOfClass:self]) {
            [popMenu removeFromSuperview];
        }
    }
}

// 设置内容视图
- (void)setContentView:(UIView *)contentView
{
    // 先移除之前内容视图
    [_contentView removeFromSuperview];
    
    _contentView = contentView;
    contentView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:contentView];
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 计算内容视图尺寸
    CGFloat y = 9;
    CGFloat margin = 5;
    CGFloat x = margin;
    CGFloat w = self.width - 2 * margin;
    CGFloat h = self.height - y - margin;
    
    _contentView.frame = CGRectMake(x, y, w, h);
    
}
@end

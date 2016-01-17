//
//  MPPopMenu.h
//  MPWeiBo
//
//  Created by John on 16/1/14.
//  Copyright © 2016年 John. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MPPopMenu : UIImageView

/**
 *  显示弹出菜单
 */
+ (instancetype)showInRect:(CGRect)rect;

/**
 *  隐藏弹出菜单
 */
+ (void)hide;

// 内容视图
@property (nonatomic, weak) UIView *contentView;
@end

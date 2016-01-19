//
//  MPPopMenu.h
//  MPWeiBo
//
//  Created by John on 16/1/14.
//  Copyright © 2016年 John. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MPPopView;

@protocol MPPopViewDelegate <NSObject>

@optional
- (void)popViewDidDismiss:(MPPopView *)popView;

@end

@interface MPPopView : UIView

+ (instancetype)popView;

- (void)showInRect:(CGRect)rect;

@property (nonatomic, weak) id<MPPopViewDelegate> delegate;

@property (nonatomic, weak) UIView *contentView;

@end

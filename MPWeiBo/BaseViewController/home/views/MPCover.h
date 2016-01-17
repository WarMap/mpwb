//
//  MpCover.h
//  MPWeiBo
//
//  Created by John on 16/1/14.
//  Copyright © 2016年 John. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MPCover;
@protocol MPCoverDelegate <NSObject>

@optional
// 点击蒙板的时候调用
- (void)coverDidClickCover:(MPCover *)cover;

@end


@interface MPCover : UIView
/**
 *  显示蒙板
 */
+ (instancetype)show;

// 设置浅灰色蒙板
@property (nonatomic, assign) BOOL dimBackground;

@property (nonatomic, weak) id<MPCoverDelegate> delegate;

@end

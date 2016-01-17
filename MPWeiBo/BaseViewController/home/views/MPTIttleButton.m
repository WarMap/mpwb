//
//  MPTittleButton.m
//  MPWeiBo
//
//  Created by John on 16/1/13.
//  Copyright © 2016年 John. All rights reserved.
//

#import "MPTittleButton.h"
#import "UIImageView+Addition.h"
#import "UIImage+Utils.h"
#import "UIView+Frame.h"

@implementation MPTittleButton


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage  imageWithResizeableImageName:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.currentImage == nil) return;
    CGFloat imageViewWidth = CGRectGetWidth(self.imageView.frame);
    CGFloat labelWidth = CGRectGetWidth(self.titleLabel.frame);
    
     self.imageEdgeInsets = UIEdgeInsetsMake(0,0 + labelWidth,0,0 - labelWidth);
     self.titleEdgeInsets = UIEdgeInsetsMake(0,0 - imageViewWidth,0, 0 + imageViewWidth);
    
    // title
//    self.titleLabel.left = self.imageView.left;
//    
//    // image
//    self.imageView.left = CGRectGetMaxX(self.titleLabel.frame);
}

// 重写setTitle方法，扩展计算尺寸功能
- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self sizeToFit];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    [self sizeToFit];
}

@end

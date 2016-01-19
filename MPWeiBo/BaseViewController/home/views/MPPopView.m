
//
//  MPPopMenu.m
//  MPWeiBo
//
//  Created by John on 16/1/14.
//  Copyright © 2016年 John. All rights reserved.
//

#import "MPPopView.h"
#import "UIImage+Utils.h"
#import "Macro.h"
#import "UIView+Frame.h"


#define MPMarginX 5
#define MPMarginY 13
@interface MPPopView()

@property (nonatomic, weak) UIImageView *containView;

@end

@implementation MPPopView

- (UIImageView *)containView
{
    if (_containView == nil) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageWithResizeableImageName:@"popover_background"];
        imageView.userInteractionEnabled = YES;
        [self addSubview:imageView];
        _containView = imageView;
    }
    return _containView;
}

+ (instancetype)popView
{
    MPPopView *p = [[MPPopView alloc] initWithFrame:MPKeyWindow.bounds];
    
    return p;
}

- (void)showInRect:(CGRect)rect
{
    self.containView.frame = rect;
    
    [MPKeyWindow addSubview:self];
}

- (void)setContentView:(UIView *)contentView
{
    _contentView = contentView;
    
    [self.containView addSubview:_contentView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat x = MPMarginX;
    CGFloat y = MPMarginY;
    CGFloat w = _containView.width - MPMarginX * 2;
    CGFloat h = _containView.height - MPMarginY * 2;
    
    _contentView.frame = CGRectMake(x, y, w, h);
    
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
    
    if ([_delegate respondsToSelector:@selector(popViewDidDismiss:)]) {
        [_delegate popViewDidDismiss:self];
    }
}

@end

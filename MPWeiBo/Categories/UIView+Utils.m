//
//  UIView+Utils.m
//  MPWeiBo
//
//  Created by John on 16/1/19.
//  Copyright © 2016年 John. All rights reserved.
//

#import "UIView+Utils.h"

@implementation UIView (Utils)

- (CGPoint)center:(BOOL)usePresentationLayer {
    if (usePresentationLayer && self.layer.presentationLayer != nil) {
        CALayer *presentationLayer = self.layer.presentationLayer;
        return presentationLayer.position;
    }
    return self.center;
}

@end

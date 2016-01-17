//
//  UIImage+Utils.m
//  MPWeiBo
//
//  Created by John on 16/1/13.
//  Copyright © 2016年 John. All rights reserved.
//

#import "UIImage+Utils.h"

@implementation UIImage (Utils)

+ (UIImage *)imageWithResizeableImageName:(NSString *)name {
    UIImage *image = [UIImage imageNamed:name];
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height * 0.5 , image.size.width * 0.5, image.size.height * 0.5, image.size.width * 0.5)];
}
+ (instancetype)imageWithOriginalName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
@end

//
//  UIImage+Utils.h
//  MPWeiBo
//
//  Created by John on 16/1/13.
//  Copyright © 2016年 John. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Utils)
+ (UIImage *)imageWithResizeableImageName:(NSString *)name;
+ (instancetype)imageWithOriginalName:(NSString *)imageName;
@end

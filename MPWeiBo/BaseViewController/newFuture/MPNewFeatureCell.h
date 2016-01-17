//
//  MPNewFeatureCell.h
//  MPWeiBo
//
//  Created by John on 16/1/17.
//  Copyright © 2016年 John. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MPNewFeatureCell : UICollectionViewCell
@property (nonatomic, strong) UIImage *image;


// 判断是否是最后一页
- (void)setIndexPath:(NSIndexPath *)indexPath count:(int)count;
@end

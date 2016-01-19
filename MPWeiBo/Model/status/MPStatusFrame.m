
//
//  MPStatusFrame.m
//  MPWeiBo
//
//  Created by John on 16/1/17.
//  Copyright © 2016年 John. All rights reserved.
//

#import "MPStatusFrame.h"
#import "MPStatus.h"
#import "Macro.h"
#import <UIKit/UIKit.h>
#import "MPUser.h"
#import "MPPhotosView.h"

@implementation MPStatusFrame

- (void)setStatus:(MPStatus *)status
{
    _status = status;
    
    // 计算原创微博
    [self setUpOriginalFrame];
    
    CGFloat toolBarY = CGRectGetMaxY(_originalViewF);
    if (status.retweeted_status) {
        
        // 计算转发微博
        [self setUpRetweetFrame];
        
        toolBarY = CGRectGetMaxY(_retweetedViewF);
    }
    
    // 计算工具条
    CGFloat toolBarH = 35;
    _toolBarViewF = CGRectMake(0, toolBarY, MainScreenWidth, toolBarH);
    
    // 计算cell的高度
    _cellHeight = CGRectGetMaxY(_toolBarViewF);
}


/**
 *  计算原创微博
 */
- (void)setUpOriginalFrame
{
    // 头像
    CGFloat iconX = MPCellMargin;
    CGFloat iconY = MPCellMargin + MPCellMargin;
    CGFloat iconW = 35;
    CGFloat iconH = 35;
    _iconViewF = CGRectMake(iconX, iconY, iconW, iconH);
    
    // 昵称
    CGFloat nameX = CGRectGetMaxX(_iconViewF) + MPCellMargin;
    CGFloat nameY = iconY;
    NSMutableDictionary *nameDict = [NSMutableDictionary dictionary];
    nameDict[NSFontAttributeName] = MPNameFont;
    CGSize nameSize = [_status.user.name sizeWithAttributes:nameDict];
    _nameViewF = (CGRect){{nameX,nameY},nameSize};
    
    // 会员
    if (_status.user.isVip) { // 是会员
        CGFloat vipX = CGRectGetMaxX(_nameViewF) + MPCellMargin;
        CGFloat vipW = 14;
        CGFloat vipH = 14;
        
        CGFloat vipY = nameY;
        _vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
    }
    
    // 时间
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(_nameViewF) ;
    NSMutableDictionary *timeDict = [NSMutableDictionary dictionary];
    timeDict[NSFontAttributeName] = MPTimeFont;
    CGSize timeSize = [_status.created_at sizeWithAttributes:timeDict];
    _timeViewF = (CGRect){{timeX,timeY},timeSize};
    
    // 来源
    CGFloat sourceX = CGRectGetMaxX(_timeViewF) + MPCellMargin;
    CGFloat sourceY = timeY;
    NSMutableDictionary *sourceDict = [NSMutableDictionary dictionary];
    sourceDict[NSFontAttributeName] = MPSourceFont;
    CGSize sourceSize = [_status.source sizeWithAttributes:sourceDict];
    _sourceViewF = (CGRect){{sourceX,sourceY},sourceSize};
    
    // 内容
    CGFloat textX = MPCellMargin;
    CGFloat textY = MAX(CGRectGetMaxY(_iconViewF), CGRectGetMaxY(_nameViewF)) + MPCellMargin;
    NSMutableDictionary *textDict = [NSMutableDictionary dictionary];
    textDict[NSFontAttributeName] = MPTextFont;
    CGSize textSize = [_status.text boundingRectWithSize:CGSizeMake(MainScreenWidth - MPCellMargin * 2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:textDict context:nil].size;
    _textViewF = (CGRect){{textX,textY},textSize};
    
    // 原创微博frame
    CGFloat originH = CGRectGetMaxY(_textViewF) + MPCellMargin;
    
    // 配图
    if (_status.pic_urls.count) { // 有配图
        CGFloat photosX = MPCellMargin;
        CGFloat photosY = originH;
        CGSize photosSize = [MPPhotosView photosSizeWithCount:_status.pic_urls.count];
        _photosViewF = (CGRect){{photosX,photosY},photosSize};
        
        originH = CGRectGetMaxY(_photosViewF) + MPCellMargin;
    }
    
    _originalViewF = CGRectMake(0, MPCellMargin, MainScreenWidth, originH);
    
}


/**
 *  计算转发微博
 */
- (void)setUpRetweetFrame
{
    // 昵称
    CGFloat nameX = MPCellMargin;
    CGFloat nameY = MPCellMargin;
    NSMutableDictionary *nameDict = [NSMutableDictionary dictionary];
    nameDict[NSFontAttributeName] = MPNameFont;
    NSString *retweetName = [NSString stringWithFormat:@"@%@",_status.retweeted_status.user.name];
    CGSize nameSize = [retweetName sizeWithAttributes:nameDict];
    _retweetNameViewF = (CGRect){{nameX,nameY},nameSize};
    
    
    // 内容
    CGFloat textX = MPCellMargin;
    CGFloat textY = CGRectGetMaxY(_retweetNameViewF) + MPCellMargin;
    NSMutableDictionary *textDict = [NSMutableDictionary dictionary];
    textDict[NSFontAttributeName] = MPTextFont;
    CGSize textSize = [_status.retweeted_status.text boundingRectWithSize:CGSizeMake(MainScreenWidth - MPCellMargin * 2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:textDict context:nil].size;
    _retweetTextViewF = (CGRect){{textX,textY},textSize};
    
    
    CGFloat retweetH = CGRectGetMaxY(_retweetTextViewF) + MPCellMargin;
    
    // 配图
    if (_status.retweeted_status.pic_urls.count) { // 有配图
        CGFloat photosX = MPCellMargin;
        CGFloat photosY = retweetH;
        CGSize photosSize = [MPPhotosView photosSizeWithCount:_status.retweeted_status.pic_urls.count];
        _retweetPhotosViewF = (CGRect){{photosX,photosY},photosSize};
        
        retweetH = CGRectGetMaxY(_retweetPhotosViewF) + MPCellMargin;
    }
    
    
    // 转发微博frame
    CGFloat retweetW = [UIScreen mainScreen].bounds.size.width;
    CGFloat retweetY = CGRectGetMaxY(_originalViewF);
    
    _retweetedViewF = CGRectMake(0, retweetY, retweetW, retweetH);
    
    
}

@end

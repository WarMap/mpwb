//
//  MPUser.m
//  MPWeiBo
//
//  Created by John on 16/1/17.
//  Copyright © 2016年 John. All rights reserved.
//

#import "MPUser.h"

@implementation MPUser
- (void)setMbtype:(int)mbtype
{
    _mbtype = mbtype;
    _vip = mbtype > 2;
}

@end

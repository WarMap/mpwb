//
//  IWStatusResult.m
//  ItcastWeibo
//
//  Created by yz on 14/11/13.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import "MPStatusResult.h"
#import "MJExtension.h"
#import "MPStatus.h"
@implementation MPStatusResult

- (NSDictionary *)objectClassInArray
{
    return @{@"statuses":[MPStatus class]};
}

@end

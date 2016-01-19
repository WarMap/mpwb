//
//  IWStatusCacheTool.h
//  ItcastWeibo
//
//  Created by yz on 14/11/19.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MPStatusParam;
@interface MPStatusCacheTool : NSObject

+ (void)saveWithStatuses:(NSArray *)dictArr;

+ (NSArray *)statusesWithParam:(MPStatusParam *)param;

@end

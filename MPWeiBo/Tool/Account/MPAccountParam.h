//
//  MPAccountParam.h
//  MPWeiBo
//
//  Created by John on 16/1/17.
//  Copyright © 2016年 John. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MPAccountParam : NSObject

@property (nonatomic, copy) NSString *client_id;
@property (nonatomic, copy) NSString *client_secret;
@property (nonatomic, copy) NSString *grant_type;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *redirect_uri;

@end

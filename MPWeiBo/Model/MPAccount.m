//
//  MPAccount.m
//  MPWeiBo
//
//  Created by John on 16/1/17.
//  Copyright © 2016年 John. All rights reserved.
//

#import "MPAccount.h"

#define MPAccessTokenKey @"access_token"
#define MPExpiresInKey @"expires_in"
#define MPExpiresTimeKey @"expires_time"
#define MPUidKey @"uid"
#define MPNameKey @"name"

@implementation MPAccount

+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    MPAccount *account = [[self alloc] init];
    
    account.expires_in = dict[MPExpiresInKey];
    account.uid = dict[MPUidKey];
    account.access_token = dict[MPAccessTokenKey];
    
    
    return account;
}

- (void)setExpires_in:(NSString *)expires_in
{
    _expires_in = expires_in;
    
    NSDate *date = [NSDate date];
    _expires_time = [date dateByAddingTimeInterval:[expires_in longLongValue]];
    
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_access_token forKey:MPAccessTokenKey];
    [aCoder encodeObject:_expires_in forKey:MPExpiresInKey];
    [aCoder encodeObject:_expires_time forKey:MPExpiresTimeKey];
    [aCoder encodeObject:_uid forKey:MPUidKey];
    [aCoder encodeObject:_name forKey:MPNameKey];
    
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        
        _access_token = [aDecoder decodeObjectForKey:MPAccessTokenKey];
        _expires_time = [aDecoder decodeObjectForKey:MPExpiresTimeKey];
        _expires_in = [aDecoder decodeObjectForKey:MPExpiresInKey];
        _uid = [aDecoder decodeObjectForKey:MPUidKey];
        _name = [aDecoder decodeObjectForKey:MPNameKey];
        
    }
    
    return self;
}

@end

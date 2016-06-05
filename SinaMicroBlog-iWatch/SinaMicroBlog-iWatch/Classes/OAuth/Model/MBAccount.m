//
//  MBAccount.m
//  SinaMicroBlog-iWatch
//
//  Created by XingPengfei on 1/6/16.
//  Copyright © 2016 Pengfei Xing. All rights reserved.
//

#import "MBAccount.h"

#define XPFAccountTokenKey @"token"
#define XPFUidKey @"uid"
#define XPFExpires_inKey @"expires_in"
#define XPFExpires_dateKey @"expires_date"

@class MBAccount;
@implementation MBAccount

- (void)setExpires_in:(NSString *)expires_in{
    _expires_in = expires_in;
    _expires_date = [NSDate dateWithTimeIntervalSinceNow:[expires_in longLongValue]];
}

+ (instancetype)accountWithDict:(NSDictionary *)dic{
    MBAccount *account = [[self alloc] init];
    [account setValuesForKeysWithDictionary:dic];
    return account;
}

+ (NSDictionary *)dicWithAccount:(MBAccount *)account{
//    NSDictionary *dic = [[NSDictionary alloc] init];
//    dic = @{@"access_token": account.access_token,
//            @"expires_in" : account.expires_date,
//            @"remind_in" : account.remind_in,
//            @"uid" : account.uid,
//            @"expires_date" : account.expires_date};
    NSDictionary *dic = @{@"access_token": account.access_token != nil ? account.access_token : @"",
                          @"expires_in" : account.expires_in != nil ? account.expires_in : @"",
                          @"remind_in" : account.remind_in != nil ? account.remind_in : @"",
                          @"uid" : account.uid != nil ? account.uid : @"",
                          @"expires_date" : account.expires_date != nil ? account.expires_date : [NSDate date]};
    
    return dic;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_access_token forKey:XPFAccountTokenKey];
    [aCoder encodeObject:_uid forKey:XPFUidKey];
    [aCoder encodeObject:_expires_in forKey:XPFExpires_inKey];
    [aCoder encodeObject:_expires_date forKey:XPFExpires_dateKey];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        _access_token = [aDecoder decodeObjectForKey:XPFAccountTokenKey];
        _uid = [aDecoder decodeObjectForKey:XPFUidKey];
        _expires_in = [aDecoder decodeObjectForKey:XPFExpires_inKey];
        _expires_date = [aDecoder decodeObjectForKey:XPFExpires_dateKey];
    }
    return self;
}


@end

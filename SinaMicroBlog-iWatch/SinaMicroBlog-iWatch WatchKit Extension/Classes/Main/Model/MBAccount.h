//
//  MBAccount.h
//  SinaMicroBlog-iWatch
//
//  Created by XingPengfei on 1/6/16.
//  Copyright © 2016 Pengfei Xing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBAccount : NSObject

@property (nonatomic, copy) NSString *access_token;
@property (nonatomic, copy) NSString *expires_in;
@property (nonatomic, copy) NSString *remind_in;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, strong) NSDate *expires_date;

+ (instancetype)accountWithDict:(NSDictionary *)dic;

@end

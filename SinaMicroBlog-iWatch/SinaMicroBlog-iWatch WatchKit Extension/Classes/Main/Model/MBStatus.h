//
//  MBStatus.h
//  SinaMicroBlog-iWatch
//
//  Created by XingPengfei on 1/6/16.
//  Copyright © 2016 Pengfei Xing. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MBUser, MBStatus;
@interface MBStatus : NSObject

@property (nonatomic, strong) MBUser *user;

@property (nonatomic, strong) MBStatus *retweeted_status;

@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy) NSString *idstr;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *source;

@property (nonatomic, assign) int reposts_count;
@property (nonatomic, assign) int comments_count;
@property (nonatomic, assign) int attitudes_count;

@property (nonatomic, strong) NSArray *pic_urls;


@end

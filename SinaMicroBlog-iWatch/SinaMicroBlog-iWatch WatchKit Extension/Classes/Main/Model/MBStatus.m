//
//  MBStatus.m
//  SinaMicroBlog-iWatch
//
//  Created by XingPengfei on 1/6/16.
//  Copyright © 2016 Pengfei Xing. All rights reserved.
//

#import "MBStatus.h"
#import "MBPhoto.h"
#import "MJExtension.h"

@implementation MBStatus

+ (NSDictionary *)objectClassInArray{
    return @{@"pic_urls":[MBPhoto class]};
}


@end

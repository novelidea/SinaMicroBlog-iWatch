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
#import "NSDate+MJ.h"

@implementation MBStatus

+ (NSDictionary *)objectClassInArray{
    return @{@"pic_urls":[MBPhoto class]};
}


- (NSString *)created_at
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM d HH:mm:ss Z yyyy";
    NSDate *created_at = [fmt dateFromString:_created_at];
    
    if ([created_at isThisYear]) {
        if ([created_at isToday]) {
            NSDateComponents *cmp = [created_at deltaWithNow];
            if (cmp.hour >= 1) {
                return [NSString stringWithFormat:@"%ld小时之前",(long)cmp.hour];
            }else if (cmp.minute > 1){
                return [NSString stringWithFormat:@"%ld分钟之前",(long)cmp.minute];
            }else{
                return @"刚刚";
            }
        }else if ([created_at isYesterday]){
            fmt.dateFormat = @"昨天 HH:mm";
            return  [fmt stringFromDate:created_at];
        }else{
            fmt.dateFormat = @"MM-dd HH:mm";
            return  [fmt stringFromDate:created_at];
        }
    }else{
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:created_at];
    }
    return _created_at;
}


@end

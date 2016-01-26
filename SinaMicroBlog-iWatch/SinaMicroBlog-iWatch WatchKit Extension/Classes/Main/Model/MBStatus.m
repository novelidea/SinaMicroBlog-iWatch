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
    // Tue Mar 10 17:32:22 +0800 2015
    // 字符串转换NSDate
//    _created_at = @"Tue Mar 11 17:48:24 +0800 2015";
    //NSLog(@"%@",_created_at);
    
    // 日期格式字符串
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM d HH:mm:ss Z yyyy";
    NSDate *created_at = [fmt dateFromString:_created_at];
    
    if ([created_at isThisYear]) { // 今年
        
        if ([created_at isToday]) { // 今天
            
            // 计算跟当前时间差距
            NSDateComponents *cmp = [created_at deltaWithNow];
            
//            NSLog(@"%ld--%ld--%ld",(long)cmp.hour,(long)cmp.minute,(long)cmp.second);
            
            if (cmp.hour >= 1) {
                return [NSString stringWithFormat:@"%ld小时之前",(long)cmp.hour];
            }else if (cmp.minute > 1){
                return [NSString stringWithFormat:@"%ld分钟之前",(long)cmp.minute];
            }else{
                return @"刚刚";
            }
            
        }else if ([created_at isYesterday]){ // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return  [fmt stringFromDate:created_at];
            
        }else{ // 前天
            fmt.dateFormat = @"MM-dd HH:mm";
            return  [fmt stringFromDate:created_at];
        }
        
        
        
    }else{ // 不是今年
        
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        
        return [fmt stringFromDate:created_at];
        
    }
    
    
    
    
    return _created_at;
}


@end

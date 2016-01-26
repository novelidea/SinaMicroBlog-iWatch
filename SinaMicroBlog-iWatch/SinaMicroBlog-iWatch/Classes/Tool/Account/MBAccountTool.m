//
//  MBAccountTool.m
//  SinaMicroBlog-iWatch
//
//  Created by XingPengfei on 1/6/16.
//  Copyright © 2016 Pengfei Xing. All rights reserved.
//

#import "MBAccountTool.h"
#import "MBAccount.h"

#define MBAccountFileName [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingString:@"/account.data"]



@implementation MBAccountTool

static MBAccount *_account;

+ (void)saveAccount:(MBAccount *)account{
    [NSKeyedArchiver archiveRootObject:account toFile:MBAccountFileName];
}

+ (MBAccount *)account{
    if (nil == _account) {
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:MBAccountFileName];
        if ([[NSDate date] compare:_account.expires_date] != NSOrderedAscending) {
            return nil;
        }
    }
    return _account;
}

@end



//
//  MBWKAccountTool.m
//  SinaMicroBlog-iWatch
//
//  Created by XingPengfei on 1/14/16.
//  Copyright © 2016 Pengfei Xing. All rights reserved.
//

#import "MBWKAccountTool.h"
#import "MBAccount.h"

#define MBWKAccountFileName [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingString:@"/wkaccount.data"]

@implementation MBWKAccountTool

static MBAccount *_account;

+ (void)saveAccount:(MBAccount *)account{
    [NSKeyedArchiver archiveRootObject:account toFile:MBWKAccountFileName];
    NSLog(@"%@",MBWKAccountFileName);
    NSString* fileContents =[NSString stringWithContentsOfFile:MBWKAccountFileName encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"file content is: %@", fileContents);
}

+ (MBAccount *)account{
    if (nil == _account) {
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:MBWKAccountFileName];
        if ([[NSDate date] compare:_account.expires_date] != NSOrderedAscending) {
            return nil;
        }
    }
    return _account;
}


@end

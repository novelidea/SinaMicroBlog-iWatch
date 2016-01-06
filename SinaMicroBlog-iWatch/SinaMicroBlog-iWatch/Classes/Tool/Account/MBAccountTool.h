//
//  MBAccountTool.h
//  SinaMicroBlog-iWatch
//
//  Created by XingPengfei on 1/6/16.
//  Copyright © 2016 Pengfei Xing. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MBAccount;
@interface MBAccountTool : NSObject

+ (void)saveAccount:(MBAccount *)account;
+ (MBAccount *)account;


@end

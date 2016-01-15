//
//  MBWKAccountTool.h
//  SinaMicroBlog-iWatch
//
//  Created by XingPengfei on 1/14/16.
//  Copyright © 2016 Pengfei Xing. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MBAccount;
@interface MBWKAccountTool : NSObject

+ (void)saveAccount:(MBAccount *)account;
+ (MBAccount *)account;

@end

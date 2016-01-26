//
//  MBTransformInfo.h
//  SinaMicroBlog-iWatch
//
//  Created by XingPengfei on 1/15/16.
//  Copyright © 2016 Pengfei Xing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBAccount.h"

@interface MBTransformInfo : NSObject

- (void)initialize;
- (void)transferAccount:(MBAccount *)account;

@end

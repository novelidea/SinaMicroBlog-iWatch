//
//  MBRootTool.m
//  SinaMicroBlog-iWatch
//
//  Created by XingPengfei on 1/6/16.
//  Copyright © 2016 Pengfei Xing. All rights reserved.
//

#import "MBRootTool.h"
#import "MBMainViewController.h"

@implementation MBRootTool

+ (void)chooseRootViewController:(UIWindow *)window{
    MBMainViewController *mainVC = [[MBMainViewController alloc] init];
    window.rootViewController = mainVC;
}


@end

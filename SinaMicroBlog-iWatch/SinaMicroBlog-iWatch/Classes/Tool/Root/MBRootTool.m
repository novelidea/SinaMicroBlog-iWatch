//
//  MBRootTool.m
//  SinaMicroBlog-iWatch
//
//  Created by XingPengfei on 1/6/16.
//  Copyright © 2016 Pengfei Xing. All rights reserved.
//

#import "MBRootTool.h"
#import "MBMainViewController.h"
#import "MBNewFeatureController.h"

#define MBVersionKey @"version"

@implementation MBRootTool


+ (void)chooseRootViewController:(UIWindow *)window{
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:MBVersionKey];
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    
    if ([lastVersion isEqualToString:currentVersion]) {
        MBMainViewController *mainVC = [[MBMainViewController alloc] init];
        window.rootViewController = mainVC;
    }else{
        MBNewFeatureController *newFeature = [[MBNewFeatureController alloc] init];
        window.rootViewController = newFeature;
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:MBVersionKey];
    }
}


@end

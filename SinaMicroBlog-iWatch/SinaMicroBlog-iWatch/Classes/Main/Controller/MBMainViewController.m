//
//  MBMainViewController.m
//  SinaMicroBlog-iWatch
//
//  Created by XingPengfei on 1/6/16.
//  Copyright © 2016 Pengfei Xing. All rights reserved.
//

#import "MBMainViewController.h"
#import "MBNewFeatureController.h"

#define MBKeyWindow [UIApplication sharedApplication].keyWindow


@interface MBMainViewController ()

@end

@implementation MBMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height / 3, self.view.frame.size.width, 50)];
    label.text = @"请打开Apple Watch开启微博之旅";
    label.font = [UIFont systemFontOfSize:24];
    label.textColor = [UIColor redColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    
    UIButton *newFeatureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [newFeatureBtn setTitle:@"查看新特性" forState:UIControlStateNormal];
    [newFeatureBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [newFeatureBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [newFeatureBtn sizeToFit];
    [newFeatureBtn addTarget:self action:@selector(backToNewFeature) forControlEvents:UIControlEventTouchUpInside];
    newFeatureBtn.center = CGPointMake(self.view.frame.size.width * 0.5, self.view.frame.size.height * 0.9);
    [self.view addSubview:newFeatureBtn];
    
}


- (void)backToNewFeature{
     MBNewFeatureController *nfVC = [[MBNewFeatureController alloc] init];
     MBKeyWindow.rootViewController = nfVC;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

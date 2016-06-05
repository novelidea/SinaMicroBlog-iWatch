//
//  MBNewFeatureCell.m
//  SinaMicroBlog-iWatch
//
//  Created by XingPengfei on 1/7/16.
//  Copyright © 2016 Pengfei Xing. All rights reserved.
//

#import "MBNewFeatureCell.h"
#import "MBMainViewController.h"

#define MBKeyWindow [UIApplication sharedApplication].keyWindow


@interface MBNewFeatureCell()

@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UIButton *startButton;
@end

@implementation MBNewFeatureCell

- (UIButton *)startButton{
    if (nil == _startButton) {
        UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
        [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
        [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
        [startBtn sizeToFit];
        [startBtn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:startBtn];
        _startButton = startBtn;
    }
    return _startButton;
}

- (UIImageView *)imageView{
    if (_imageView == nil) {
        UIImageView *image = [[UIImageView alloc] init];
        _imageView = image;
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
    
    self.startButton.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.8);
}

- (void)setImage:(UIImage *)image{
    _image = image;
    
    self.imageView.image = image;
}


- (void)setIndexPath:(NSIndexPath *)indexPath count:(int)count
{
    if (indexPath.row == count - 1) {
        self.startButton.hidden = NO;
    }else{
        self.startButton.hidden = YES;
    }
}

- (void)start
{
    MBMainViewController *mainVC = [[MBMainViewController alloc] init];
    MBKeyWindow.rootViewController = mainVC;
}




@end

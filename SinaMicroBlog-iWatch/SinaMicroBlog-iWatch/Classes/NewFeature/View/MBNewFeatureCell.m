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
//@property (nonatomic, weak) UIButton *shareButton;

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
    
    // 分享按钮
//    self.shareButton.center = CGPointMake(self.width * 0.5, self.height * 0.8);
    
    
    // 开始按钮
    self.startButton.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.9);
}

- (void)setImage:(UIImage *)image{
    _image = image;
    
    self.imageView.image = image;
}


// 判断当前cell是否是最后一页
- (void)setIndexPath:(NSIndexPath *)indexPath count:(int)count
{
    if (indexPath.row == count - 1) { // 最后一页,显示分享和开始按钮
//        self.shareButton.hidden = NO;
        self.startButton.hidden = NO;
        
        
    }else{ // 非最后一页，隐藏分享和开始按钮
//        self.shareButton.hidden = YES;
        self.startButton.hidden = YES;
    }
}

// 点击开始微博的时候调用
- (void)start
{
    MBMainViewController *mainVC = [[MBMainViewController alloc] init];
    MBKeyWindow.rootViewController = mainVC;
}




@end

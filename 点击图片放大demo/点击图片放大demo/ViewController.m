//
//  ViewController.m
//  点击图片放大demo
//
//  Created by caijiamu on 16/5/30.
//  Copyright © 2016年 cloud.wood-group. All rights reserved.
//

#import "ViewController.h"
#import "SJAvatarBrowser.h"
@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(magnifyImage)];
    
    [self.imageView addGestureRecognizer:tap];
}
- (void)magnifyImage
{
    NSLog(@"局部放大");
    [SJAvatarBrowser showImage:self.imageView];//调用方法
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

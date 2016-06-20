//
//  SJAvatarBrowser.m
//  点击图片放大demo
//
//  Created by caijiamu on 16/5/30.
//  Copyright © 2016年 cloud.wood-group. All rights reserved.
//
#import "SJAvatarBrowser.h"
static CGRect oldframe;
@implementation SJAvatarBrowser
+(void)showImage:(UIImageView *)avatarImageView{
    UIImage *image=avatarImageView.image;
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    oldframe=[avatarImageView convertRect:avatarImageView.bounds toView:window];
    backgroundView.backgroundColor=[UIColor blackColor];
    backgroundView.alpha=0;
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:oldframe];
    imageView.image=image;
    imageView.tag=1;
    
    //拖拽
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panRecognizer:)];
    [backgroundView addGestureRecognizer:panRecognizer];
    
    //捏合
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinch:)];
    [backgroundView addGestureRecognizer:pinch];
    
    //点击手势
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    [backgroundView addGestureRecognizer: tap];
    
    [backgroundView addSubview:imageView];
    [window addSubview:backgroundView];
    
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=CGRectMake(0,([UIScreen mainScreen].bounds.size.height-image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)/2, [UIScreen mainScreen].bounds.size.width, image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width);
        backgroundView.alpha=1;
    } completion:^(BOOL finished) {
        
    }];
}

+(void)pinch:(UIPinchGestureRecognizer *)pinchRecognizer
{
    //获取用户操作（缩放）
//    UIView *backgroundView=pinchRecognizer.view;
    UIImageView *imageView=(UIImageView*)[pinchRecognizer.view viewWithTag:1];
    CGFloat scale = pinchRecognizer.scale;
    imageView.transform = CGAffineTransformScale(imageView.transform, scale, scale);
    pinchRecognizer.scale = 1.0;
    if (pinchRecognizer.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:2 animations:^{
            //            self.redview.transform = CGAffineTransformIdentity;
        }];
    }
}

+(void)panRecognizer:(UIPanGestureRecognizer *)panRecognizer
{
    UIImageView *imageView=(UIImageView*)[panRecognizer.view viewWithTag:1];
    CGPoint point = [panRecognizer translationInView:imageView];
    imageView.transform = CGAffineTransformMakeTranslation(point.x, point.y);
}

+(void)hideImage:(UITapGestureRecognizer*)tap{
    UIView *backgroundView=tap.view;
    UIImageView *imageView=(UIImageView*)[tap.view viewWithTag:1];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=oldframe;
        backgroundView.alpha=0;
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
    }];
}
@end

//
//  UIViewController+Helper.m
//  Lsgo
//
//  Created by Allan.Chan on 8/27/14.
//  Copyright (c) 2014 Allan. All rights reserved.
//

#import "UIViewController+Helper.h"
#import "LoadingView.h"
@implementation UIViewController (Helper)
-(void)showLoading
{
    [[LoadingView shareLoadingView] setLoadingViewAlpha:1.0];
    [[LoadingView shareLoadingView] shareLoadingViewFrame];
    [[LoadingView shareLoadingView] setMessage:@"请稍后.."];
    [self.view addSubview:[LoadingView shareLoadingView]];
}
-(void)showLoadingWithMessage:(NSString *)msg
{
    [[LoadingView shareLoadingView] setLoadingViewAlpha:1.0];
    [[LoadingView shareLoadingView] shareLoadingViewFrame];
    [[LoadingView shareLoadingView] setMessage:msg];
    [self.view addSubview:[LoadingView shareLoadingView]];
}

- (void)showLoadingOnWindow{
    [[LoadingView shareLoadingView] setLoadingViewAlpha:1.0];
    [[LoadingView shareLoadingView] shareLoadingViewFrame];
    [[LoadingView shareLoadingView] setMessage:@"请稍后.."];
    [[UIApplication sharedApplication].keyWindow addSubview:[LoadingView shareLoadingView]];
}

- (void)showLoadingOnWindowWithMsg:(NSString *)msg{
    [[LoadingView shareLoadingView] setLoadingViewAlpha:1.0];
    [[LoadingView shareLoadingView] shareLoadingViewFrame];
    [[LoadingView shareLoadingView] setMessage:msg];
    [[UIApplication sharedApplication].keyWindow addSubview:[LoadingView shareLoadingView]];
}



-(void)removeLoading
{
    [UIView animateWithDuration:0.4 animations:^{
        [[LoadingView shareLoadingView] setLoadingViewAlpha:0.0];
    } completion:^(BOOL finished) {
        [[LoadingView shareLoadingView] removeAll];
    }];
}

-(void)addSwipeBack:(UIViewController *)inputViewController
{
    UISwipeGestureRecognizer *gestureRecognizer  = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeBack:)];
    gestureRecognizer.numberOfTouchesRequired = 1;
    gestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [inputViewController.view addGestureRecognizer:gestureRecognizer];
}

-(void)swipeBack:(UIGestureRecognizer *)guestureRecognizer
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)noDatabackImageView:(NSString *)imageName
{
    UIImageView *nodataImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    [nodataImageView setTag:100000];
    NSLayoutConstraint *POS_H = [NSLayoutConstraint
                                 constraintWithItem:nodataImageView
                                 attribute:NSLayoutAttributeCenterX
                                 relatedBy:NSLayoutRelationEqual
                                 toItem:self.view
                                 attribute:NSLayoutAttributeCenterX
                                 multiplier:1
                                 constant:0];
    
    NSLayoutConstraint *POS_V = [NSLayoutConstraint
                                 constraintWithItem:nodataImageView
                                 attribute:NSLayoutAttributeCenterY
                                 relatedBy:NSLayoutRelationEqual
                                 toItem:self.view
                                 attribute:NSLayoutAttributeCenterY
                                 multiplier:1
                                 constant:0];
    [nodataImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSArray *constraints = @[POS_H,POS_V];
    
    nodataImageView.hidden = YES;
    [self.view addSubview:nodataImageView];
    [self.view addConstraints:constraints];
}

-(void)noDatabackImageViewShow
{
    [(UIImageView *)[self.view viewWithTag:100000] setHidden:FALSE];
}

-(void)noDatabackImageViewHiden
{
    [(UIImageView *)[self.view viewWithTag:100000] setHidden:TRUE];
}
@end

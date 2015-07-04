//
//  UIViewController+Helper.h
//  Lsgo
//
//  Created by Allan.Chan on 8/27/14.
//  Copyright (c) 2014 Allan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface UIViewController (Helper)<UIGestureRecognizerDelegate>

-(void)showLoading;
-(void)removeLoading;
-(void)showLoadingWithMessage:(NSString *)msg;
-(void)addSwipeBack:(UIViewController *)inputViewController;
-(void)noDatabackImageView:(NSString *)imageName
-(void)noDatabackImageViewShow;
-(void)noDatabackImageViewHiden;

@end

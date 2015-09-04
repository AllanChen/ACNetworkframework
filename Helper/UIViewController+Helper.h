//
//  UIViewController+Helper.h
//  Lsgo
//
//  Created by Allan.Chan on 8/27/14.
//  Copyright (c) 2014 Allan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Helper)<UIGestureRecognizerDelegate>

/**
 *  在ViewController 上添加提示
 */
-(void)showLoading;

/**
 *  删除提示
 */
-(void)removeLoading;

/**
 *  在ViewController 添加提示
 *
 *  @param msg 需要提示的信息
 */
-(void)showLoadingWithMessage:(NSString *)msg;

-(void)addSwipeBack:(UIViewController *)inputViewController;
-(void)noDatabackImageView:(NSString *)imageName;
-(void)noDatabackImageViewShow;
-(void)noDatabackImageViewHiden;

/**
 *  在window 上添加提示
 */
- (void)showLoadingOnWindow;

/**
 *  在window 添加提示
 *
 *  @param msg 需要提示的信息
 */
- (void)showLoadingOnWindowWithMsg:(NSString *)msg;

@end

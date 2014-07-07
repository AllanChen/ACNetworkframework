//
//  InterfaceDeletgate.h
//  KnowBaby
//
//  Created by Allan.Chan on 13-4-7.
//  Copyright (c) 2013年 Allan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@protocol InterfaceDelegate <NSObject>
@optional
/*
 |  下载数据
 */
-(void)downloadDataFinish:(NSDictionary *)returnDic;

/*
 |  刷新数据
 */
-(void)refreshDataFinish:(NSDictionary *)returnRefreshDic;

/*
 |  加载更多数据
 */
-(void)loadMoreDataFinish:(NSDictionary *)returnLoadMorelDic;

/*
 |  上传数据
 */
-(void)uploadDataReturnDic:(NSDictionary *)returnDic;
/*
 | 上传数据失败
 */
-(void)uploadDataFail:(NSDictionary *)returnDic andError:(NSError *)error;
/*
 |  上传数据Progress;
 */
-(void)uploadImageProgress:(float)progress;

-(void)interfaceHideMainTabBarView:(BOOL)hideTabBar;

-(void)interfaceHidestopMainScrollView:(BOOL)stopScrollView;
@end

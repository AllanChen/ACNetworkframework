//
//  TableDataHelper.h
//  KnowBaby
//
//  Created by Allan.Chan on 13-4-7.
//  Copyright (c) 2013年 Allan. All rights reserved.
//

#import "InterfaceDelegate.h"
#import <Foundation/Foundation.h>

@interface TableDataHelper : NSObject
@property(retain,nonatomic) id <InterfaceDelegate> interfaceDelegate;

/*
 | 下载数据
 */
-(void)downloadData:(NSString *)downloadURLString andParameter:(NSMutableDictionary *)parameters andMethod:(NSString *)method;

/*
 |  上传数据+图片
 */
-(void)uploadDataAndImage:(NSString *)uploadURLString andImage:(NSData *)imageData andParameters:(NSMutableDictionary *)parameters andImageKeyWord:(NSString *)imageKeyWord andImageFileName:(NSString *)imageName andImageFormat:(NSString *)imageFormat;

@end

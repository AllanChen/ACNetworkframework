//
//  ACNetworkHttpRequestManages.h
//  ACNetworking
//
//  Created by ChanAllan on 11/6/14.
//  Copyright (c) 2014 ChanAllan. All rights reserved.
//


define OPENSSL NO

#import "AFNetworking.h"
#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger , ACRequestMethod) {
    ACRequestMethodGet = 0,
    ACRequestMethodPost,
    ACRequestMethodHead,
    ACRequestMethodPut,
    ACRequestMethodDelete,
};


@interface ACNetworkHttpRequestManages : AFHTTPRequestOperationManager
@property(nonatomic,strong) AFHTTPRequestOperationManager *manager;
@property(nonatomic) NSTimeInterval timeOutInt;



- (void)initHttpRequestManages;



/**
 *  检查网络情况
 *
 *  @param state 返回网络状态
 */
-  (void)networkState:(void (^)(NSString *state))state;


/**
 *  设置过期时间
 *
 *  @param requestTimeOut 过期时间，以秒为单位
 */

- (void)setrequestTimeOut:(NSTimeInterval)requestTimeOut;

/**
 *  设置HTTP Header
 *
 *  @param key   Key For Header
 *  @param value Value For Header
 */

- (void)setHeaderValue:(NSString *)key andValue:(NSString *)value;


/**
 *  设置HTTP Header
 *  以数组的形式传入多个参数
 *  @param key   Keys For Header - -
 *  @param value Values For Header
 */
- (void)setHeaderByArray:(NSArray *)keys andValues:(NSArray *)values;

/**
 *  下载数据接口
 *
 *  @param downloadURLStirng 传入的URL
 *  @param method            传输的方法
 *  @param parameters        传输的参数
 *  @param passParameters    回调的对象
 *  @param success           成功返回的方法
 *  @param failure           失败返回的方法
 */
- (void)download:(NSString *)downloadURLStirng andMethod:(NSInteger)method andParameter:(id)parameters andPassParameters:(id)passParameters success:(void (^)(id returnData, id passParameters))success failure:(void (^)(id returnData , NSError *error ,id passParameters))failure;


- (void)upload:(NSString *)uploadURLString andMethod:(NSInteger)method andParameter:(id)parameters andPassParameters:(id)passParameters andUpladData:(NSData *)uploadData dataForKey:(NSString *)dataKey uploadDatafileName:(NSString *)fileName format:(NSString *)format
       success:(void (^)(id returnData, id passParameters,id progress))success
       failure:(void (^)(id returnData , NSError *error ,id passParameters))failure;

@end

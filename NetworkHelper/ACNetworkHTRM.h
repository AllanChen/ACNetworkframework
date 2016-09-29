//
//  ACNetworkHTRM.h
//  Pods
//
//  Created by it on 6/24/16.
//
//
#import "AFNetworking.h"
#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger , ACRequestMethod) {
    ACRequestMethodGet = 0,
    ACRequestMethodPost,
    ACRequestMethodHead,
    ACRequestMethodPut,
    ACRequestMethodDelete,
};

@interface ACNetworkHTRM:NSObject
@property (nonatomic, strong) NSString *domainName;
@property (nonatomic, strong) NSString *requestURL;
@property (nonatomic, strong) NSDictionary *params;

+ (instancetype)requestInit;

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

- (void)setRequestTimeOut:(AFHTTPRequestSerializer *)manager;

/**
 *  设置HTTP Header
 *
 *  @param key   Key For Header
 *  @param value Value For Header
 */

- (void)setHeaderValue:(AFHTTPRequestSerializer *)manager;


/**
 *  设置HTTP Header
 *  以数组的形式传入多个参数
 *  @param key   Keys For Header - -
 *  @param value Values For Header
 */
- (void)setHeaderByArray:(AFHTTPRequestSerializer *)manager;


/**
 *  构建URL
 */
- (void)setRequestURL;

/**
 *  Map请求参数
 */
- (NSDictionary *)parametersMap;

/**
 *  构建请求参数
 */
- (NSDictionary *)buildParameters;

/**
 *  设置post 参数类型
 *
 */
- (AFJSONRequestSerializer *)setRequestSerializer;


/**
 *  下载数据接口
 *
 *  @param method            传输的方法
 *  @param parameters        传输的参数
 *  @param passParameters    回调的对象
 *  @param success           成功返回的方法
 *  @param failure           失败返回的方法
 */

- (void)downloadMethod:(NSInteger)method andPassParameters:(id)passParameters
               success:(void (^)(id returnData, id passParameters))success
               failure:(void (^)(id returnData , NSError *error ,id passParameters))failure;


- (void)upload:(NSString *)uploadURLString andMethod:(NSInteger)method andParameter:(id)parameters andPassParameters:(id)passParameters andUpladData:(NSData *)uploadData dataForKey:(NSString *)dataKey uploadDatafileName:(NSString *)fileName format:(NSString *)format
       success:(void (^)(id returnData, id passParameters,id progress))success
       failure:(void (^)(id returnData , NSError *error ,id passParameters))failure;

@end

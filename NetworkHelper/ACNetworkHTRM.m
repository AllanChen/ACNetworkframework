//
//  ACNetworkHTRM.m
//  Pods
//
//  Created by it on 6/24/16.
//
//

#import "ACNetworkHTRM.h"

@implementation ACNetworkHTRM
+ (instancetype)requestInit
{
    return [[[self class] alloc] init];
}

- (AFSecurityPolicy *)setupSecurity{
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    [securityPolicy setAllowInvalidCertificates:YES];
    return securityPolicy;
}

- (AFSecurityPolicy*)customSecurityPolicy
{
    /**** SSL Pinning ****/
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"apache2" ofType:@"cer"];
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
    [securityPolicy setAllowInvalidCertificates:NO];
    [securityPolicy setPinnedCertificates:@[certData]];    
    return securityPolicy;
}

- (NSDictionary *)parametersMap
{
    return nil;
}

- (void)setRequestURL{
    
}

- (AFJSONRequestSerializer *)setRequestSerializer{
    return [AFJSONRequestSerializer serializer];
}

- (void)setRequestTimeOut:(AFJSONRequestSerializer *)manager
{
    
}

- (void)setHeaderValue:(AFJSONRequestSerializer *)manager
{
    
}

- (void)setHeaderByArray:(AFJSONRequestSerializer *)manager
{
    
}

- (void)downloadMethod:(NSInteger)method
     andPassParameters:(id)passParameters
         success:(void (^)(id returnData, id passParameters))success
         failure:(void (^)(id returnData , NSError *error ,id passParameters))failure{
    
    [self setRequestURL];
    self.params = [self parametersMap];
    NSString *path = [self.requestURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [self setRequestSerializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
    if (method == ACRequestMethodGet)
    {
        [manager GET:path parameters:self.params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if(success)
            success(responseObject,passParameters);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if(failure)
             failure(task,error,passParameters);
        }];
    }
    
    if (method == ACRequestMethodPost)
    {
        [manager POST:path parameters:self.params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if(success)
            success(responseObject,passParameters);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if(failure)
            failure(task,error,passParameters);
        }];
    }
    
    if (method == ACRequestMethodPut)
    {

        [manager PUT:path parameters:self.params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if(success)
            success(responseObject,passParameters);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if(failure)
            failure(task,error,passParameters);
        }];
    }
    
    if (method == ACRequestMethodDelete)
    {
        [manager DELETE:path parameters:self.params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if(success)
            success(responseObject,passParameters);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if(failure)
            failure(task,error,passParameters);
        }];
    }
}

- (void)upload:(NSString *)uploadURLString
     andMethod:(NSInteger)method
  andParameter:(id)parameters
andPassParameters:(id)passParameters
  andUpladData:(NSData *)uploadData
    dataForKey:(NSString *)dataKey
uploadDatafileName:(NSString *)fileName
        format:(NSString *)format
       success:(void (^)(id returnData, id passParameters,id progress))success
       failure:(void (^)(id returnData , NSError *error ,id passParameters))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
    if(method == ACRequestMethodPost)
    {
        [manager POST:uploadURLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithFileData:uploadData name:dataKey fileName:fileName mimeType:format];
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            success(responseObject,passParameters,nil);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(task,error,passParameters);
        }];
        
    }
}


- (void)networkState:(void (^)(NSString *))state{
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                state(@"No Network");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                state(@"wifi");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                state(@"3g");
                break;
            default:
                state(@"No Network");
                break;
        }
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}


@end


//
//  ACNetworkHttpRequestManages.m
//  ACNetworking
//
//  Created by ChanAllan on 11/6/14.
//  Copyright (c) 2014 ChanAllan. All rights reserved.
//

#import "ACNetworkHttpRequestManages.h"
#import "AFSecurityPolicy.h"

@implementation ACNetworkHttpRequestManages
@synthesize manager;
@synthesize timeOutInt;

- (void)initHttpRequestManages{
    self.manager = [[AFHTTPRequestOperationManager alloc] init];
    self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
    if (OPENSSL) {
        self.manager.securityPolicy = [self setupSecurity];
    }
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
    //[securityPolicy setSSLPinningMode:AFSSLPinningModeCertificate];
    /**** SSL Pinning ****/
    
    return securityPolicy;
}

- (NSDictionary *)parametersMap
{
    return nil;
}

- (void)setRequestURL{

}

- (NSDictionary *)buildParameters
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSDictionary *maps = [self parametersMap];
    for (NSString *key in maps.allKeys) {
        id val = [self valueForKey:key];
        if (val) {
            [params setObject:val forKey:maps[key]];
        }
    }
    return [NSDictionary dictionaryWithDictionary:params];
}

- (void)download:(NSString *)downloadURLStirng
       andMethod:(NSInteger)method
    andParameter:(id)parameters
andPassParameters:(id)passParameters
         success:(void (^)(id returnData, id passParameters))success
         failure:(void (^)(id returnData , NSError *error ,id passParameters))failure{
    self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSString *path = [self.path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
    
    if (method == ACRequestMethodGet)
    {
        [self.manager GET:path parameters:self.params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (success)
                success(responseObject,passParameters);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (failure)
                failure(operation.responseObject,error,passParameters);
        }];
    }
    
    if (method == ACRequestMethodPost)
    {
        [self.manager POST:path parameters:self.params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (success)
                success(responseObject,passParameters);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if(failure)
                failure(operation.responseObject,error,passParameters);
        }];
    }
    
    if (method == ACRequestMethodPut)
    {
        [self.manager PUT:path parameters:self.params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (success)
                success(responseObject,passParameters);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if(failure)
                failure(operation.responseObject,error,passParameters);
        }];
    }
    
    if (method == ACRequestMethodDelete)
    {
        [self.manager DELETE:path parameters:self.params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (success)
                success(responseObject,passParameters);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if(failure)
                failure(operation.responseObject,error,passParameters);
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
    if(method == ACRequestMethodPost)
    {
        //NSData *imageData = UIImageJPEGRepresentation(self.avatarView.image, 0.5);
        AFHTTPRequestOperation *op = [manager POST:uploadURLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            [formData appendPartWithFileData:uploadData name:dataKey fileName:fileName mimeType:format];
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //NSLog(@"Success: %@ ***** %@", operation.responseString, responseObject);
            success(responseObject,passParameters,operation.responseString);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //NSLog(@"Error: %@ ***** %@", operation.responseString, error);
            failure(operation.responseObject,error,passParameters);
        }];
        [op start];
        
    }
}

- (void)setrequestTimeOut:(NSTimeInterval)requestTimeOut{
    [self.manager.requestSerializer setTimeoutInterval:requestTimeOut];
}

- (void)setHeaderValue:(NSString *)key andValue:(NSString *)value{
    [self.manager.requestSerializer setValue:value forHTTPHeaderField:key];
}

- (void)setHeaderByArray:(NSArray *)keys andValues:(NSArray *)values{
    for (int i=0; i<keys.count; i++)
    {
        [self.manager.requestSerializer setValue:[values objectAtIndex:i] forKey:[keys objectAtIndex:i]];
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

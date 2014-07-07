//
//  TableDataHelper.m
//  KnowBaby
//
//  Created by Allan.Chan on 13-4-7.
//  Copyright (c) 2013年 Allan. All rights reserved.
//

#import "TableDataHelper.h"
#import "LoadingView.h"
#import "Utility.h"
#import "AFNetworking.h"

@implementation TableDataHelper

/*
 |  下载数据
 */

-(void)downloadData:(NSString *)downloadURLString andParameter:(NSMutableDictionary *)parameters andMethod:(NSString *)method
{
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setRequestSerializer:[AFHTTPRequestSerializer serializer]];
    NSString *authHeader = [[NSString alloc] initWithFormat:@"Bearer %@",[userInfo objectForKey:@"token"]];
    [manager.requestSerializer setValue:authHeader forHTTPHeaderField:@"authorization"];
    
    if ([method isEqualToString:@"GET"]){
        [manager GET:downloadURLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self.interfaceDelegate uploadDataReturnDic:responseObject];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [[LoadingView shareLoadingView] removeAll];
            [self.interfaceDelegate uploadDataReturnDic:[operation responseObject]];
        }];
    }
    else if ([method isEqualToString:@"POST"])
    {
        [manager POST:downloadURLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self.interfaceDelegate uploadDataReturnDic:responseObject];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [[LoadingView shareLoadingView] removeAll];
            [self.interfaceDelegate uploadDataReturnDic:[operation responseObject]];
        }];
    }
    else if([method isEqualToString:@"DELETE"])
    {
        [manager DELETE:downloadURLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.interfaceDelegate uploadDataReturnDic:responseObject];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [[LoadingView shareLoadingView] removeAll];
            [self.interfaceDelegate uploadDataReturnDic:[operation responseObject]];
        }];
    }
    
    else if ([method isEqualToString:@"PUT"])
    {
        [manager PUT:downloadURLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self.interfaceDelegate uploadDataReturnDic:responseObject];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [[LoadingView shareLoadingView] removeAll];
            [self.interfaceDelegate uploadDataReturnDic:[operation responseObject]];
        }];
    }

    
}



-(void)uploadDataAndImage:(NSString *)uploadURLString andImage:(NSData *)imageData andParameters:(NSMutableDictionary *)parameters andImageKeyWord:(NSString *)imageKeyWord andImageFileName:(NSString *)imageName andImageFormat:(NSString *)imageFormat
{
 
    /*
     | 上传数据
     */
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:uploadURLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.interfaceDelegate uploadDataReturnDic:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[LoadingView shareLoadingView] removeAll];
    }];
    
  
    /*
     |  上传图片数据
     */
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:uploadURLString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData name:imageKeyWord fileName:imageName mimeType:imageFormat];
    } error:nil];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        float progress = totalBytesWritten / (float)totalBytesExpectedToWrite;
        [self.interfaceDelegate uploadImageProgress:progress];
    }];
    [operation start];
}




@end

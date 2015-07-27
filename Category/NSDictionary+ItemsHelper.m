//
//  NSDictionary+ItemsHelper.m
//  BaiMiTest
//
//  Created by ChanAllan on 7/22/15.
//  Copyright (c) 2015 ChanAllan. All rights reserved.
//

#import "NSDictionary+ItemsHelper.h"

@implementation NSDictionary (ItemsHelper)

-(NSString *)dicToJsonString:(id)inputDic
{
    NSString *jsonString;
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:inputDic
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if ([jsonData length] > 0 && error == nil)
        return  jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    else
        return @"{\"error\":\"null\"}";
}
@end

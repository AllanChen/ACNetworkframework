//
//  NSArray+ItemsHelper.m
//  BaiMiTest
//
//  Created by ChanAllan on 7/22/15.
//  Copyright (c) 2015 ChanAllan. All rights reserved.
//

#import "NSArray+ItemsHelper.h"

@implementation NSArray (ItemsHelper)

- (NSString *)arrayToJsonString:(id)inputArray
{
    NSString *jsonString;
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:inputArray
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if ([jsonData length] > 0 && error == nil)
    {
        return  jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];;
    }
    
    else
    {
        return @"{\"error\":\"null\"}";
    }
}

- (NSInteger)countItemInArray:(NSArray *)inputArray andInputString :(NSString *)inputString{
    int occurrenes = 0;
    for (NSString *string in inputArray)
    {
        occurrenes += ([string isEqualToString:inputString]);
    }
    return occurrenes;
}

- (NSMutableArray *)uniqueSameItem:(NSArray*)inputArray
{
    NSMutableArray *combination = [[NSMutableArray alloc] init];
    for (id obj in inputArray)
    {
        if (![combination containsObject:obj])
        {
            [combination addObject: obj];
        }
    }
    return combination;
}

@end

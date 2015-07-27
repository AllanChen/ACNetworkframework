//
//  NSDictionary+ItemsHelper.h
//  BaiMiTest
//
//  Created by ChanAllan on 7/22/15.
//  Copyright (c) 2015 ChanAllan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (ItemsHelper)

/*
 | 把字典转化成Json
 */
-(NSString *)dicToJsonString:(id)inputDic;
@end

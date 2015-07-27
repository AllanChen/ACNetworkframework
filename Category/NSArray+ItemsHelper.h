//
//  NSArray+ItemsHelper.h
//  BaiMiTest
//
//  Created by ChanAllan on 7/22/15.
//  Copyright (c) 2015 ChanAllan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (ItemsHelper)

/**
 *  把数组变成JSON
 *
 *  @param inputArray 目标数组
 *
 *  @return JSON字符串
 */
-(NSString *)arrayToJsonString:(id)inputArray;

/**
 *  统计某个Item在数组里面出现的次数
 *
 *  @param inputArray  目标数组
 *  @param inputString 目标Item
 *
 *  @return 返回出现次数
 */
- (NSInteger)countItemInArray:(NSArray *)inputArray andInputString :(NSString *)inputString;

/**
 *  去掉数组里重复的字符
 *
 *  @param inputArray 目标数组
 *
 *  @return 过滤后的数组
 */
- (NSMutableArray *)uniqueSameItem:(NSArray*)inputArray;
@end

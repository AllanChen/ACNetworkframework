//
//  UnixTimeUtility.h
//  KnowBaby
//
//  Created by Allan.Chan on 13-4-25.
//  Copyright (c) 2013年 Allan. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface UnixTimeUtility : NSObject
+(float)nowUnixTime;
+(NSString *)getNowTime;
+(NSString *)transformUnixTime:(double)time;
+(NSString *)transformUnixTimeHoursAndMin:(double)time;

/*
 | bosim 比较当前月和指定月的差值
 */
+(int)compareDateValue:(NSString *) oneDay withAnotherDay:(NSString *)anotherDay;

/*
 | 比较两个时间，返回时间的差值
 | 差值直接是变成字符传
 */
+ (NSString *)compareDateValueHms:(NSDate *)oneDate withAnotherDay:(NSDate *)anotherDate;

+ (NSString *)twoDigit:(int)digit;

+ (int)calculateAgeFromDate:(NSDate *)oneDay toDate:(NSDate *)anotherDay;

+ (NSDate *)dateFromString:(NSString *)dateString;

+ (NSString *)stringFromDate:(NSDate *)date;

@end

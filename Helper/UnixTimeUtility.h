//
//  UnixTimeUtility.h
//  KnowBaby
//
//  Created by Allan.Chan on 13-4-25.
//  Copyright (c) 2013年 Allan. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface UnixTimeUtility : NSObject
/**
 *  获取当前时间
 *
 *  @return 返回UnixTime
 */
+ (float)nowUnixTime;

+ (NSString *)getNowTime;

+ (NSString *)transformUnixTimeHoursAndMin:(double)time;

+ (NSString *)transformUnixTime:(double)time andTimeFormat:(NSString *)timeFromat;
/*
 | bosim 比较当前月和指定月的差值
 */
+ (int)compareDateValue:(NSString *) oneDay withAnotherDay:(NSString *)anotherDay;

/*
 | 比较两个时间，返回时间的差值
 | 差值直接是变成字符传
 */
+ (NSString *)compareDateValueHms:(NSDate *)oneDate withAnotherDay:(NSDate *)anotherDate;

+ (NSString *)twoDigit:(int)digit;

+ (int)calculateAgeFromDate:(NSDate *)oneDay toDate:(NSDate *)anotherDay;

+ (NSDate *)dateFromString:(NSString *)dateString;

+ (NSString *)stringFromDate:(NSDate *)date;

/**
 *  返回时分秒正确格式
 *
 *  @param totalSeconds 总秒数
 *  @param returnType   返回类型，1:只返回秒 2：返回分，秒 3：返回时分秒
 *
 *  @return 返回时分秒格式
 */
+ (NSString *)timeFormatted:(int)totalSeconds andReturnType:(int)returnType;

@end

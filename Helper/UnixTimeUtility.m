//
//  UnixTimeUtility.m
//  KnowBaby
//
//  Created by Allan.Chan on 13-4-25.
//  Copyright (c) 2013年 Allan. All rights reserved.
//

#import "UnixTimeUtility.h"
static NSDateFormatter *dateFormtter;
@implementation UnixTimeUtility

+ (float)nowUnixTime
{
    NSTimeInterval nowTimeUnix=[[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970]*1000;
    return  nowTimeUnix;
}

+ (NSString *)getNowTime
{
    NSString *timeFormtter;
    if (!dateFormtter)
    {
        dateFormtter = [[NSDateFormatter alloc] init];
    }
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [dateFormtter setTimeZone:timeZone];
    [dateFormtter setDateFormat:@"yyyy,MM,dd,HH,mm,ss"];
    timeFormtter = [dateFormtter stringFromDate:[NSDate date]];
    return timeFormtter;
}

/*
 |  UnixTime 时间转换
 */
+ (NSString *)transformUnixTime:(double)time andTimeFormat:(NSString *)timeFromat
{
    NSTimeInterval _interval = time;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *_formatter = [[NSDateFormatter alloc]init];
    [_formatter setLocale:[NSLocale currentLocale]];
    [_formatter setDateFormat:timeFromat];
    NSString *dateString = [_formatter stringFromDate:date];
    return dateString;
}

+ (NSString *)transformUnixTimeHoursAndMin:(double)time
{
    NSTimeInterval _interval = time;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *_formatter = [[NSDateFormatter alloc]init];
    [_formatter setLocale:[NSLocale currentLocale]];
    [_formatter setDateFormat:@"H:m"];
    NSString *dateString = [_formatter stringFromDate:date];
    return dateString;
}

+ (int)compareDateValue:(NSString *) oneDay withAnotherDay:(NSString *)anotherDay
{
    int result = [oneDay intValue] - [anotherDay intValue];
    if (result < 0 )
    {
        result = result + 12;
        return result;
    }
    else
    {
        return result;
    }
}

+ (NSString *)compareDateValueHms:(NSDate *)oneDate withAnotherDay:(NSDate *)anotherDate
{
    NSTimeInterval time=[anotherDate timeIntervalSinceDate:oneDate];
    
    int secondResult = ((int)time)%(3600*24);

    int minResult = ((int)time)%(3600*24)/60;
    
    int hoursResult = ((int)time)%(3600*24)/3600;
    
    [[self class] twoDigit:abs(hoursResult)];
    NSString *result = [[NSString alloc] initWithFormat:@"%@:%@:%@", [[self class] twoDigit:abs(hoursResult)], [[self class] twoDigit:abs(minResult)], [[self class] twoDigit:abs(secondResult)]];
    return result;
}

+ (NSString *)twoDigit:(int)digit
{
    if (digit >=0 && digit < 10) {
        return [NSString stringWithFormat:@"0%d", digit];
    } else {
        return [NSString stringWithFormat:@"%d", digit];
    }
}

+ (int)calculateAgeFromDate:(NSDate *)oneDay toDate:(NSDate *)anotherDay
{
    NSTimeInterval second = [anotherDay timeIntervalSinceDate:oneDay];
    return abs(second);
}

+ (NSDate *)dateFromString:(NSString *)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date= [dateFormatter dateFromString:dateString];
    
    return date;
    
}

+ (NSString *)stringFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

+ (NSString *)timeFormatted:(int)totalSeconds andReturnType:(int)returnType {
    
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    int hours = totalSeconds / 3600;
    switch (returnType) {
        case 1:
                return [NSString stringWithFormat:@"%02d",seconds];
            break;
        
            case 2:
                return [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
            break;
            
        default:
                return [NSString stringWithFormat:@"%02d:%02d:%02d",hours, minutes, seconds];
            break;
    }
    

}

@end

//
//  UtilityHelper.h
//  Po
//
//  Created by Allan.Chan on 7/23/14.
//  Copyright (c) 2014 Allan.Chan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UtilityHelper : UIViewController
/*
 | 颜色转换
 */
+(UIColor *)colorWithHexString:(NSString*)hex;
/*
 | MD5 加密
 */
+(NSString *)md5:(NSString *)inputString;

+(void)showAlertView:(NSString *)alertViewTitle andMessage:(NSString *)alertMessage andCancelBtnTitle:(NSString *)cancelBtnTitle;

/*
 | 转换成字符串
 */
+(NSString *)convertToString:(id)inputData;
/*
 |  邮箱认证
 */
+(BOOL)isValidateEmail:(NSString *)email;
/*
 | URL uncode
 */
+ (NSString*)encodeURL:(NSString *)string;

/*
 | 快递验证
 */
+(BOOL)isExpress:(NSString *)expressString;

/*
 |  过滤HTML标签
 */
+ (NSString *)flattenHTML:(NSString *)html;

/*
 |  统计数组item出现的次数
 */

+(NSInteger)countArrayItemSum:(NSArray *)inputArray andInputString :(NSString *)inputString;

/*
 | 转换并压缩图片
 */
+(NSData *)coverImageToNSData:(UIImage *)lagerImage andOutputFromat:(NSString *)fromat;

/*
 |  将字典转化成JSON字符串
 */
+(NSString *)convertDicToJsonString :(NSMutableDictionary *)inputDic;


/*
 |  将图片旋转
 */
+(UIImage *)scaleAndRotateImage:(UIImage *)image;

/*
 | 图片圆角
 */
+(id)cutTheImageViewRadius:(id)inputImageView;


/*
 |  过滤空白字符
 */
+(NSString *)trimString:(NSString *)inputString;

/*
 |  过滤双引号和单引号
 */
+(NSString *)trimDoubleQuotesAndSiglelQuotes:(NSString *)filterString andInputString:(NSString *)inputString;

/*
 |  转义表情To Server
 */
+(NSString *)emotionString:(NSString *)inputEmotionString;

/*
 | 转义表情To LocalTB
 */
+(NSString *)emotionDataEncode:(NSString *)inputEmotionString;

+ (BOOL)stringContainsEmoji:(NSString *)string;

+(void)shakeAnimation:(UIView *)shakeView;


/*
 |  获取当前时间
 */
+(NSString *)getCurrentTime;

+(NSString *)getFloder:(NSString *)folderName;


@end

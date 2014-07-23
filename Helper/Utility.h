//
//  Utility.h
//  JueWeiShop
//
//  Created by 永坚 陈 on 12-12-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utility : NSObject
/*
 | 颜色转换
 */
+(UIColor*)colorWithHexString:(NSString*)hex;
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
 |  过滤HTML标签
 */
+ (NSString *)flattenHTML:(NSString *)html;

/*
 |  统计数组item出现的次数
 */

+(NSInteger)countArrayItemSum:(NSArray *)inputArray andInputString :(NSString *)inputString;

/*
 |  消除数组里面重复的item
 */
+(NSMutableArray *)uniqueSameItem:(NSArray*)inputArray;


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
 | 换行Lable
 */
+(UILabel *)returnMultiLineLab:(NSString *)inputString andStringFrame:(CGSize)inputStringSize andLabFrame:(CGRect)inputmultiLineLab andFontSize:(float)fontsize;

/*
 |  过滤字符
 */
+(NSString *)trimString:(NSString *)inputString;
@end

//
//  UtilityHelper.m
//  Po
//
//  Created by Allan.Chan on 7/23/14.
//  Copyright (c) 2014 Allan.Chan. All rights reserved.
//

#import "UtilityHelper.h"
#import <CommonCrypto/CommonDigest.h>
@interface UtilityHelper ()

@end

@implementation UtilityHelper
+(void)showAlertView:(NSString *)alertViewTitle andMessage:(NSString *)alertMessage andCancelBtnTitle:(NSString *)cancelBtnTitle;
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:alertViewTitle message:alertMessage delegate:self cancelButtonTitle:cancelBtnTitle otherButtonTitles:nil, nil];
    alertView.delegate = self;

    [alertView show];
    
}

+ (NSString*)encodeURL:(NSString *)string
{
    NSString *newString = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)string, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    if (newString)
    {
        return newString;
    }
    
    return @"";
}

/*
 |颜色转化
 */
+(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)  blue:((float) b / 255.0f)
                           alpha:1.0f];
}

+(NSString *)md5:(NSString *)inputString
{
    const char *cStr = [inputString UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] uppercaseString];
}



+(BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


+(BOOL)isExpress:(NSString *)expressString
{
    NSString *expressRegex = @"[0-9]{7,15}|[A-Z]{2}[0-9]{9}[A-Z]{2}|1Z[A-Z0-9]{16}|[A-Z][0-9]{7,15}|[A-Z]{2}[0-9]{7,11}";
    NSPredicate *expressFilter = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",expressRegex];
    return [expressFilter evaluateWithObject:expressString];

}

+(NSString *)convertToString:(id)inputData
{
    NSString *returnString = [[NSString alloc]initWithFormat:@"%@",inputData];
    if ([returnString isEqualToString:@"(null)"] || [returnString isEqualToString:@"null"])
        returnString = @"";

    return   returnString;
}


+ (NSString *)flattenHTML:(NSString *)html
{
    NSScanner *theScanner;
    NSString *text = nil;
    
    theScanner = [NSScanner scannerWithString:html];
    
    while ([theScanner isAtEnd] == NO) {
        
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:
                [ NSString stringWithFormat:@"%@>", text]
                                               withString:@" "];
        
    }
    return html;
    
}

+(NSInteger)countArrayItemSum:(NSArray *)inputArray andInputString :(NSString *)inputString
{
    int occurrenes = 0;
    for (NSString *string in inputArray)
    {
        occurrenes += ([string isEqualToString:inputString]);
    }
    return occurrenes;
}




+(NSData *)coverImageToNSData:(UIImage *)lagerImage andOutputFromat:(NSString *)fromat
{
    if ([fromat isEqualToString:@"jpg"]){
        return UIImageJPEGRepresentation(lagerImage, 1);
    }
    else{
        return UIImagePNGRepresentation(lagerImage);
    }
    
    
}

+(NSString *)convertDicToJsonString :(NSMutableDictionary *)inputDic
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:inputDic
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

+ (UIImage *)scaleAndRotateImage:(UIImage *)image {
    
    int kMaxResolution = 640; // Or whatever
    
    CGImageRef imgRef = image.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > kMaxResolution || height > kMaxResolution) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = kMaxResolution;
            bounds.size.height = roundf(bounds.size.width / ratio);
        }
        else {
            bounds.size.height = kMaxResolution;
            bounds.size.width = roundf(bounds.size.height * ratio);
        }
    }
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = image.imageOrientation;
    switch(orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}


+(UILabel *)returnMultiLineLab:(NSString *)inputString andStringFrame:(CGSize)inputStringSize andLabFrame:(CGRect)inputmultiLineLab andFontSize:(float)fontsize
{
    UILabel *multiLineLab = [[UILabel alloc] init];
    [multiLineLab setNumberOfLines:0];
    [multiLineLab setLineBreakMode:NSLineBreakByCharWrapping];
    
    UIFont *font = [UIFont fontWithName:@"Helvetica" size:fontsize];
    CGSize size = CGSizeMake(175, 67);
    CGSize lableSize = [inputString sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    [multiLineLab setText:inputString];
    [multiLineLab setFont:font];
    multiLineLab.frame = CGRectMake(125, 25, lableSize.width, 67);
    return multiLineLab;
}

+(NSString *)trimString:(NSString *)inputString
{
    inputString = [inputString stringByReplacingOccurrencesOfString:@" " withString:@""];
    return inputString;
}

+(id)cutTheImageViewRadius:(id)inputImageView
{
    CALayer *imageViewLayer = [inputImageView layer];   //获取ImageView的层
    [imageViewLayer setMasksToBounds:YES];
    [imageViewLayer setCornerRadius:6.0];
    return inputImageView;
}

+(NSString *)emotionString:(NSString *)inputEmotionString
{
    NSString *emotionString = inputEmotionString;
    NSData *dataPassword = [emotionString dataUsingEncoding:NSNonLossyASCIIStringEncoding];
    emotionString = [[NSString alloc] initWithData:dataPassword encoding:NSUTF8StringEncoding];
    return  emotionString;
}

+(NSString *)emotionDataEncode:(NSString *)inputEmotionString
{
    NSData *data = [inputEmotionString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *goodValue = [[NSString alloc] initWithData:data encoding:NSNonLossyASCIIStringEncoding];
    return goodValue;
}

+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             }
             
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 returnValue = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
         }
     }];
    
    return returnValue;
}


+(void)shakeAnimation:(UIView *)shakeView
{
    CAKeyframeAnimation * anim = [ CAKeyframeAnimation animationWithKeyPath:@"transform" ] ;
    anim.values = @[ [ NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-5.0f, 0.0f, 0.0f) ], [ NSValue valueWithCATransform3D:CATransform3DMakeTranslation(5.0f, 0.0f, 0.0f) ] ] ;
    anim.autoreverses = YES ;
    anim.repeatCount = 2.0f ;
    anim.duration = 0.07f ;
    [shakeView.layer addAnimation:anim forKey:nil ];
}


+(NSString *)getCurrentTime
{
    // 获取系统当前时间
    NSDate * date = [NSDate date];
    NSTimeInterval sec = [date timeIntervalSinceNow];
    NSDate * currentDate = [[NSDate alloc] initWithTimeIntervalSinceNow:sec];
    
    //设置时间输出格式：
    NSDateFormatter * df = [[NSDateFormatter alloc] init ];
    [df setDateFormat:@"yyyy年MM月dd日 HH小时mm分ss秒"];
    return [df stringFromDate:currentDate];
}

+(NSString *)getFloder:(NSString *)folderName{
    
    /*
     |  Document
     */
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    if ([folderName isEqualToString:@"Documents"]) {
        NSString *folder = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        return folder;
        folder = nil;
    }
    
    /*
     | Caches
     */
    else if ([folderName isEqualToString:@"Caches"])
    {
        NSArray *cacPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *cachePath = [cacPath objectAtIndex:0];
        return  cachePath;
    }
    
    else
    {
        NSString *folder = [documentsDirectory stringByAppendingPathComponent:folderName];
        return folder;
        folder = nil;
    }
    paths = nil;

}

+(NSString *)trimDoubleQuotesAndSiglelQuotes:(NSString *)filterString andInputString:(NSMutableString *)inputString {
    return [inputString stringByReplacingOccurrencesOfString:@"\"" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [inputString length])];
}

+ (NSString *)randomString {
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    int len = [letters length];
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
    }
    
    return randomString;
}

@end

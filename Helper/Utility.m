//
//  Utility.m
//  JueWeiShop
//
//  Created by 永坚 陈 on 12-12-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Utility.h"
#import "CommonCrypto/CommonDigest.h"
#import <QuartzCore/QuartzCore.h>

@implementation Utility
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
             ] lowercaseString];
}



+(BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


+(NSString *)convertToString:(id)inputData
{
    return   [[NSString alloc]initWithFormat:@"%@",inputData];
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
    /*
    for (int i=0; i<[inputArray count]; i++)
    {
        NSString *item = [inputArray objectAtIndex:i];
        for (item in inputArray)
        {
            occurrenes += ([item isEqualToString:[inputArray objectAtIndex:i]]?1:0);
        }
    }
     */

}


+(NSMutableArray *)uniqueSameItem:(NSArray*)inputArray
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
    //CGSize size  = inputStringSize;
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

@end

//
//  ValidateHelper.h
//  Holike
//
//  Created by Bosim on 13-6-26.
//  Copyright (c) 2013年 Allan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ValidateHelper : NSObject
+ (BOOL)isValidateEmail:(NSString *)email;
+ (BOOL)isValidateFax:(NSString *)fax;
+ (BOOL)isValidateMobileNumber:(NSString *)mobileNum numType:(NSInteger)type;
+ (BOOL)isExistChinese:(NSString *)text;
@end

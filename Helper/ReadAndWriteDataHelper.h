//
//  ReadAndWriteDataHelper.h
//  ScanMonster
//
//  Created by ChanAllan on 1/9/15.
//  Copyright (c) 2015 ChanAllan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReadAndWriteDataHelper : NSObject

+(NSString *)getFloder:(NSString *)folderName;

+(NSMutableArray *)readDataFromDocument:(NSString *)fileName andFolderName:(NSString *)folderName;

+(BOOL)saveDataToCaches:(id)data andFileName:(NSString *)fileName andFolderName:(NSString *)folderName;

+(void)copyFile:(NSString *)fileName andFileType:(NSString *)fileType andFolderName:(NSString *)folderName;

+(BOOL)fileExists:(NSString *)folderName andFileName:(NSString *)fileName;

+(BOOL)dataExistCaches:(NSString *)barcode andFileName:(NSString *)fileName;

+(BOOL)clearFile:(NSString *)fileName andFolder:(NSString *)folderName;

@end

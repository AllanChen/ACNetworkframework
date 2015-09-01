//
//  ReadAndWriteDataHelper.h
//  ScanMonster
//
//  Created by ChanAllan on 1/9/15.
//  Copyright (c) 2015 ChanAllan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReadAndWriteDataHelper : NSObject

+ (NSString *)getFloder:(NSString *)folderName;

+ (NSMutableArray *)readDataFromDocument:(NSString *)fileName andFolderName:(NSString *)folderName;

+ (BOOL)saveDataToCaches:(id)data andFileName:(NSString *)fileName andFolderName:(NSString *)folderName;

+ (void)copyFile:(NSString *)fileName andFileType:(NSString *)fileType andFolderName:(NSString *)folderName;

/**
 *  判断文件是否存在
 *
 *  @param folderName 文件目录
 *  @param fileName   文件名字
 *
 *  @return 判断是否存在
 */
+ (BOOL)fileExists:(NSString *)folderName andFileName:(NSString *)fileName;

+ (BOOL)dataExistCaches:(NSString *)barcode andFileName:(NSString *)fileName;

/**
 *  拿取缓存下面的文件
 *
 *  @param folderName 文件夹的名字
 *  @param fileName   文件的名字
 *
 *  @return 缓存下的文件路径
 */
+  (NSURL *)getFileFromSandboxWithFolderName:(NSString *)folderName andFileName:(NSString *)fileName;

/**
 *  清空文件夹
 *
 *  @param folderName 文件夹名称
 *  @param fileName   文件名称
 *
 *  @return 是否成功
 */
+ (BOOL)clearFolder:(NSString *)folderName andFile:(NSString *)fileName;

/**
 *  删除文件
 *
 *  @param folderName 文件夹名称
 *  @param fileName   文件名称
 *
 *  @return 是否成功删除
 */
+ (BOOL)deleteFileFromFolder:(NSString *)folderName andFileName:(NSString *)fileName;

/**
 *  创建文件夹
 *
 *  @param rootFolderName  文件夹所在目录
 *  @param inputFolderName 文件夹名称
 *
 *  @return 是否创建成功
 */
+ (BOOL) createFolderOnSandBox:(NSString *)rootFolderName andFolderName:(NSString *)inputFolderName;


@end

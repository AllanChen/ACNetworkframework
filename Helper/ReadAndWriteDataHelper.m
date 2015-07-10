//
//  ReadAndWriteDataHelper.m
//  ScanMonster
//
//  Created by ChanAllan on 1/9/15.
//  Copyright (c) 2015 ChanAllan. All rights reserved.
//

#import "ReadAndWriteDataHelper.h"

@implementation ReadAndWriteDataHelper

+(NSMutableArray *)readDataFromDocument:(NSString *)fileName andFolderName:(NSString *)folderName
{
    NSString *cacheDocument = [self getFloder:folderName];
    NSString *cachePath = [cacheDocument stringByAppendingPathComponent:fileName];
    return [NSMutableArray arrayWithContentsOfFile:cachePath];
}

+(BOOL)saveDataToCaches:(id)data andFileName:(NSString *)fileName andFolderName:(NSString *)folderName
{
    NSString *dirPath = [self getFloder:folderName];
    NSString *writePath = [dirPath stringByAppendingPathComponent:fileName];
    NSMutableArray *favDataFromCache = [NSMutableArray arrayWithContentsOfFile:writePath];
    if (favDataFromCache == nil) {
        favDataFromCache = [[NSMutableArray alloc] initWithCapacity:10];
    }
    return [favDataFromCache writeToFile:data atomically:YES];
}


/**
 *  复制文件到缓存目录下
 */
+(void)copyFile:(NSString *)fileName andFileType:(NSString *)fileType andFolderName:(NSString *)folderName
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *txtPath = [[ReadAndWriteDataHelper getFloder:folderName] stringByAppendingPathComponent:[[NSString alloc]initWithFormat:@"%@.%@",fileName,fileType]];
    
    NSString *resourcePath = [[NSBundle mainBundle] pathForResource:fileName ofType:fileType];
    [fileManager copyItemAtPath:resourcePath toPath:txtPath error:nil];
}

/**
 *  判断文件是否存在缓存
 *  @return Bool
 */
+(BOOL)fileExists:(NSString *)folderName andFileName:(NSString *)fileName
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *fullPath = [[self getFloder:folderName] stringByAppendingPathComponent:fileName];
    BOOL fileExists = [fileManager fileExistsAtPath:fullPath];
    return fileExists;
}

/*
 |  判断同样Barcode 是否存在
 */
+(BOOL)dataExistCaches:(NSString *)barcode andFileName:(NSString *)fileName;
{
    BOOL isExist  = FALSE;
    NSString *dirPath =[self getFloder:@"Caches"];
    NSString *wirtePath = [dirPath stringByAppendingPathComponent:fileName];
    NSMutableArray *favDataFromCache = [NSMutableArray arrayWithContentsOfFile:wirtePath];
    if (favDataFromCache == nil)
    {
        favDataFromCache = [[NSMutableArray alloc] initWithCapacity:1];
    }
    
    for (int i=0; i<favDataFromCache.count; i++)
    {
        if ([[[favDataFromCache objectAtIndex:i] objectForKey:@"barcode"] isEqualToString:barcode])
        {
            isExist = TRUE;
        }
        else
        {
            isExist = FALSE;
        }
    }
    return isExist;
}

+(BOOL)clearFile:(NSString *)fileName andFolder:(NSString *)folderName
{
    NSString *dirPath = [self getFloder:folderName];
    NSString *writePath = [dirPath stringByAppendingPathComponent:fileName];
    NSMutableArray *favDataFromCache = [NSMutableArray arrayWithContentsOfFile:writePath];
    return [favDataFromCache writeToFile:nil atomically:YES];
}

/**
 *  切换到存入的文件夹目录下
 */
+(NSString *)getFloder:(NSString *)folderName
{
    
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
@end

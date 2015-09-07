//
//  ReadAndWriteDataHelper.m
//  ScanMonster
//
//  Created by ChanAllan on 1/9/15.
//  Copyright (c) 2015 ChanAllan. All rights reserved.
//

#import "ReadAndWriteDataHelper.h"
typedef NS_ENUM(NSUInteger, FolderName) {
    kDocuments = 0,
    kCaches,
    kTemp
};

@implementation ReadAndWriteDataHelper

+ (NSMutableArray *)readDataFromDocument:(NSString *)fileName andFolderName:(NSString *)folderName
{
    NSString *cacheDocument = [self getFloder:folderName];
    NSString *cachePath = [cacheDocument stringByAppendingPathComponent:fileName];
    return [NSMutableArray arrayWithContentsOfFile:cachePath];
}

+ (BOOL)saveDataToCaches:(id)data andFileName:(NSString *)fileName andFolderName:(NSString *)folderName
{
    NSString *dirPath = [self getFloder:folderName];
    NSString *writePath = [dirPath stringByAppendingPathComponent:fileName];
    NSMutableArray *favDataFromCache = [NSMutableArray arrayWithContentsOfFile:writePath];
    if (favDataFromCache == nil) {
        favDataFromCache = [[NSMutableArray alloc] initWithCapacity:10];
    }
    return [favDataFromCache writeToFile:data atomically:YES];
}

+ (void)copyFile:(NSString *)fileName andFileType:(NSString *)fileType andFolderName:(NSString *)folderName
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *txtPath = [[ReadAndWriteDataHelper getFloder:folderName] stringByAppendingPathComponent:[[NSString alloc]initWithFormat:@"%@.%@",fileName,fileType]];
    
    NSString *resourcePath = [[NSBundle mainBundle] pathForResource:fileName ofType:fileType];
    [fileManager copyItemAtPath:resourcePath toPath:txtPath error:nil];
}

+ (BOOL)fileExists:(NSString *)folderName andFileName:(NSString *)fileName
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *fullPath = [[self getFloder:folderName] stringByAppendingPathComponent:fileName];
    BOOL fileExists = [fileManager fileExistsAtPath:fullPath];
    return fileExists;
}

/*
 |  判断同样Barcode 是否存在
 */
+ (BOOL)dataExistCaches:(NSString *)barcode andFileName:(NSString *)fileName;
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

+ (BOOL)clearFolder:(NSString *)folderName andFile:(NSString *)fileName
{
    NSString *dirPath = [self getFloder:folderName];
    NSString *writePath = [dirPath stringByAppendingPathComponent:fileName];
    NSMutableArray *favDataFromCache = [NSMutableArray arrayWithContentsOfFile:writePath];
    return [favDataFromCache writeToFile:nil atomically:YES];
}

+ (BOOL)deleteFileFromFolder:(NSString *)folderName andFileName:(NSString *)fileName{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *folderPath = [self getFloder:folderName];
    NSString *filePath = [folderPath stringByAppendingPathComponent:fileName];
    NSError *error;
    BOOL success = [fileManager removeItemAtPath:filePath error:&error];
    if (success) {
        return TRUE;
    }
    else
    {
        NSLog(@"Could not delete file -:%@ ",[error localizedDescription]);
        return FALSE;
    }
}

+ (NSString *)getFloder:(NSString *)folderName
{
    //Document
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    if ([folderName isEqualToString:@"Documents"]) {
        NSString *folder = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        return folder;
    }
    
    //Caches
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

+  (NSURL *)getFileFromSandboxWithFolderName:(NSString *)folderName andFileName:(NSString *)fileName{
    NSString *documentsDirectory = [self getFloder:folderName];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
    return [NSURL fileURLWithPath:filePath];
}

+ (BOOL) createFolderOnSandBox:(NSString *)rootFolderName andFolderName:(NSString *)inputFolderName{
    NSError *error;
    NSString *documentsDirectory = [self getFloder:rootFolderName];
    NSString *folderName = [[NSString alloc] initWithFormat:@"/%@",inputFolderName];
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:folderName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath]){
        BOOL createStatus = [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error];
        return (createStatus)?YES:NO;
    }
    else{
        return YES;
    }
}
@end

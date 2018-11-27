//
//  LeanCloudTool.m
//  PostcardRecord
//
//  Created by xxb on 2018/8/7.
//  Copyright © 2018年 xxb. All rights reserved.
//

#import "LeanCloudTool.h"
#import "Header_leanConfig.h"

@implementation LeanCloudTool
+ (void)registerService
{
    [AVOSCloud setApplicationId:appId clientKey:appKey];
}

#pragma mark - 和云端数据同步
+ (void)fetchObject:(AVObject *_Nonnull)object block:(AVObjectResultBlock _Nullable)block
{
    [object fetchInBackgroundWithBlock:block];
}
+ (void)fetchObjects:(NSArray <AVObject *>*_Nonnull)objects block:(AVArrayResultBlock _Nullable)block
{
    [AVObject fetchAllInBackground:objects block:block];
}

#pragma mark - 删除
+ (void)deleteObject:(AVObject *_Nonnull)object block:(AVBooleanResultBlock _Nullable)block
{
    [object deleteInBackgroundWithBlock:block];
}
+ (void)deleteObjects:(NSArray <AVObject *>*_Nonnull)objects block:(AVBooleanResultBlock _Nullable)block
{
    [AVObject deleteAllInBackground:objects block:block];
}

#pragma mark - 修改
+ (void)updateObjects:(NSArray <AVObject *>*_Nonnull)objects block:(AVBooleanResultBlock _Nullable)block
{
    [AVObject saveAllInBackground:objects block:block];
}
+ (void)updateValue:(id _Nonnull)value forKey:(NSString *_Nonnull)leanKey atTable:(NSString *_Nonnull)leanTable objectId:(NSString *_Nonnull)objectId block:(LeanCloudToolAddValueResultBlock _Nullable)block
{
    AVObject *doObject = [AVObject objectWithClassName:leanTable objectId:objectId];
    [doObject setObject:value forKey:leanKey];
    [doObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (block)
        {
            block(succeeded,error,doObject.objectId);
        }
    }];
}

+ (void)updateKeyValues:(NSDictionary *_Nonnull)keyValues atTable:(NSString *_Nonnull)leanTable objectId:(NSString *_Nonnull)objectId block:(LeanCloudToolAddValueResultBlock _Nullable)block
{
    AVObject *doObject = [AVObject objectWithClassName:leanTable objectId:objectId];
    [keyValues enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [doObject setObject:obj forKey:key];
    }];
    [doObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (block)
        {
            block(succeeded,error,doObject.objectId);
        }
    }];
}

#pragma mark - 新增
+ (void)addKeyValues:(NSDictionary *_Nonnull)keyValues atTable:(NSString *_Nonnull)leanTable block:(LeanCloudToolAddValueResultBlock _Nullable)block
{
    AVObject *doObject = [AVObject objectWithClassName:leanTable];
    [keyValues enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [doObject setObject:obj forKey:key];
    }];
    [doObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (block)
        {
            block(succeeded,error,doObject.objectId);
        }
    }];
}
+ (void)addValue:(id _Nonnull)value forKey:(NSString *_Nonnull)leanKey atTable:(NSString *_Nonnull)leanTable block:(LeanCloudToolAddValueResultBlock _Nullable)block
{
    AVObject *doObject = [AVObject objectWithClassName:leanTable];
    [doObject setObject:value forKey:leanKey];
    [doObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (block)
        {
            block(succeeded,error,doObject.objectId);
        }
    }];
}

#pragma mark -创建查询条件
+ (AVQuery *_Nonnull)createAVQueryWithKey:(NSString *_Nonnull)leanKey value:(id _Nonnull)value nexus:(LeanNexus)nexus fromTable:(NSString * _Nonnull)leanTable
{
    AVQuery *query = [AVQuery queryWithClassName:leanTable];
    switch (nexus)
    {
        case LeanNexus_equalTo:
        {
            [query whereKey:leanKey equalTo:value];
        }
            break;
        case LeanNexus_notEqualTo:
        {
            [query whereKey:leanKey notEqualTo:value];
        }
            break;
        case LeanNexus_lessThan:
        {
            [query whereKey:leanKey lessThan:value];
        }
            break;
        case LeanNexus_lessThanOrEqualTo:
        {
            [query whereKey:leanKey lessThanOrEqualTo:value];
        }
            break;
        case LeanNexus_greaterThan:
        {
            [query whereKey:leanKey greaterThan:value];
        }
            break;
        case LeanNexus_greaterThanOrEqualTo:
        {
            [query whereKey:leanKey greaterThanOrEqualTo:value];
        }
            break;
            
        default:
            break;
    }
    return query;
}

#pragma mark - 查询
+ (void)getObjectWithObjectId:(NSString *_Nonnull)objectId fromTable:(NSString *_Nonnull)leanTable block:(AVObjectResultBlock _Nullable)block
{
    AVQuery *query = [AVQuery queryWithClassName:leanTable];
    [query getObjectInBackgroundWithId:objectId block:block];
}
+ (void)findObjectWithAVQuery:(AVQuery * _Nonnull)query block:(AVArrayResultBlock _Nullable)block
{
    [query findObjectsInBackgroundWithBlock:block];
}
+ (void)andFindObjectWithAVQueryArr:(NSArray <AVQuery *>*_Nonnull)queryArr block:(AVArrayResultBlock _Nullable)block
{
    AVQuery *query = [AVQuery andQueryWithSubqueries:queryArr];
    [query findObjectsInBackgroundWithBlock:block];
}
+ (void)orFindObjectWithAVQueryArr:(NSArray <AVQuery *>*_Nonnull)queryArr block:(AVArrayResultBlock _Nullable)block
{
    AVQuery *query = [AVQuery orQueryWithSubqueries:queryArr];
    [query findObjectsInBackgroundWithBlock:block];
}

#pragma mark - 文件上传与下载
+ (AVFile *_Nonnull)createAVFileWithData:(NSData *_Nonnull)data fileName:(NSString *_Nonnull)fileName
{
    AVFile *file = [AVFile fileWithData:data name:fileName];
    return file;
}
+ (AVFile *_Nonnull)createAVFileWithLocalFilePath:(NSString *_Nonnull)filePath
{
    NSError *error;
    AVFile *file = [AVFile fileWithLocalPath:filePath error:&error];
    if (error)
    {
        NSLog(@"创建文件失败");
    }
    return file;
}
+ (AVFile *_Nonnull)createAVFileWithNetUrlStr:(NSString *_Nonnull)urlStr
{
    AVFile *file =[AVFile fileWithRemoteURL:[NSURL URLWithString:urlStr]];
    return file;
}
+ (void)uploadAVFile:(AVFile *_Nonnull)file withProgress:(void (^_Nullable)(NSInteger))uploadProgressBlock
   completionHandler:(void (^_Nullable)(BOOL, NSError * _Nullable))completionHandler
{
    [file uploadWithProgress:^(NSInteger percentDone) {
        // 上传进度数据，percentDone 介于 0 和 100。
        if (uploadProgressBlock)
        {
            uploadProgressBlock(percentDone);
        }
    } completionHandler:^(BOOL succeeded, NSError *error) {
        // 成功或失败处理...
        if (completionHandler)
        {
            completionHandler(succeeded,error);
        }
    }];
}

+ (void)downLoadAVFile:(AVFile *_Nonnull)file withProgress:(void (^_Nullable)(NSInteger))downloadProgressBlock
     completionHandler:(void (^_Nullable)(NSURL * _Nullable, NSError * _Nullable))completionHandler
{
    [file downloadWithProgress:^(NSInteger number) {
        //下载的进度数据，number 介于 0 和 100。
        if (downloadProgressBlock)
        {
            downloadProgressBlock(number);
        }
    } completionHandler:^(NSURL * _Nullable filePath, NSError * _Nullable error) {
        // filePath 是文件下载到本地的地址
        if (completionHandler)
        {
            completionHandler(filePath,error);
        }
    }];
}
@end

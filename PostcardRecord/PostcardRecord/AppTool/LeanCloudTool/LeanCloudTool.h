//
//  LeanCloudTool.h
//  PostcardRecord
//
//  Created by xxb on 2018/8/7.
//  Copyright © 2018年 xxb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Header_leanTable.h"
#import "Header_leanKey.h"
#import "Header_leanEnum.h"
#import <AVOSCloud/AVOSCloud.h>


typedef void (^LeanCloudToolAddValueResultBlock)(BOOL succeeded,  NSError * _Nullable error, NSString * _Nullable objectId);


@interface LeanCloudTool : NSObject
///初始化
+ (void)registerService;

#pragma mark - 和云端数据同步
+ (void)fetchObject:(AVObject *_Nonnull)object block:(AVObjectResultBlock _Nullable)block;
+ (void)fetchObjects:(NSArray <AVObject *>*_Nonnull)objects block:(AVArrayResultBlock _Nullable)block;

#pragma mark - 删除
+ (void)deleteObject:(AVObject *_Nonnull)object block:(AVBooleanResultBlock _Nullable)block;
+ (void)deleteObjects:(NSArray <AVObject *>*_Nonnull)objects block:(AVBooleanResultBlock _Nullable)block;

#pragma mark - 修改
+ (void)updateObjects:(NSArray <AVObject *>*_Nonnull)objects block:(AVBooleanResultBlock _Nullable)block;
+ (void)updateValue:(id _Nonnull)value forKey:(NSString *_Nonnull)leanKey atTable:(NSString *_Nonnull)leanTable objectId:(NSString *_Nonnull)objectId block:(LeanCloudToolAddValueResultBlock _Nullable)block;
+ (void)updateKeyValues:(NSDictionary *_Nonnull)keyValues atTable:(NSString *_Nonnull)leanTable objectId:(NSString *_Nonnull)objectId block:(LeanCloudToolAddValueResultBlock _Nullable)block;

#pragma mark - 新增
+ (void)addKeyValues:(NSDictionary *_Nonnull)keyValues atTable:(NSString *_Nonnull)leanTable block:(LeanCloudToolAddValueResultBlock _Nullable)block;
+ (void)addValue:(id _Nonnull)value forKey:(NSString *_Nonnull)leanKey atTable:(NSString *_Nonnull)leanTable block:(LeanCloudToolAddValueResultBlock _Nullable)block;


#pragma mark -创建查询条件
///创建查询条件
+ (AVQuery *_Nonnull)createAVQueryWithKey:(NSString *_Nonnull)leanKey value:(id _Nonnull)value nexus:(LeanNexus)nexus fromTable:(NSString * _Nonnull)leanTable;

#pragma mark - 查询
+ (void)getObjectWithObjectId:(NSString *_Nonnull)objectId fromTable:(NSString *_Nonnull)leanTable block:(AVObjectResultBlock _Nullable)block;
+ (void)findObjectWithAVQuery:(AVQuery * _Nonnull)query block:(AVArrayResultBlock _Nullable)block;
+ (void)andFindObjectWithAVQueryArr:(NSArray <AVQuery *>*_Nonnull)queryArr block:(AVArrayResultBlock _Nullable)block;
+ (void)orFindObjectWithAVQueryArr:(NSArray <AVQuery *>*_Nonnull)queryArr block:(AVArrayResultBlock _Nullable)block;


#pragma mark - 文件上传与下载
+ (AVFile *_Nonnull)createAVFileWithData:(NSData *_Nonnull)data fileName:(NSString *_Nonnull)fileName;
+ (AVFile *_Nonnull)createAVFileWithLocalFilePath:(NSString *_Nonnull)filePath;
+ (AVFile *_Nonnull)createAVFileWithNetUrlStr:(NSString *_Nonnull)urlStr;
+ (void)uploadAVFile:(AVFile *_Nonnull)file withProgress:(void (^_Nullable)(NSInteger))uploadProgressBlock
   completionHandler:(void (^_Nullable)(BOOL, NSError * _Nullable))completionHandler;
+ (void)downLoadAVFile:(AVFile *_Nonnull)file withProgress:(void (^_Nullable)(NSInteger))downloadProgressBlock
     completionHandler:(void (^_Nullable)(NSURL * _Nullable, NSError * _Nullable))completionHandler;


@end

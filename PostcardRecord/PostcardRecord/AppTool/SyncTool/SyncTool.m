//
//  SyncTool.m
//  PostcardRecord
//
//  Created by xxb on 2018/8/7.
//  Copyright © 2018年 xxb. All rights reserved.
//

#import "SyncTool.h"
#import "LeanCloudTool.h"

@implementation SyncTool

+ (instancetype)shared
{
    return [self new];
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static SyncTool *tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [super allocWithZone:zone];
    });
    return tool;
}
- (instancetype)init
{
    if (self = [super init])
    {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            
        });
    }
    return self;
}


- (void)uploadDataForUserName:(NSString *)userName block:(void (^)(BOOL successed))block
{
    NSMutableArray *arrMSeries = [[SeriesTool shared] getSeriesModelArr];
    NSData *arrMSeriesData = [NSKeyedArchiver archivedDataWithRootObject:arrMSeries];
    
    NSMutableDictionary *dicMSeriesDetail = [[SeriesDetailTool shared] getSeriesDetailModelsDic];
    NSData *dicMSeriesDetailData = [NSKeyedArchiver archivedDataWithRootObject:dicMSeriesDetail];
    
    AVQuery *query = [LeanCloudTool createAVQueryWithKey:leanKey_userName value:userName nexus:LeanNexus_equalTo fromTable:leanTable_seriesData];
    [LeanCloudTool findObjectWithAVQuery:query block:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error)
        {
            if (error.code == 101)
            {
                //新增
                [self addKeyValuesWithBlock:block keyValues:@{leanKey_userName:userName,leanKey_seriesData:arrMSeriesData,leanKey_seriesDetailData:dicMSeriesDetailData} table:leanTable_seriesData];
            }
            else
            {
                block(NO);
            }
        }
        else
        {
            if (objects.count == 0)//新增
            {
                [self addKeyValuesWithBlock:block keyValues:@{leanKey_userName:userName,leanKey_seriesData:arrMSeriesData,leanKey_seriesDetailData:dicMSeriesDetailData} table:leanTable_seriesData];
            }
            else
            {
                AVObject *object = (AVObject *)objects.firstObject;
                [LeanCloudTool updateKeyValues:@{leanKey_userName:userName,leanKey_seriesData:arrMSeriesData,leanKey_seriesDetailData:dicMSeriesDetailData} atTable:leanTable_seriesData objectId:object.objectId block:^(BOOL succeeded, NSError * _Nullable error, NSString * _Nullable objectId) {
                    if (succeeded)
                    {
                        if (block)
                        {
                            block(YES);
                        }
                    }
                    else
                    {
                        if (block)
                        {
                            block(NO);
                        }
                    }
                }];
            }
        }
    }];
}
- (void)addKeyValuesWithBlock:(void (^)(BOOL successed))block keyValues:(NSDictionary *)keyValues table:(NSString *)table
{
    [LeanCloudTool addKeyValues:keyValues atTable:table block:^(BOOL succeeded, NSError * _Nullable error, NSString * _Nullable objectId) {
        if (succeeded)
        {
            if (block)
            {
                block(YES);
            }
        }
        else
        {
            if (block)
            {
                block(NO);
            }
        }
    }];
}
- (void)downloadDataForUserName:(NSString *)userName block:(void (^)(BOOL successed))block
{
    AVQuery *query = [LeanCloudTool createAVQueryWithKey:leanKey_userName value:userName nexus:LeanNexus_equalTo fromTable:leanTable_seriesData];
    [LeanCloudTool findObjectWithAVQuery:query block:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error == nil)
        {
            if (objects.count)
            {
                AVObject *object = (AVObject *)objects.firstObject;
                
                NSData *seriesData = [object objectForKey:leanKey_seriesData];
                NSMutableArray *seriesArrM = [NSKeyedUnarchiver unarchiveObjectWithData:seriesData];
                [[SeriesTool shared] replaceSeriesModelArr:seriesArrM];
                
                NSData *seriesDetailData = [object objectForKey:leanKey_seriesDetailData];
                NSMutableDictionary *seriesDetailDicM = [NSKeyedUnarchiver unarchiveObjectWithData:seriesDetailData];
                [[SeriesDetailTool shared] replaceSeriesDetailModelsDic:seriesDetailDicM];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:XBNotice_downloadCloadSeriesDataSuccess object:nil];
            if (block)
            {
                block(YES);
            }
        }
        else
        {
            if (block)
            {
                block(NO);
            }
        }
        
    }];
}
@end

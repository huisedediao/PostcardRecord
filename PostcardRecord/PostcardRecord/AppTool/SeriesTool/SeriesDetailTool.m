//
//  SeriesDetailTool.m
//  PostcardRecord
//
//  Created by xxb on 2018/8/6.
//  Copyright © 2018年 xxb. All rights reserved.
//

#import "SeriesDetailTool.h"

@interface SeriesDetailTool ()
@property (nonatomic,strong) NSMutableDictionary *dicM_seriesDetailModels;
@end

@implementation SeriesDetailTool

+ (instancetype)shared
{
    return [self new];
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static SeriesDetailTool *tool = nil;
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
            _dicM_seriesDetailModels = [self getStoreSeriesModelsDic];
        });
    }
    return self;
}

- (void)addSeriesDetailModel:(SeriesDetailModel *)model forSeriesKeyIndex:(NSInteger)keyIndex
{
    NSMutableArray *arrM = [self getSeriesDetailModelsArrMForKeyIndex:keyIndex];
    [arrM addObject:model];
    [self storeSeriesModelsDic];
}

- (NSMutableArray *)getSeriesDetailModelsArrMForKeyIndex:(NSInteger)keyIndex
{
    NSString *key = [NSString stringWithFormat:@"%zd",keyIndex];
    NSMutableArray *arrM = self.dicM_seriesDetailModels[key];
    if (arrM == nil)
    {
        arrM = [NSMutableArray new];
        self.dicM_seriesDetailModels[key] = arrM;
    }
    return arrM;
}

- (NSMutableDictionary *)getSeriesDetailModelsDic
{
    return _dicM_seriesDetailModels;
}

- (void)replaceSeriesDetailModelsDic:(NSMutableDictionary *)dic
{
    _dicM_seriesDetailModels = dic;
    [self storeSeriesModelsDic];
}

#pragma mark - 数据存储与读取
- (NSMutableDictionary *)getStoreSeriesModelsDic
{
    NSMutableDictionary *dicM = [XBAppTool getObjectForKey:xb_key_seriesDetailModelArrM];
    if (dicM == nil)
    {
        dicM = [NSMutableDictionary new];
    }
    return dicM;
}

- (void)storeSeriesModelsDic
{
    [XBAppTool storeObject:_dicM_seriesDetailModels storeKey:xb_key_seriesDetailModelArrM];
}

@end

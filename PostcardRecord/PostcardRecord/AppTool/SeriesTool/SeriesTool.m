//
//  SeriesTool.m
//  PostcardRecord
//
//  Created by xxb on 2018/8/6.
//  Copyright © 2018年 xxb. All rights reserved.
//

#import "SeriesTool.h"

@interface SeriesTool ()
@property (nonatomic,strong) NSMutableArray *arrM_seriesModels;
@end

@implementation SeriesTool

+ (instancetype)shared
{
    return [self new];
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static SeriesTool *tool = nil;
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
            _arrM_seriesModels = [self getStoreSeriesModelsArr];
        });
    }
    return self;
}

- (void)addSeriesModel:(SeriesModel *)model
{
    model.keyIndex = self.arrM_seriesModels.count;
    [self.arrM_seriesModels addObject:model];
    [self storeSeriesModelsArr];
}

- (NSMutableArray *)getSeriesModelArr
{
    return self.arrM_seriesModels;
}

- (SeriesModel *)getSeriesModelWithKey:(NSInteger)indexKey
{
    return self.arrM_seriesModels[indexKey];
}

- (void)replaceSeriesModelArr:(NSMutableArray *)arr
{
    _arrM_seriesModels = arr;
    [self storeSeriesModelsArr];
}

#pragma mark - 数据存储与读取
- (NSMutableArray *)getStoreSeriesModelsArr
{
    NSMutableArray *arrM = [XBAppTool getObjectForKey:xb_key_seriesModelArrM];
    if (arrM == nil)
    {
        arrM = [NSMutableArray new];
    }
    return arrM;
}

- (void)storeSeriesModelsArr
{
    [XBAppTool storeObject:_arrM_seriesModels storeKey:xb_key_seriesModelArrM];
}


@end

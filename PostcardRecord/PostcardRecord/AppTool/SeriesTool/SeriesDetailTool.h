//
//  SeriesDetailTool.h
//  PostcardRecord
//
//  Created by xxb on 2018/8/6.
//  Copyright © 2018年 xxb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SeriesDetailModel.h"

@interface SeriesDetailTool : NSObject

+ (instancetype)shared;

- (void)addSeriesDetailModel:(SeriesDetailModel *)model forSeriesKeyIndex:(NSInteger)keyIndex;

- (NSMutableArray *)getSeriesDetailModelsArrMForKeyIndex:(NSInteger)keyIndex;

- (NSMutableDictionary *)getSeriesDetailModelsDic;

///用传入的字典替换原来的字典（从云端同步数据到本地时使用）
- (void)replaceSeriesDetailModelsDic:(NSMutableDictionary *)dic;
@end

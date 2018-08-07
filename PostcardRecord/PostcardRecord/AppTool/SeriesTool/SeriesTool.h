//
//  SeriesTool.h
//  PostcardRecord
//
//  Created by xxb on 2018/8/6.
//  Copyright © 2018年 xxb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SeriesModel.h"

@interface SeriesTool : NSObject

+ (instancetype)shared;

///添加的时候自动为series model创建序号作为主键
- (void)addSeriesModel:(SeriesModel *)model;

///获取所有series model
- (NSMutableArray *)getSeriesModelArr;

///根据主键查询series model
- (SeriesModel *)getSeriesModelWithKey:(NSInteger)indexKey;

///用传入的数组替换原来的数组（从云端同步数据到本地时使用）
- (void)replaceSeriesModelArr:(NSMutableArray *)arr;

@end

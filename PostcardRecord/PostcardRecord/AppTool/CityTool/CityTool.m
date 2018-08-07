//
//  CityTool.m
//  PostcardRecord
//
//  Created by xxb on 2018/8/6.
//  Copyright © 2018年 xxb. All rights reserved.
//

#import "CityTool.h"
#import "CountryModel.h"

@interface CityTool ()
@property (nonatomic,strong) NSArray *arr_countryData;
@end

@implementation CityTool

+ (instancetype)shared
{
    return [self new];
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static CityTool *tool = nil;
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

- (void)loadData
{
    NSDictionary *dic = [XBAppTool readLocalJsonFileWithName:@"city"];
    self.arr_countryData = [CountryModel mj_objectArrayWithKeyValuesArray:dic[@"Location"][@"CountryRegion"]];
}

- (NSArray *)getChinaCity
{
    CountryModel *chinaModel = self.arr_countryData[0];
    return chinaModel.State;
}

- (NSArray *)getWorldCountry
{
    return self.arr_countryData;
}
@end

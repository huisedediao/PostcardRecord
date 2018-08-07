//
//  CountryModel.m
//  PostcardRecord
//
//  Created by xxb on 2018/8/6.
//  Copyright © 2018年 xxb. All rights reserved.
//

#import "CountryModel.h"

@implementation CountryModel
/* 数组中存储模型数据，需要说明数组中存储的模型数据类型 */
+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"State" : @"CityModel",
             };
}

@end

//
//  CityTool.h
//  PostcardRecord
//
//  Created by xxb on 2018/8/6.
//  Copyright © 2018年 xxb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityTool : NSObject
+ (instancetype)shared;
- (void)loadData;
- (NSArray *)getChinaCity;
- (NSArray *)getWorldCountry;
@end

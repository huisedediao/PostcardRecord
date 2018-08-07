//
//  CountryModel.h
//  PostcardRecord
//
//  Created by xxb on 2018/8/6.
//  Copyright © 2018年 xxb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegionModel.h"

@interface CountryModel : RegionModel <NSCoding>
//@property (nonatomic,copy) NSString *Name;
//@property (nonatomic,copy) NSString *Code;
@property (nonatomic,strong) NSArray *State;
@end

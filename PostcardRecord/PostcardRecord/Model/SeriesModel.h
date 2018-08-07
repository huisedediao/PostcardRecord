//
//  SeriesModel.h
//  PostcardRecord
//
//  Created by xxb on 2018/8/6.
//  Copyright © 2018年 xxb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SeriesModel : NSObject <NSCoding>
@property (nonatomic,assign) NSInteger keyIndex;
@property (nonatomic,copy) NSString *str_name;
@property (nonatomic,assign) LimitsType type;
@end

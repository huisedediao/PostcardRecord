//
//  LoginTool.h
//  PostcardRecord
//
//  Created by xxb on 2018/8/7.
//  Copyright © 2018年 xxb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LeanCloudTool.h"

@interface LoginTool : NSObject
@property (nonatomic,copy,readonly) NSString *curUserName;
+ (instancetype)shared;
- (BOOL)isLogined;
- (void)loginWithUserName:(NSString *)userName pwd:(NSString *)pwd block:(AVBooleanResultBlock)block;
- (void)loginOut;
@end

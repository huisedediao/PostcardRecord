//
//  SyncTool.h
//  PostcardRecord
//
//  Created by xxb on 2018/8/7.
//  Copyright © 2018年 xxb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SyncTool : NSObject
+ (instancetype)shared;
- (void)uploadDataForUserName:(NSString *)userName block:(void (^)(BOOL successed))block;
- (void)downloadDataForUserName:(NSString *)userName block:(void (^)(BOOL successed))block;
@end

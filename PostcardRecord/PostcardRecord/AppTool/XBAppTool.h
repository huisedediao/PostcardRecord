//
//  XBAppTool.h
//  XBAppTools
//
//  Created by xxb on 2018/5/22.
//  Copyright © 2018年 xxb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XBAppTool : NSObject

+ (instancetype)shared;

///获取屏幕最顶层的vc
+ (UIViewController *)topViewController;

///存储数据到本地
+ (void)storeObject:(id)object storeKey:(NSString *)storeKey;
///从本地读取数据
+ (id)getObjectForKey:(NSString *)key;

///获取设备型号
- (NSString *)iphoneType;

///修复tableViewCell上的按钮点击延迟
+ (void)setTableViewDelaysContentTouchesNO:(UITableView *)tableView;

/// 读取本地JSON文件
+ (NSDictionary *)readLocalJsonFileWithName:(NSString *)name;

@end

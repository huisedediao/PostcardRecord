//
//  LoginTool.m
//  PostcardRecord
//
//  Created by xxb on 2018/8/7.
//  Copyright © 2018年 xxb. All rights reserved.
//

#import "LoginTool.h"

@interface LoginTool ()
{
    BOOL _isLogined;
}
@property (nonatomic,assign) BOOL isLogined;
@end

@implementation LoginTool

+ (instancetype)shared
{
    return [self new];
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static LoginTool *tool = nil;
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
            _isLogined = [self getStoreIsloginToLocal];
            _curUserName = [self getStoreCurUserName];
        });
    }
    return self;
}
- (void)loginWithUserName:(NSString *)userName pwd:(NSString *)pwd block:(AVBooleanResultBlock)block
{
    AVQuery *query1 = [LeanCloudTool createAVQueryWithKey:leanKey_userName value:userName nexus:LeanNexus_equalTo fromTable:leanTable_user];
    [LeanCloudTool findObjectWithAVQuery:query1 block:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error)
        {
            if (block)
            {
                block(NO,nil);
            }
            return;
        }
        if (objects.count != 0)//登陆
        {
            AVQuery *query2 = [LeanCloudTool createAVQueryWithKey:leanKey_password value:pwd nexus:LeanNexus_equalTo fromTable:leanTable_user];
            [LeanCloudTool andFindObjectWithAVQueryArr:@[query1,query2] block:^(NSArray * _Nullable objects, NSError * _Nullable error) {
                if (objects.count != 0 && error == nil)
                {
                    if (block)
                    {
                        block(YES,nil);
                    }
                    self.isLogined = YES;
                    [self storeCurUserName:userName];
                    [[NSNotificationCenter defaultCenter] postNotificationName:XBNotice_loginSuccess object:nil];
                }
                else
                {
                    if (block)
                    {
                        block(NO,nil);
                    }
                }
            }];
        }
        else //注册
        {
            [LeanCloudTool addValue:userName forKey:leanKey_userName atTable:leanTable_user block:^(BOOL succeeded, NSError * _Nullable error, NSString * _Nullable objectId) {
                if (succeeded)
                {
                    [LeanCloudTool updateValue:pwd forKey:leanKey_password atTable:leanTable_user objectId:objectId block:^(BOOL succeeded, NSError * _Nullable error, NSString * _Nullable objectId) {
                        if (succeeded)
                        {
                            if (block)
                            {
                                block(YES,nil);
                            }
                            self.isLogined = YES;
                            [self storeCurUserName:userName];
                            [[NSNotificationCenter defaultCenter] postNotificationName:XBNotice_loginSuccess object:nil];
                        }
                        else
                        {
                            if (block)
                            {
                                block(NO,nil);
                            }
                        }
                    }];
                }
                else
                {
                    if (block)
                    {
                        block(NO,nil);
                    }
                }
            }];
        }
    }];
}
- (void)loginOut
{
    _isLogined = NO;
}
- (BOOL)isLogined
{
    return _isLogined;
}
- (void)setIsLogined:(BOOL)isLogined
{
    _isLogined = isLogined;
    [self storeIsloginToLocal];
}
- (void)storeCurUserName:(NSString *)curUserName
{
    _curUserName = curUserName;
    [XBAppTool storeObject:_curUserName storeKey:xb_key_curUserName];
}
- (NSString *)getStoreCurUserName
{
    return [XBAppTool getObjectForKey:xb_key_curUserName];
}
- (void)storeIsloginToLocal
{
    [XBAppTool storeObject:@(_isLogined) storeKey:xb_key_isLogined];
}
- (BOOL)getStoreIsloginToLocal
{
    return [[XBAppTool getObjectForKey:xb_key_isLogined] boolValue];
}
@end

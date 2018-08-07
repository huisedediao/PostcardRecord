//
//  XBAlertView_login.m
//  PostcardRecord
//
//  Created by xxb on 2018/8/7.
//  Copyright © 2018年 xxb. All rights reserved.
//

#import "XBAlertView_login.h"

@interface XBAlertView_login ()
@property (nonatomic,strong) UITextField *tf_userName;
@property (nonatomic,strong) UITextField *tf_pwd;
@end

@implementation XBAlertView_login

- (void)actionBeforeShow
{
    [super actionBeforeShow];
    
    CGSize size = CGSizeMake(160, 100);
    
    UIView *customView = [UIView new];
    customView.frame = CGRectMake(0, 0, size.width, size.height);
    
    UITextField *tf_userName = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, 140, 30)];
    self.tf_userName = tf_userName;
    [customView addSubview:tf_userName];
    tf_userName.font = UIFont(12);
    tf_userName.textAlignment = NSTextAlignmentCenter;
    tf_userName.placeholder = XBText_请输入用户名;
    tf_userName.backgroundColor = XBColor_gray_240_240_240;
    
    UITextField *tf_pwd = [[UITextField alloc] initWithFrame:CGRectMake(10, 10 +30, 140, 30)];
    self.tf_pwd = tf_pwd;
    [customView addSubview:tf_pwd];
    tf_pwd.font = UIFont(12);
    tf_pwd.textAlignment = NSTextAlignmentCenter;
    tf_pwd.placeholder = XBText_请输入密码;
    tf_pwd.backgroundColor = XBColor_gray_240_240_240;
    
    [self customView:customView size:size];
    
    [tf_userName becomeFirstResponder];
}

- (NSString *)userName
{
    return _tf_userName.text;
}

- (NSString *)pwd
{
    return _tf_pwd.text;
}

@end

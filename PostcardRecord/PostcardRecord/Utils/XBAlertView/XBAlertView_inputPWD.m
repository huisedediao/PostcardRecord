//
//  XBAlertView_inputPWD.m
//  ip116_plus
//
//  Created by xxb on 2017/8/16.
//  Copyright © 2017年 DreamCatcher. All rights reserved.
//

#import "XBAlertView_inputPWD.h"

@interface XBAlertView_inputPWD () <XBAlertViewDelegate>
@property (nonatomic ,strong) UITextField *tf_pwd;
@end

@implementation XBAlertView_inputPWD
- (NSString *)str_text
{
    return self.tf_pwd.text;
}
- (void)show
{
    if (self.v_custom == nil)
    {
        UITextField *_passwordTexF = [[UITextField alloc] init];
        [self addSubview:_passwordTexF];
        self.tf_pwd = _passwordTexF;
        
        _passwordTexF.placeholder = XBText_名称;
        _passwordTexF.font = UIFont(14);
        _passwordTexF.layer.masksToBounds = YES;
        _passwordTexF.backgroundColor = [UIColor whiteColor];
        _passwordTexF.layer.borderColor = [[UIColor grayColor] colorWithAlphaComponent:0.3].CGColor;
        _passwordTexF.layer.borderWidth = 0.5;
        _passwordTexF.layer.cornerRadius = 2;
    
        
        _passwordTexF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 10)];
        _passwordTexF.leftViewMode = UITextFieldViewModeAlways;
        
        [self customView:_passwordTexF size:CGSizeZero];
        [self.v_custom mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.equalTo(self.v_custom.superview);
            make.bottom.lessThanOrEqualTo(self.v_custom.superview).offset(0);
            make.trailing.lessThanOrEqualTo(self.v_custom.superview).offset(0);
            make.height.mas_equalTo(44);
            make.width.greaterThanOrEqualTo(self).offset(-30);
        }];
    }
    
    self.delegate = self;
    [super show];
}

- (void)hidden
{
    self.tf_pwd.hidden = YES;
    [super hidden];
}

- (void)handleReturnInfoBtnAction:(UIButton *)btn
{
    btn.selected = !btn.selected;
    self.tf_pwd.secureTextEntry = !self.tf_pwd.secureTextEntry;
}

- (void)alertView:(XBAlertView *)alertView clickedBtnAtIndex:(NSInteger)btnIndex
{
    if (btnIndex == 1)
    {
        WEAK_SELF
        if (self.bl_ok)
        {
            self.bl_ok(weakSelf);
        }
    }
}

@end

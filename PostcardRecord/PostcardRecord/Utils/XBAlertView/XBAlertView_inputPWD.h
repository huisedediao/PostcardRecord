//
//  XBAlertView_inputPWD.h
//  ip116_plus
//
//  Created by xxb on 2017/8/16.
//  Copyright © 2017年 DreamCatcher. All rights reserved.
//

#import "XBAlertView.h"

@class XBAlertView_inputPWD;

typedef void (^XBAlertView_inputPWDBlock)(XBAlertView_inputPWD *alertView);

@interface XBAlertView_inputPWD : XBAlertView
@property (nonatomic,copy,readonly) NSString *str_text;
@property (nonatomic,copy) XBAlertView_inputPWDBlock bl_ok;
@end

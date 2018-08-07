//
//  XBAlertView_MsgLeft.m
//  AnXin
//
//  Created by xxb on 2018/2/1.
//  Copyright © 2018年 xxb. All rights reserved.
//

#import "XBAlertView_MsgLeft.h"
#import "NSMutableAttributedString+XBExtension.h"

@implementation XBAlertView_MsgLeft

- (void)actionBeforeShow
{
    [super actionBeforeShow];
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:self.str_message];
    [attStr xb_setLineSpace:6 range:xb_textRange];
    
    self.lb_message.textAlignment = NSTextAlignmentLeft;
    self.lb_message.attributedText = attStr;
}
- (void)hidden
{
    if (self.doNotHiddenWhenClick)
    {
        
    }
    else
    {
        [super hidden];
    }
}

@end

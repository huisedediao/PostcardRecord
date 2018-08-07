//
//  BaseViewController.m
//  aw1_plus
//
//  Created by sven on 12/12/2016.
//  Copyright © 2016 sven. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self buildUI];
}
-(void)buildUI
{
    self.view.backgroundColor = XBColor_viewBackground;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self resizeForIOS7];
    }
    return self;
}

#pragma mark - methods

- (void)resizeForIOS7{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;
#endif
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


@end

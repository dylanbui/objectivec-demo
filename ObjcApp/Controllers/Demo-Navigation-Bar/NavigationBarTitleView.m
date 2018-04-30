//
//  NavigationBarTitleView.m
//  ObjcApp
//
//  Created by Dylan Bui on 8/20/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "NavigationBarTitleView.h"

@implementation NavigationBarTitleView

- (id)initWithViewController:(UIViewController *)containerViewController
{
    if (self = [super init]) {
        self.vclContainer = containerViewController;
        [self initView];
    }
    
    return self;
}

- (void)initView
{
    // -- Navigation frame --
    CGRect viewFrame = (CGRect){
        .origin = {30, 0},
        //.size.width = 250,//[[UIScreen mainScreen] bounds].size.width,
        .size.width = [[UIScreen mainScreen] bounds].size.width - 30,
        .size.height = self.frame.size.height
    };
    // self.frame = (CGRect) {0, 0, [[UIScreen mainScreen] bounds].size.width, 44};
    self.frame = viewFrame;
    
    // -- Turn off back button --
//    self.vclContainer.navigationItem.hidesBackButton = YES;
    // -- Set empty back title --
    self.vclContainer.navigationController.navigationBar.topItem.title = @" ";
//    self.vclContainer.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
//                                                                                          style:UIBarButtonItemStylePlain
//                                                                                         target:nil
//                                                                                         action:nil];
    
//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -140) forBarMetrics:UIBarMetricsDefault];
    
    // -- Hide all control --
    [self hideAllItemNavigationBar];
    
    // self.backgroundColor = [self.vclContainer.navigationController.navigationBar barTintColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(controllerViewDidLoad:)
                                                 name:NOTIFY_VCL_DID_LOAD object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(controllerViewWillAppear:)
                                                 name:NOTIFY_VCL_WILL_APPEAR object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(controllerViewWillDisappear:)
                                                 name:NOTIFY_VCL_WILL_DISAPPEAR object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)controllerViewDidLoad:(NSNotification *)notification
{
    if ([notification.object isEqual:self.vclContainer]) {
//        NSLog(@"frame = %@", NSStringFromCGRect(self.vclContainer.navigationItem.titleView.frame));
//        self.vclContainer.navigationItem.titleView = self;
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0 ,0 ,280 ,44)];
//        label.backgroundColor = [UIColor redColor];
//        label.font = [UIFont fontWithName:@"GoodMobiPro-CondBold" size:24];
//        label.textAlignment = NSTextAlignmentCenter;
//        self.vclContainer.navigationItem.titleView = label;
//        label.text = @"My Custom Title";
//        [label sizeToFit];
        
        // -- Config NavigationBar Back button (Change icon) --
        UIImage *backBtn = [UIImage imageNamed:@"iconIosBack"];
        backBtn = [backBtn imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //     self.navigationItem.backBarButtonItem.title = @"";
        //    self.navigationController.navigationBar.topItem.title = @"";
        
        self.vclContainer.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                                 style:UIBarButtonItemStylePlain
                                                                                target:nil
                                                                                action:nil];
        
        self.vclContainer.navigationController.navigationBar.tintColor = [UIColor clearColor];
        self.vclContainer.navigationController.navigationBar.backIndicatorImage = backBtn;
        self.vclContainer.navigationController.navigationBar.backIndicatorTransitionMaskImage = backBtn;
        
    }
}

- (void)controllerViewWillAppear:(NSNotification *)notification
{
    if ([notification.object isEqual:self.vclContainer]) {
        NSLog(@"%@", @"controllerViewWillAppear");
        // NSLog(@"frame = %f",self.vclContainer.navigationController.navigationItem.rightBarButtonItem.width);
        // NSLog(@"%@", NSStringFromCGRect(self.vclContainer.navigationItem.leftBarButtonItem.customView.frame));
        
//        NSArray *classNamesToReposition = @[@"UINavigationItemView", @"UINavigationButton"];
//        for (UIView *view in [self.vclContainer.navigationController.navigationBar subviews]) {
//            NSLog(@"%@", NSStringFromClass([view class]));
//            if ([classNamesToReposition containsObject:NSStringFromClass([view class])]) {
//                CGRect frame = [view frame];
//                NSLog(@" frame = %@", NSStringFromCGRect(frame));
////                frame.origin.y -= VFSNavigationBarHeightIncrease;
////                [view setFrame:frame];
//            }
//        }
        
        [self showNavigation];
    }
}

- (void)controllerViewWillDisappear:(NSNotification *)notification
{
    if ([notification.object isEqual:self.vclContainer]) {
        // NSLog(@"%@", @"controllerViewWillDisappear");
        [self hideNavigation];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (IBAction)btnBack_Click:(id)sender
{
    [self.vclContainer.navigationController popViewControllerAnimated:YES];
}

- (void)showNavigation
{
    [self.vclContainer.navigationController.navigationBar addSubview:self];
//    NSLog(@"frame = %@", NSStringFromCGRect(self.vclContainer.navigationItem.titleView.frame));
//    self.vclContainer.navigationItem.titleView = self;
    
    self.alpha = 0.5;
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 animations:^{
            [self showAllItemNavigationBar];
        }];
    }];
}

- (void)hideNavigation
{
    [UIView animateWithDuration:0.4 animations:^{
        [self hideAllItemNavigationBar];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }];
}


- (void)hideAllItemNavigationBar
{
    for (UIView *viewControl in self.subviews) {
        if ([viewControl isKindOfClass:[UILabel class]]) {
            viewControl.alpha = 0;
            viewControl.tag = viewControl.frame.origin.x;
            viewControl.frame = (CGRect) {viewControl.frame.origin.x + 100, viewControl.frame.origin.y, viewControl.frame.size};
        } else if ([viewControl isKindOfClass:[UIButton class]] || [viewControl isKindOfClass:[UIBarButtonItem class]]) {
            viewControl.alpha = 0;
        }
    }
}

- (void)showAllItemNavigationBar
{
    for (UIView *viewControl in self.subviews) {
        if ([viewControl isKindOfClass:[UILabel class]]) {
            viewControl.alpha = 1;
            viewControl.frame = (CGRect) {viewControl.tag, viewControl.frame.origin.y, viewControl.frame.size};
        } else if ([viewControl isKindOfClass:[UIButton class]] || [viewControl isKindOfClass:[UIBarButtonItem class]]) {
            viewControl.alpha = 1;
        }
    }
}

@end


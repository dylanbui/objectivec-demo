//
//  BasePopupView.m
//  PropzyDiy
//
//  Created by Dylan Bui on 7/18/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "DbPopupView.h"

@interface DbPopupView() {
    UIView *vwBg;
}

@end

@implementation DbPopupView

- (instancetype)init
{
    self = [super init];
    [self setupBgViews];
    return self;
}

- (id)initWithHandleViewAction:(HandleViewAction)handle
{
    self = [super initWithHandleViewAction:handle];
    [self setupBgViews];
    return self;
}

- (void)setupBgViews
{
    UIScreen *mainScreen =  [UIScreen mainScreen];
    
    CGRect frame = (CGRect){
        .origin = mainScreen.bounds.origin,
        .size.width = mainScreen.bounds.size.width,
        .size.height = mainScreen.bounds.size.height + 50,
    };
    
    vwBg = [[UIView alloc] initWithFrame:frame];
    
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    [visualEffectView setFrame:vwBg.bounds];
    [vwBg addSubview:visualEffectView];
    [vwBg setAlpha:1.0];
    
    [self insertSubview:vwBg belowSubview:self.vwContent];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.vwContent.layer setMasksToBounds:YES];
    [self.vwContent.layer setCornerRadius:6.0f];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPopup)];
    [vwBg addGestureRecognizer:tap];
}

- (void)showPopup
{
    [self showPopupWithCompletion:nil];
}

- (void)showPopupWithCompletion:(void (^ __nullable)(BOOL finished))completion
{
    UIViewController *topViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIView *toView = topViewController.view;

    self.frame = CGRectMake(0, -20, toView.frame.size.width, toView.frame.size.height);
    [self layoutIfNeeded];
    [self setAlpha:0.0];
    [toView addSubview:self];
    
    [UIView animateWithDuration:0.35 animations:^{
        [self setAlpha:1.0];
        self.frame = CGRectMake(0, 0, toView.frame.size.width, toView.frame.size.height);
    } completion:^(BOOL finished) {
        if (completion)
            completion(finished);
    }];
}

- (void)dismissPopup
{
    [self dismissPopupWithCompletion:nil];
}

- (void)dismissPopupWithCompletion:(void (^ __nullable)(BOOL finished))completion
{
    [UIView animateWithDuration:0.35 animations:^{
        [self setAlpha:0.0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (completion)
            completion(finished);
    }];

}




@end

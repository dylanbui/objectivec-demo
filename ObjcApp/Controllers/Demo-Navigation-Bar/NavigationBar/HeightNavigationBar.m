//
//  HeightNavigationBar.m
//  ObjcApp
//
//  Created by Dylan Bui on 8/16/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "HeightNavigationBar.h"

@interface HeightNavigationBar ()


@end

@implementation HeightNavigationBar

- (id)initWithViewController:(UIViewController *)containerViewController
{
    if (self = [super initWithViewController:containerViewController])
    {
        [self initNavigation];
    }
    return self;
}

- (void)initNavigation
{
//    self.navigationBar = [[self.vclContainer navigationController] navigationBar];
    
}

- (void)showNavigation
{
//    UINavigationBar *navigationBar = [[self.vclContainer navigationController] navigationBar];
//    CGRect frame = [navigationBar frame];
//    frame.size.height = 65.0f;
//    [navigationBar setFrame:frame];
//    
//    [super showNavigation];

    // -- Chinh chieu cao cua Navigator Bar --
    // -- Goi hien thi Navigator Bar o super class--
    [UIView animateWithDuration:0.3 animations:^{
        UINavigationBar *navigationBar = [[self.vclContainer navigationController] navigationBar];
        CGRect frame = [navigationBar frame];
        frame.size.height = 65.0f;
        [navigationBar setFrame:frame];
    } completion:^(BOOL finished) {
//        [super showNavigation];
        
        [self.vclContainer.navigationController.navigationBar addSubview:self];
        [self showAllItemNavigationBar];
//        [UIView animateWithDuration:0.4 animations:^{
//            [self showAllItemNavigationBar];
//        }];
        
//        self.alpha = 0.5;
//        [UIView animateWithDuration:0.1 animations:^{
//            self.alpha = 1;
//        } completion:^(BOOL finished) {
//            [UIView animateWithDuration:0.4 animations:^{
//                [self showAllItemNavigationBar];
//            }];
//        }];
        
    }];
}


- (void)hideNavigation
{
//    UINavigationBar *navigationBar = [[self.vclContainer navigationController] navigationBar];
//    CGRect frame = [navigationBar frame];
//    frame.size.height = 44.0f;
//    [navigationBar setFrame:frame];
//    
//    [super hideNavigation];
    
    // -- Chinh chieu cao cua Navigator Bar --
    // -- Goi hien thi Navigator Bar o super class--
    [UIView animateWithDuration:0.3 animations:^{
        UINavigationBar *navigationBar = [[self.vclContainer navigationController] navigationBar];
        CGRect frame = [navigationBar frame];
        frame.size.height = 44.0f;
        [navigationBar setFrame:frame];
        
        //[super hideNavigation];
        
        [UIView animateWithDuration:0.1 animations:^{
            [self hideAllItemNavigationBar];
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
        
    } completion:^(BOOL finished) {
        
    }];
    
}

// -- Override Parent Functions --
- (void)showAllItemNavigationBar
{
    self.vwBarContent.alpha = 1;
    self.vwBarContent.frame = (CGRect) {self.vwBarContent.tag, self.vwBarContent.frame.origin.y, self.vwBarContent.frame.size};
}
// -- Override Parent Functions --
- (void)hideAllItemNavigationBar
{
    self.vwBarContent.alpha = 0;
    self.vwBarContent.tag = self.vwBarContent.frame.origin.x;
    self.vwBarContent.frame = (CGRect) {self.vwBarContent.frame.origin.x, self.vwBarContent.frame.origin.y, self.vwBarContent.frame.size};
}

@end

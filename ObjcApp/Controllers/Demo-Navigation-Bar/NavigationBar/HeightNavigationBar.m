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

    [UIView animateWithDuration:0.3 animations:^{
        UINavigationBar *navigationBar = [[self.vclContainer navigationController] navigationBar];
        CGRect frame = [navigationBar frame];
        frame.size.height = 65.0f;
        [navigationBar setFrame:frame];
    } completion:^(BOOL finished) {
        [super showNavigation];
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
    
    [UIView animateWithDuration:0.3 animations:^{
        UINavigationBar *navigationBar = [[self.vclContainer navigationController] navigationBar];
        CGRect frame = [navigationBar frame];
        frame.size.height = 44.0f;
        [navigationBar setFrame:frame];
        [super hideNavigation];
    } completion:^(BOOL finished) {
        
    }];
    
}



@end

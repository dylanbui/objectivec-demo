//
//  NavigationBarBaseView.h
//  PropzyPama
//
//  Created by Dylan Bui on 8/11/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "DbViewFromXib.h"
#import "DbConstant.h"

/*
 
 - (void)viewWillAppear:(BOOL)animated
 {
     [super viewWillAppear:animated];
     if (self.navBaseView) {
        [self.navBaseView showNavigation];
     }
 }
 
 - (void)viewWillDisappear:(BOOL)animated
 {
     [super viewWillDisappear:animated];
     if (self.navBaseView) {
        [self.navBaseView hideNavigation];
     }
 }
 
 */


@interface DbNavigationBarView : DbViewFromXib

@property (nonatomic, weak) UIViewController *vclContainer;

@property (weak, nonatomic) IBOutlet UIButton *btnBack;

- (id)initWithViewController:(UIViewController *)containerViewController;

- (void)showNavigation;
- (void)hideNavigation;

@end

@interface DbNavigationBarView (Protected)

- (void)showNavigation;
- (void)hideNavigation;

- (void)hideAllItemNavigationBar;
- (void)showAllItemNavigationBar;

@end

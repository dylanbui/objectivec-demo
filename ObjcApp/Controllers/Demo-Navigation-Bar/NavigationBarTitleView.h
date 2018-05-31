//
//  NavigationBarTitleView.h
//  ObjcApp
//
//  Created by Dylan Bui on 8/20/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "DbViewFromXib.h"
#import "DbConstant.h"

// -- Demo : Khong ke thua tu lop goc --

@interface NavigationBarTitleView : DbViewFromXib

@property (nonatomic, weak) UIViewController *vclContainer;

@property (weak, nonatomic) IBOutlet UIView *vwBarContent;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;

- (id)initWithViewController:(UIViewController *)containerViewController;

- (void)showNavigation;
- (void)hideNavigation;

@end

@interface NavigationBarTitleView (Protected)

- (void)hideAllItemNavigationBar;
- (void)showAllItemNavigationBar;

@end


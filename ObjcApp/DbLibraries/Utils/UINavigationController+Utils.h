//
//  UINavigationController+Utils.h
//  SAM_Demo
//
//  Created by Dylan Bui on 12/30/16.
//  Copyright © 2016 Dylan Bui. All rights reserved.
//  Add more from : https://github.com/AlbertMontserrat/UINavigationController-gamefade

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


@interface UINavigationController (Flatten)

#pragma mark - Base DucBui

- (UIViewController *)getCurrentViewController;

- (void)replaceCurrentViewController:(UIViewController*)replaceViewController animated:(BOOL)animated;

- (void)pushOrReplaceToFirstViewController:(UIViewController *)replaceViewController animated:(BOOL)animated;

- (void)popToFirstViewControllerWithAnimated:(BOOL)animated;

- (void)pushArrayViewControllerToFirstViewController:(NSArray *)arrViewController withAnimated:(BOOL)animated;

#pragma mark - Push

- (void)pushFadeViewController:(UIViewController *)viewController;

- (void)pushFadeViewController:(UIViewController *)viewController duration:(CGFloat)seconds;

#pragma mark - Pop

- (void)popFadeViewController;

- (void)popFadeViewControllerWithDuration:(CGFloat)seconds;

- (void)popFadeToFirstViewControllerWithAnimated;

- (void)popFadeToRootViewController;

- (void)popFadeToRootViewControllerWithDuration:(CGFloat)seconds;

#pragma mark - Replace

- (void)replaceFadeFirstViewController:(UIViewController *)controller;

- (void)replaceFadeCurrentViewControllerWithViewController:(UIViewController *)controller;

- (void)replaceFadeCurrentViewControllerWithViewController:(UIViewController *)controller withDuration:(CGFloat)seconds;

- (void)replaceFadeCountViewControllers:(int)numViewControllersToReplace
                     withViewController:(UIViewController *)controller;

- (void)replaceFadeCountViewControllers:(int)numViewControllersToReplace
                     withViewController:(UIViewController *)controller
                           withDuration:(CGFloat)seconds;

@end

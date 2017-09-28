//
//  UINavigationController+Utils.h
//  SAM_Demo
//
//  Created by Dylan Bui on 12/30/16.
//  Copyright © 2016 Dylan Bui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


@interface UINavigationController (Flatten)

- (UIViewController *)getCurrentViewController;

- (void)replaceCurrentViewController:(UIViewController*) replaceViewController animated:(BOOL)animated;

- (void)pushOrReplaceToFirstViewController:(UIViewController *)replaceViewController animated:(BOOL)animated;

- (void)popToFirstViewControllerWithAnimated:(BOOL)animated;

- (void)pushArrayViewControllerToFirstViewController:(NSArray *)arrViewController withAnimated:(BOOL)animated;


@end

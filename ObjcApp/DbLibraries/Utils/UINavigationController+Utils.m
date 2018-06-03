//
//  UINavigationController+Utils.m
//  SAM_Demo
//
//  Created by Dylan Bui on 12/30/16.
//  Copyright © 2016 Dylan Bui. All rights reserved.
//

#import "UINavigationController+Utils.h"

@implementation UINavigationController (Utils)

- (UIViewController *)getCurrentViewController
{
    return [self.viewControllers lastObject];
}

- (void)replaceCurrentViewController:(UIViewController*) replaceViewController animated:(BOOL)animated
{
    NSArray *viewControllers = [self viewControllers];
    NSMutableArray *editableViewControllers = [NSMutableArray arrayWithArray:viewControllers];
    [editableViewControllers removeLastObject];
    [editableViewControllers addObject:replaceViewController];
    [self setViewControllers:editableViewControllers animated:YES];
}

- (void)pushOrReplaceToFirstViewController:(UIViewController *)replaceViewController animated:(BOOL)animated
{
    if ([[self viewControllers] count] > 1)
    {
        [self pushArrayViewControllerToFirstViewController:@[replaceViewController] withAnimated:animated];
        //[self replaceCurrentViewController:replaceViewController animated:animated];
    } else {
        [self pushViewController:replaceViewController animated:animated];
    }
}

- (void)popToFirstViewControllerWithAnimated:(BOOL)animated
{
    if ([[self viewControllers] count] > 1)
    {
        [self popToViewController:[self.viewControllers objectAtIndex:1] animated:animated];
    }
}

- (void)pushArrayViewControllerToFirstViewController:(NSArray *)arrViewController withAnimated:(BOOL)animated
{
    NSMutableArray *editableViewControllers = [NSMutableArray arrayWithObjects:[[self viewControllers] firstObject], nil];
    [editableViewControllers addObjectsFromArray:arrViewController];
    [self setViewControllers:editableViewControllers animated:animated];
}


@end

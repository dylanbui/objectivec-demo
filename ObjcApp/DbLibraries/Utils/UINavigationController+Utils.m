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

#pragma mark - Push

- (void)pushFadeViewController:(UIViewController *)viewController
{
    [self pushFadeViewController:viewController duration:0.3f];
}

- (void)pushFadeViewController:(UIViewController *)viewController duration:(CGFloat)seconds
{
    CATransition *transition = [CATransition animation];
    transition.duration = seconds;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    [self.view.layer addAnimation:transition forKey:nil];
    
    [self pushViewController:viewController animated:NO];
}

#pragma mark - Pop

- (void)popFadeViewController
{
    [self popFadeViewControllerWithDuration:0.3f];
}

- (void)popFadeViewControllerWithDuration:(CGFloat)seconds
{
    CATransition *transition = [CATransition animation];
    transition.duration = seconds;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    [self.view.layer addAnimation:transition forKey:nil];
    
    [self popViewControllerAnimated:NO];
}

- (void)popFadeToRootViewController
{
    [self popFadeToRootViewControllerWithDuration:0.3f];
}

- (void)popFadeToRootViewControllerWithDuration:(CGFloat)seconds
{
    CATransition *transition = [CATransition animation];
    transition.duration = seconds;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    [self.view.layer addAnimation:transition forKey:nil];
    
    [self popToRootViewControllerAnimated:NO];
}

- (void)popFadeToFirstViewControllerWithAnimated
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    [self.view.layer addAnimation:transition forKey:nil];
    
    [self popToFirstViewControllerWithAnimated:NO];
}

#pragma mark - Replace

- (void)replaceFadeFirstViewController:(UIViewController *)controller
{
    CATransition *transition = [CATransition animation];
    transition.duration = 3.0f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    [self.view.layer addAnimation:transition forKey:nil];

    [self pushArrayViewControllerToFirstViewController:@[controller] withAnimated:NO];
}

- (void)replaceFadeCurrentViewControllerWithViewController:(UIViewController *)controller
{
    [self replaceFadeCountViewControllers:1 withViewController:controller withDuration:0.3];
}

- (void)replaceFadeCurrentViewControllerWithViewController:(UIViewController *)controller
                                              withDuration:(CGFloat)seconds
{
    [self replaceFadeCountViewControllers:1 withViewController:controller withDuration:seconds];
}

- (void)replaceFadeCountViewControllers:(int)numViewControllersToReplace
                     withViewController:(UIViewController *)controller
{
    [self replaceFadeCountViewControllers:numViewControllersToReplace withViewController:controller withDuration:0.3];
}

- (void)replaceFadeCountViewControllers:(int)numViewControllersToReplace
                     withViewController:(UIViewController *)controller
                           withDuration:(CGFloat)seconds
{
    
    NSMutableArray *controllers = [NSMutableArray arrayWithArray:self.viewControllers];
    
    int controllerIndex = (int)controllers.count-numViewControllersToReplace;
    if(controllerIndex < 0)
        controllerIndex = 0;
    
    [controllers insertObject:controller atIndex:controllerIndex];
    [self setViewControllers:controllers animated:NO];
    
    CATransition *transition = [CATransition animation];
    transition.duration = seconds;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    [self.view.layer addAnimation:transition forKey:nil];
    
    [self popToViewController:controller animated:NO];
    
}

@end

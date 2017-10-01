//
//  TBTabbarViewController.m
//  ObjcApp
//
//  Created by Dylan Bui on 9/28/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "TBTabbarViewController.h"

#import "TBOneViewController.h"
#import "TBTwoViewController.h"
#import "TBThreeViewController.h"
#import "TBFourViewController.h"

@interface TBTabbarViewController () {
    
    NSMutableArray *arrControllers;
    
}

@end

@implementation TBTabbarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UINavigationController *navigationController = nil;
    arrControllers = [[NSMutableArray alloc] init];
    
    // ---------------------
    
    TBOneViewController* taskViewController = [[TBOneViewController alloc] init];
    // taskViewController.edgesForExtendedLayout = UIRectEdgeNone; // Fix under navigation bar or tabbar
    navigationController = [[UINavigationController alloc] initWithRootViewController:taskViewController];
    navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    UITabBarItem* One = [[UITabBarItem alloc] init];
    //    [listing setImage:[UIImage imageNamed:@"today.png"]];
    [One setTitle:@"One"];
    navigationController.tabBarItem = One;

    [arrControllers addObject:navigationController];
    navigationController = nil;
    
    // ---------------------
    
    TBTwoViewController* chartViewController = [[TBTwoViewController alloc] init];
    // chartViewController.edgesForExtendedLayout = UIRectEdgeNone; // Fix under navigation bar or tabbar
    navigationController = [[UINavigationController alloc] initWithRootViewController:chartViewController];
    navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    UITabBarItem* Two = [[UITabBarItem alloc] init];
    //    [listing setImage:[UIImage imageNamed:@"today.png"]];
    [Two setTitle:@"Two"];
    navigationController.tabBarItem = Two;
    
    [arrControllers addObject:navigationController];
    navigationController = nil;
    
    // ---------------------
    
    TBThreeViewController* notificationViewController = [[TBThreeViewController alloc] init];
    // notificationViewController.edgesForExtendedLayout = UIRectEdgeNone; // Fix under navigation bar or tabbar
    navigationController = [[UINavigationController alloc] initWithRootViewController:notificationViewController];
    navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    UITabBarItem* Three = [[UITabBarItem alloc] init];
    //    [listing setImage:[UIImage imageNamed:@"today.png"]];
    [Three setTitle:@"Three"];
    navigationController.tabBarItem = Three;
    
    [arrControllers addObject:navigationController];
    navigationController = nil;
    
    // ---------------------
    
    TBFourViewController* profileViewController = [[TBFourViewController alloc] init];
    //profileViewController.edgesForExtendedLayout = UIRectEdgeNone; // Fix under navigation bar or tabbar
    navigationController = [[UINavigationController alloc] initWithRootViewController:profileViewController];
    navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    UITabBarItem* Four = [[UITabBarItem alloc] init];
    //    [listing setImage:[UIImage imageNamed:@"today.png"]];
    [Four setTitle:@"Four"];
    navigationController.tabBarItem = Four;
    
    [arrControllers addObject:navigationController];
    navigationController = nil;
    
    // ---------------------
    
    tabBarController = [[UITabBarController alloc] init];
    tabBarController.view.frame = self.view.frame;
    tabBarController.viewControllers = arrControllers;
    tabBarController.delegate = self;
    [self.view addSubview: [tabBarController view]];
    
}

#pragma mark -
#pragma UITabbarController implement

- (BOOL)tabBarController:(UITabBarController *)atabBarController shouldSelectViewController:(UIViewController *)viewController
{
    // http://stackoverflow.com/questions/5161730/iphone-how-to-switch-tabs-with-an-animation
    NSUInteger controllerIndex = [arrControllers indexOfObject:viewController];
    
    if (controllerIndex == atabBarController.selectedIndex) {
        return NO;
    }
    
    // Get the views.
    UIView *fromView = atabBarController.selectedViewController.view;
    UIView *toView = [atabBarController.viewControllers[controllerIndex] view];
    
    // Get the size of the view area.
    CGRect viewSize = fromView.frame;
    BOOL scrollRight = controllerIndex > atabBarController.selectedIndex;
    
    // Add the to view to the tab bar view.
    [fromView.superview addSubview:toView];
    
    // Position it off screen.
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat padding = 50;
    toView.frame = CGRectMake((scrollRight ? padding : -padding), viewSize.origin.y, screenWidth, viewSize.size.height);
    
    toView.alpha = 0.2;
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         // Animate the views on and off the screen. This will appear to slide.
                         //fromView.frame = CGRectMake((scrollRight ? -padding : padding), viewSize.origin.y, screenWidth, viewSize.size.height);
                         fromView.alpha = 0.2;
                         
                         toView.frame = CGRectMake(0, viewSize.origin.y, screenWidth, viewSize.size.height);
                         toView.alpha = 1.0;
                     }
     
                     completion:^(BOOL finished) {
                         if (finished) {
                             
                             // Remove the old view from the tabbar view.
                             [fromView removeFromSuperview];
                             fromView.alpha = 1.0;
                             atabBarController.selectedIndex = controllerIndex;
                         }
                     }];
    
    return NO;
}

- (void)tabBarController:(UITabBarController *)atabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
    
}

- (void)tabBarController:(UITabBarController *)atabBarController didSelectViewController:(UIViewController *)viewController
{
    NSLog(@"==============>>>>>>>>>> index: %lu " , (unsigned long)tabBarController.selectedIndex);
}


@end

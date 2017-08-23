//
//  BaseAppDelegate.h
//  PropzyTenant
//
//  Created by Dylan Bui on 5/19/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class RootViewController;

@interface DbAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) RootViewController *rootViewController;

@end


//
//  AppDelegate.m
//  ObjcApp
//
//  Created by Dylan Bui on 8/16/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "AppDelegate.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>

#import "UserSession.h"

@import GoogleMaps;
@import GooglePlaces;

#import "TaskManager.h"
#import "UpdateCountryUnitTask.h"
#import "UpdateTaskHard.h"
#import "UpdateTaskOther.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [super application:application didFinishLaunchingWithOptions:launchOptions];
    
    // -- Fabric attack with Gooogle Firebase --
    [Fabric with:@[[Crashlytics class]]];
    
    // -- Google map --
    [GMSServices provideAPIKey:@"AIzaSyBK_MVp9sT3n-klZ4BIMnKHi1cjHJyYNFA"];
    [GMSPlacesClient provideAPIKey:@"AIzaSyBK_MVp9sT3n-klZ4BIMnKHi1cjHJyYNFA"];
    
    [[UserSession instance] sessionStart];
    
    //ONE LINE OF CODE.
    //Enabling keyboard manager(Use this line to enable managing distance between keyboard & textField/textView).
    [[IQKeyboardManager sharedManager] setEnable:YES];
    
    //(Optional)Set Distance between keyboard & textField, Default is 10.
    //[[IQKeyboardManager sharedManager] setKeyboardDistanceFromTextField:15];
    
    //(Optional)Enable autoToolbar behaviour. If It is set to NO. You have to manually create UIToolbar for keyboard. Default is NO.
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    
    [[IQKeyboardManager sharedManager] setShouldShowTextFieldPlaceholder:YES];
    
    TaskManager *taskManager = [TaskManager sharedInstance];
    [taskManager addExtendRunMode:@[NOTIFY_REACHABLE_NETWORK,
                                    @"UPDATE_USER_INFORMATION"]];
    
    UpdateCountryUnitTask *task_1 = [[UpdateCountryUnitTask alloc] init];
    [taskManager subscribeTask:task_1];
    
    UpdateTaskHard *task_2 = [[UpdateTaskHard alloc] init];
    [taskManager subscribeTask:task_2];
    
    UpdateTaskOther *task_3 = [[UpdateTaskOther alloc] init];
    [taskManager subscribeTask:task_3];
    
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [super applicationDidBecomeActive:application];
    
    
}


@end

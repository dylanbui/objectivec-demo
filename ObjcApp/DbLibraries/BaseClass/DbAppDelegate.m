//
//  BaseAppDelegate.m
//  PropzyTenant
//
//  Created by Dylan Bui on 5/19/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "DbAppDelegate.h"

#import "DbConstant.h"
#import "DbUtils.h"

#import "DbAppSession.h"

#import <AudioToolbox/AudioToolbox.h>
#import <UserNotifications/UserNotifications.h>
#import <ISMessages/ISMessages.h>

#import "AFNetworkReachabilityManager.h"
#import "DbWebConnection.h"

@interface DbAppDelegate () <UNUserNotificationCenterDelegate>

@end

@implementation DbAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    if (APPLE_PUSH_NOTIFICATION_REQUEST) {
        // -- Push notification --
        [self registerForRemoteNotification];
    }

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // -- Set badge number = 0 --
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    // -- Detect Network Connection --
    // Starts monitoring network reachability status changes
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
        // -- Set network connection status for WebServiceClient --
        DbWebConnection *webServiceClient = [DbWebConnection instance];
        webServiceClient.isReachable = [[AFNetworkReachabilityManager sharedManager] isReachable];
        if (status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi ) {
            // NSLog(@"connection");
            [DbUtils postNotification:NOTIFY_REACHABLE_NETWORK object:nil userInfo:nil];
        }
        else {
            // -- Show network connection alert --
            [DbUtils showSettingsNetworkConnection:[UIApplication sharedApplication].keyWindow.rootViewController];
        }
    }];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Remote Notification Delegate // <= iOS 9.x

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *strDevicetoken = [[NSString alloc]initWithFormat:@"%@",[[[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]] stringByReplacingOccurrencesOfString:@" " withString:@""]];
    NSLog(@"Device Token = %@",strDevicetoken);
    [[DbAppSession instance] setDevicePushNotificationToken:strDevicetoken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"%@ = %@", NSStringFromSelector(_cmd), error);
    NSLog(@"Error = %@",error);
}


#pragma mark - Remote Notification Delegate // <= iOS 9.x

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:(nonnull void (^)(UIBackgroundFetchResult))completionHandler
{
    NSMutableDictionary *dictUserInfo = [[NSMutableDictionary alloc] initWithDictionary:userInfo];
    [dictUserInfo setObject:[NSNumber numberWithInt:[[UIApplication sharedApplication] applicationState]]
                     forKey:@"applicationState"];
    [dictUserInfo setObject:[NSNumber numberWithBool:YES]
                     forKey:@"clickState"];
    
    if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive)
    {
        AudioServicesPlaySystemSound(1007);
        ISMessages *alert = [ISMessages cardAlertWithTitle:@"TAP" message:[userInfo valueForKeyPath:@"aps.alert"] iconImage:[UIImage imageNamed:@"icon_app"] duration:5.f hideOnSwipe:YES hideOnTap:YES alertType:ISAlertTypeCustom alertPosition:ISAlertPositionTop];
        [alert setAlertViewBackgroundColor:[DbUtils colorWithHexString:@"f1f1f1"]];
        [alert setTitleLabelTextColor:[[UIColor blackColor] colorWithAlphaComponent:0.87]];
        [alert setMessageLabelTextColor:[[UIColor blackColor] colorWithAlphaComponent:0.87]];
        [alert show:^{
            
        } didHide:^(BOOL finished) {
            
        }];
        [dictUserInfo setObject:[NSNumber numberWithBool:NO]
                         forKey:@"clickState"];
        
        [[DbAppSession instance] setPushNotifyInfo:dictUserInfo];
        [DbUtils postNotification:NOTIFY_SERVER_PUSH_MESSAGE object:self userInfo:dictUserInfo];
        return;
    }
    
    if (userInfo != nil) {
        // -- Set BadgeNumber --
        // int badge = [[userInfo valueForKeyPath:@"aps.badge"] intValue];
        // [UIApplication sharedApplication].applicationIconBadgeNumber += badge;
        
        [DbUtils delayCallback:^{
            [[DbAppSession instance] setPushNotifyInfo:dictUserInfo];
            [DbUtils postNotification:NOTIFY_SERVER_PUSH_MESSAGE object:self userInfo:dictUserInfo];
        } forSeconds:0.5];
    }
    // completionHandler(UIBackgroundFetchResultNewData);
    completionHandler(UIBackgroundFetchResultNoData);
}

#pragma mark - Remote Notification Delegate // >= iOS 10.x

// Called when a notification is delivered to a foreground app.
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler
{
    // State => UIApplicationStateActive;
    // NSLog( @"for handling push in foreground" );
//    NSLog(@"User Info : %@",notification.request.content.userInfo);

    AudioServicesPlaySystemSound(1007);
    completionHandler(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge);
    
    NSMutableDictionary *dictUserInfo = [[NSMutableDictionary alloc] initWithDictionary:notification.request.content.userInfo];
    [dictUserInfo setObject:[NSNumber numberWithInt:[[UIApplication sharedApplication] applicationState]]
                     forKey:@"applicationState"];
    [dictUserInfo setObject:[NSNumber numberWithBool:NO]
                     forKey:@"clickState"];
    

    [[DbAppSession instance] setPushNotifyInfo:dictUserInfo];
    [DbUtils postNotification:NOTIFY_SERVER_PUSH_MESSAGE object:self userInfo:dictUserInfo];
}

// Called to let your app know which action was selected by the user for a given notification.
-(void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler
{
    // State => UIApplicationStateBackground;
//    NSLog( @"for handling push in background" );
//    NSLog(@"User Info : %@",[response.notification.request.content.userInfo description]);
    
    // -- Set BadgeNumber --
    int badge = [[response.notification.request.content.userInfo valueForKeyPath:@"aps.badge"] intValue];    
    [UIApplication sharedApplication].applicationIconBadgeNumber += badge;
    
    completionHandler(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge);
    
    NSMutableDictionary *dictUserInfo = [[NSMutableDictionary alloc] initWithDictionary:response.notification.request.content.userInfo];
    [dictUserInfo setObject:[NSNumber numberWithInt:[[UIApplication sharedApplication] applicationState]]
                     forKey:@"applicationState"];
    [dictUserInfo setObject:[NSNumber numberWithBool:YES]
                     forKey:@"clickState"];
    
    [DbUtils delayCallback:^{
        [[DbAppSession instance] setPushNotifyInfo:dictUserInfo];
        [DbUtils postNotification:NOTIFY_SERVER_PUSH_MESSAGE object:self userInfo:dictUserInfo];
    } forSeconds:0.5];
    
}

#pragma mark - Class Methods

/** Notification Registration */
- (void)registerForRemoteNotification
{
    if (IS_SIMULATOR)
        return;
    
    // -- New code for ios 10 --
    // -- http://ashishkakkad.com/2016/09/push-notifications-in-ios-10-objective-c/ --
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0")) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge)
                              completionHandler:^(BOOL granted, NSError * _Nullable error){
                                  if( !error ){
                                      [[UIApplication sharedApplication] registerForRemoteNotifications];
                                  }
                              }];
    }
    else {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
}




@end

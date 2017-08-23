//
//  AppSession.m
//  PropzyPama
//
//  Created by Dylan Bui on 8/11/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "DbAppSession.h"

#define APP_SESSION_KEY @"APP_SESSION_KEY"
#define DEVICE_PUSH_TOKEN @"DEVICE_PUSH_TOKEN"
#define PUSH_NOTIFY_INFO_TOKEN @"PUSH_NOTIFY_INFO_TOKEN"

@implementation DbAppSession

@synthesize accessToken;
@synthesize deviceToken;

@synthesize photo;
@synthesize name;
@synthesize email;
@synthesize address;
@synthesize latitude;
@synthesize longitude;

@synthesize extendData;

+ (DbAppSession *)instance
{
    static DbAppSession *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DbAppSession alloc] initInstance];
    });
    return instance;
}

- (id)initInstance
{
    if (self = [super init]) {
        self.extendData = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.extendData = [[NSMutableDictionary alloc] init];
        
        [DbUtils addNotification:UIApplicationDidBecomeActiveNotification
                      observer:self
                      selector:@selector(processNotificationCenter:)
                        object:nil];
        
        [DbUtils addNotification:UIApplicationWillResignActiveNotification
                      observer:self
                      selector:@selector(processNotificationCenter:)
                        object:nil];
    }
    return self;
}

#pragma mark -
#pragma mark Push Notification Token
#pragma mark -

- (NSString *)getDevicePushNotificationToken
{
    if (IS_SIMULATOR)
        return @"notuser659ef7634ff919e6a866aab41b7bc60039339ac8cd85b90c888fb";
    
    return [[NSUserDefaults standardUserDefaults] stringForKey:DEVICE_PUSH_TOKEN];
}

- (void)setDevicePushNotificationToken:(NSString *)strDeviceToken
{
    // -- Save data to NSUserDefaults (save string) --
    [[NSUserDefaults standardUserDefaults] setObject:strDeviceToken forKey:DEVICE_PUSH_TOKEN];
}

#pragma mark -
#pragma mark Data From Last Session
#pragma mark -

- (void)reloadDataFromLastSession
{
    NSString *strJsonData = [[NSUserDefaults standardUserDefaults] stringForKey:APP_SESSION_KEY];
    if (strJsonData != nil) {
        NSData *data = [strJsonData dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:NSJSONReadingMutableContainers
                                                                     error:nil];

        
        [self loadPropertyValueFromDictionary_om:dictionary];
    }
}

- (void)saveDataFromLastSession
{
    // -- Only save when login --
    NSString *strJsonData = [self om_mapToJSONString];
    
    // -- Save data to NSUserDefaults : khong the luu vi du lieu qua lon --
    [[NSUserDefaults standardUserDefaults] setObject:strJsonData forKey:APP_SESSION_KEY];
}

- (void)clearAllSessionData
{
    // -- Clear data --
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:APP_SESSION_KEY];
}

//- (void)reloadDataFromLastSessionWithObject:(DbObject *)obj forKey:(NSString *)key
//{
//    NSString *strJsonData = [[NSUserDefaults standardUserDefaults] stringForKey:key];
//    if (strJsonData != nil) {
//        NSData *data = [strJsonData dataUsingEncoding:NSUTF8StringEncoding];
//        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data
//                                                                   options:NSJSONReadingMutableContainers
//                                                                     error:nil];
//        
//        if (obj) {
//            [obj loadPropertyValueFromDictionary_om:dictionary];
//        } else {
//            [self loadPropertyValueFromDictionary_om:dictionary];
//        }
//    }
//}
//
//- (void)saveDataFromLastSessionWithObject:(DbObject *)obj forKey:(NSString *)key
//{
//    // -- Only save when login --
//    NSString *strJsonData = [self om_mapToJSONString];
//    if (obj) {
//        strJsonData = [obj om_mapToJSONString];
//    }
//    
//    // -- Save data to NSUserDefaults : khong the luu vi du lieu qua lon --
//    [[NSUserDefaults standardUserDefaults] setObject:strJsonData forKey:key];
//}



#pragma mark -
#pragma mark Push Notify Info
#pragma mark -

- (NSDictionary *)getPushNotifyInfo
{
    return [self getUserDefaultsDataObjectFromKey:PUSH_NOTIFY_INFO_TOKEN];
    // return [[NSUserDefaults standardUserDefaults] objectForKey:PUSH_NOTIFY_INFO_TOKEN];
}

- (void)setPushNotifyInfo:(NSDictionary *)pushInfo
{
    [self setUserDefaultsDataObject:pushInfo forKey:PUSH_NOTIFY_INFO_TOKEN];
//    [[NSUserDefaults standardUserDefaults] setObject:pushInfo forKey:PUSH_NOTIFY_INFO_TOKEN];
//    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setUserDefaultsDataObject:(NSObject *)obj forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (id)getUserDefaultsDataObjectFromKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

#pragma mark -
#pragma mark Extend Data
#pragma mark -

- (id)getExtendDataForKey:(NSString *)key
{
    return [self.extendData objectForKey:key];
}

- (void)setExtendData:(id)data forKey:(NSString *)key
{
    [self.extendData setObject:data forKey:key];
}

#pragma mark -
#pragma mark Private function
#pragma mark -

- (void)dealloc
{
    // Remove notification
    [DbUtils removeNotification:self];
}


#pragma mark -
#pragma mark Define mapping
#pragma mark -

+ (NSMutableDictionary *)om_objectMapping
{
    NSMutableDictionary * mapping = [super om_objectMapping];
    if (mapping) {
        // @{ @"property_name": @"json_name"}
        NSDictionary * objectMapping = @{
                                         @"deviceToken": @"deviceToken",
                                         @"accessToken": @"accessToken",
                                         
                                         @"address": @"address",
                                         @"email": @"email",
                                         @"phone": @"phone",
                                         @"name": @"name",
                                         @"photo": @"photo",
                                         
                                         @"extendData": @"extendData",
                                         @"latitude": @"latitude",
                                         @"longitude": @"longitude",
                                         };
        [mapping addEntriesFromDictionary:objectMapping];
    }
    return mapping;
}


- (void)processNotificationCenter:(NSNotification *)notification
{
    if (notification.name == UIApplicationDidBecomeActiveNotification) {
        NSLog(@"%@", @"reloadDataFromLastSession");
        [self reloadDataFromLastSession];
    } else if (notification.name == UIApplicationWillResignActiveNotification) {
        [self saveDataFromLastSession];
    }
}



@end

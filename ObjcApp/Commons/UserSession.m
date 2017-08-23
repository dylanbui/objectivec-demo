//
//  UserSession.m
//  PropzySam
//
//  Created by Dylan Bui on 1/6/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "UserSession.h"

//#import "UserApi.h"

typedef enum _USER_STATUS {
    USER_LOGOUT = 0,
    USER_LOGIN = 1
} USER_STATUS;


//#define USER_SESSION @"user_session"
#define USER_STATUS_TOKEN @"user_status" // Status user nen co nhieu trang thai

@implementation UserSession


@synthesize accountId;
@synthesize socialUid;
@synthesize userTypeId;
@synthesize userTypeName;

@synthesize imgAvatar;

+ (UserSession *)instance
{
    static UserSession *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[UserSession alloc] init];
    });
    return instance;
}

- (id)init
{
    if (self = [super init]) {
    }
    return self;
}

- (void)sessionStart
{
    [DbUtils addNotification:NOTIFY_REACHABLE_NETWORK
                  observer:self
                  selector:@selector(processNotificationCenter:)
                    object:nil];
}


- (bool)isLogin
{
//    USER_STATUS userStatus = (int) [[NSUserDefaults standardUserDefaults] integerForKey:USER_STATUS_TOKEN];
    USER_STATUS userStatus = [[self getUserDefaultsDataObjectFromKey:USER_STATUS_TOKEN] intValue];    
    return (userStatus == USER_LOGIN) ? YES : NO;
}

// -- Chua co validate du lieu --
- (void)setLoginUserData:(NSDictionary *)dataUser
{
    // -- Set statsu = 1 => login --
    // [[NSUserDefaults standardUserDefaults] setInteger:USER_LOGIN forKey:USER_STATUS_TOKEN];
    [self setUserDefaultsDataObject:[NSNumber numberWithInt:USER_LOGIN] forKey:USER_STATUS_TOKEN];
    
    // -- Load data to variables --
    [self loadPropertyUserData:dataUser];
    
    // -- Backup data --
    [self saveDataFromLastSession];
}

- (void)doLogout
{
    // -- Set status to logout => nil --
    // [[NSUserDefaults standardUserDefaults] setInteger:USER_LOGOUT forKey:USER_STATUS_TOKEN];
    [self setUserDefaultsDataObject:[NSNumber numberWithInt:USER_LOGOUT] forKey:USER_STATUS_TOKEN];
    
    // -- Phai reset data --
    [self resetAllData];
    
    // -- Clear data --
    [self clearAllSessionData];
    // [[NSUserDefaults standardUserDefaults] setObject:nil forKey:USER_SESSION];
    
    // -- Show help screen --
}

- (void)logUser
{
    // TODO: Use the current user's information
    // You can call any combination of these three methods
//    [CrashlyticsKit setUserIdentifier:self.accountId];
//    [CrashlyticsKit setUserEmail:self.email];
//    [CrashlyticsKit setUserName:self.name];
}

- (void)loadPropertyUserData:(NSDictionary *)dictUserData
{
    // -- Load data to variables --
    [self loadPropertyValueFromDictionary_om:dictUserData];
    
    // -- Load extent cache data --
//    [Utils dispatchToBgQueue:^{
//        // -- Set avatar default --
//        [self logUser];
//        // NSLog(@"load photo : %@", self.photo);
//        self.imgAvatar = [UIImage imageNamed:@"imgAvatar"];
//        if (self.photo != nil) {
//            NSURL *url = [NSURL URLWithString:self.photo];
//            self.imgAvatar = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
//        }
//    }];
}

- (void)synchronizeUserData
{
    if ([self isLogin]) {
        
//        // -- Reload login user info --
//        [UserApi getProfileWithCallId:0 andCallback:^(ResponseObject *response, NSError *error){
//            if (error != nil)
//                return;
//            
//            NSDictionary * mappingRules = @{
//                                            @"email": @"email",
//                                            @"phone": @"phone",
//                                            @"name": @"name",
//                                            @"photo": @"photo",
//                                            @"userTypeId": @"userTypeId",
//                                            @"userTypeName": @"userTypeName"
//                                            };
//            
//            // -- Load syse data --
//            [self loadPropertyValueFromDictionary_om:response.data withMappingRules:mappingRules];
//
//            if (self.photo != nil) {
//                NSURL *url = [NSURL URLWithString:self.photo];
//                self.imgAvatar = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
//            }
//            
//        } showLoading:NO];
    }
}

#pragma mark -
#pragma mark Private function
#pragma mark -

#pragma mark -
#pragma mark Define mapping
#pragma mark -

+ (NSMutableDictionary *)om_objectMapping
{
    NSMutableDictionary * mapping = [super om_objectMapping];
    if (mapping) {
        // @{ @"property_name": @"json_name"}
        NSDictionary * objectMapping = @{
                                          @"objectType": @"objectType",
                                          
                                          @"accountId": @"accountId",
                                          @"socialUid": @"socialUid",
                                          @"userTypeId": @"userTypeId",
                                          @"userTypeName": @"userTypeName",
                                          
                                          @"userType": @"userType",
                                          };
        [mapping addEntriesFromDictionary:objectMapping];
    }
    return mapping;
}


- (void)processNotificationCenter:(NSNotification *)notification
{
    [super processNotificationCenter:notification];
//    if (notification.name == UIApplicationDidBecomeActiveNotification) {
//        [self reloadDataFromLastSession];
//    } else if (notification.name == UIApplicationWillResignActiveNotification) {
//        [self saveDataFromLastSession];
//    } else if ([notification.name isEqualToString:NOTIFY_REACHABLE_NETWORK]) {
//        // -- Synchronize user data when network connected --
//        [self synchronizeUserData];
//    }
}



@end

//
//  AppSession.h
//  PropzyPama
//
//  Created by Dylan Bui on 8/11/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "DbObject.h"
#import "DbConstant.h"
#import "DbUtils.h"

@interface DbAppSession : DbObject

@property (strong, nonatomic) NSString      *deviceToken;
@property (strong, nonatomic) NSString      *accessToken;

@property (strong, nonatomic) NSString      *address;
@property (strong, nonatomic) NSString      *email;
@property (strong, nonatomic) NSString      *name;
@property (strong, nonatomic) NSString      *phone;
@property (strong, nonatomic) NSString      *photo;

@property (nonatomic, assign) double  latitude;
@property (nonatomic, assign) double  longitude;

@property (strong, nonatomic) NSMutableDictionary  *extendData;

+ (id)instance;

- (NSString *)getDevicePushNotificationToken;
- (void)setDevicePushNotificationToken:(NSString *)strDeviceToken;

- (NSDictionary *)getPushNotifyInfo;
- (void)setPushNotifyInfo:(NSDictionary *)pushInfo;

- (id)getExtendDataForKey:(NSString *)key;
- (void)setExtendData:(id)data forkey:(NSString *)key;

- (void)reloadDataFromLastSession;
- (void)saveDataFromLastSession;

// -- Clear data --
- (void)clearAllSessionData;

- (id)getUserDefaultsDataObjectFromKey:(NSString *)key;
- (void)setUserDefaultsDataObject:(NSObject *)obj forKey:(NSString *)key;



@end

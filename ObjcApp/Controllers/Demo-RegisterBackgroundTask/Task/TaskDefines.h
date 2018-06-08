//
//  TaskProtocol.h
//  ObjcApp
//
//  Created by Dylan Bui on 6/3/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#ifndef TaskDefines_h
#define TaskDefines_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "DbConstant.h"

//
///** A unique ID that corresponds to one heading request. */
//typedef NSInteger INTUHeadingRequestID;

typedef NSArray<NSString *> LIST_TASK_MODE;

typedef NSInteger TaskRegisterID;

#define SYSTEM_TASK     @"SYSTEM_TASK"
#define USER_TASK       @"USER_TASK"


//UIApplicationWillResignActiveNotification
// -- Phai su dung kieu NSString --
//typedef enum _TASK_MODEL {
//    APP_DID_BECOME_ACTIVE,
//    APP_DID_ENTER_BACKGROUND,
//    APP_WILL_ENTER_FOREGROUND,
//    APP_WILL_RESIGN_ACTIVE
//} TASK_MODEL;

@class TaskProtocol;

@protocol TaskProtocol <NSObject>

@property (nonatomic) TaskRegisterID taskID;

@required
- (void)taskStart:(NSString *)runningMode;
- (void)taskCancel;
- (NSArray<NSString *> *)taskRunBackgroundMode; // 1 chuc nang co the chay o nhieu mode

@optional
- (NSInteger)taskPriority;  // -- Default : 1 --
- (NSString *)taskGroup;    // -- Default : SYSTEM_TASK --

@end

///** The possible states that heading services can be in. */
//typedef NS_ENUM(NSInteger, INTUHeadingServicesState) {
//    /** Heading services are available on the device */
//    INTUHeadingServicesStateAvailable,
//    /** Heading services are available on the device */
//    INTUHeadingServicesStateUnavailable,
//};
//
/** A unique ID that corresponds to one location request. */
//typedef NSInteger TaskRegisterID;

typedef id<TaskProtocol> TaskObject;



#endif /* TaskDefines_h */

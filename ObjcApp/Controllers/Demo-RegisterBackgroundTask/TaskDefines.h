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

///** The possible states that heading services can be in. */
//typedef NS_ENUM(NSInteger, INTUHeadingServicesState) {
//    /** Heading services are available on the device */
//    INTUHeadingServicesStateAvailable,
//    /** Heading services are available on the device */
//    INTUHeadingServicesStateUnavailable,
//};
//
/** A unique ID that corresponds to one location request. */
typedef NSInteger TaskRegisterID;
//
///** A unique ID that corresponds to one heading request. */
//typedef NSInteger INTUHeadingRequestID;

typedef enum _TASK_MODEL {
    APP_DID_BECOME_ACTIVE,
    APP_DID_ENTER_BACKGROUND,
    APP_WILL_ENTER_FOREGROUND,
} TASK_MODEL;

@protocol TaskProtocol <NSObject>

@required
- (void)taskStart;
- (TASK_MODEL)taskRunBackgroundMode;
- (NSInteger)taskPriority;

@end



#endif /* TaskDefines_h */

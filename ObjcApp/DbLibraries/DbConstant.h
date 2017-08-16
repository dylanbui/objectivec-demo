//
//  CommonsConstant.h
//  PropzyPam
//
//  Created by Dylan Bui on 8/9/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#ifndef DbConstant_h
#define DbConstant_h

#define CONFIGURATION_DEBUG 1 // 0 : hide, 1 : show

#ifdef __OBJC__
#import <Foundation/Foundation.h>
#if (CONFIGURATION_DEBUG || CONFIGURATION_QC)
#define DebugLog(format, ...) DLog((@"%s: %d: %s: " format),\
__FILE__,\
__LINE__,\
__FUNCTION__,\
##__VA_ARGS__)
#else
#define DebugLog(format, ...)
#endif
#endif

#if CONFIGURATION_DEBUG || CONFIGURATION_QC
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define SLog(fmt, ...) NSLog((@"" fmt), ##__VA_ARGS__);
#else
#define DLog(...)
#define SLog(...)
#endif

// ALog always displays output regardless of the DEBUG setting
#define ALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

#define IS_SIMULATOR                            TARGET_OS_SIMULATOR

#define SYSTEM_VERSION_EQUAL_TO(v) \
([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v) \
([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) \
([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v) \
([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v) \
([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

/***************** Supported Area ******************/
#define LOS_ANGELES_POINT CLLocationCoordinate2DMake(34.0204989, -118.4117325)
#define ORANGE_COUNTY_POINT CLLocationCoordinate2DMake(33.6670191,-117.7646825)

/***************** Demo status ******************/
#pragma mark - Enum
typedef enum _TOKENSTATUS {
    TOKEN_EMPTY,
    TOKEN_EXPIRED,
    TOKEN_INVALID,
    TOKEN_VALID
} TOKENSTATUS;

typedef enum _CHANNELS {
    CHANNEL_UNKNOWN,
    CHANNEL_FBSIGNIU,
    CHANNEL_FBSIGNOUT,
    CHANNEL_LISTING_CHANGE,
    CHANNEL_NUMBEROFSOCIAL_CHANGE,
    CHANNEL_MESSAGE
} CHANNELS;

#define ShowNetworkActivityIndicator() [UIApplication sharedApplication].networkActivityIndicatorVisible = YES
#define HideNetworkActivityIndicator() [UIApplication sharedApplication].networkActivityIndicatorVisible = NO

#define OS_VERSION [UIDevice currentDevice].systemVersion

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))
#define IS_ZOOMED (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_NEWER_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH > 568.0)

#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define IS_IPHONE_7 (IS_IPHONE && SCREEN_MAX_LENGTH > 736.0)

#define TEMP_DIR @"temp_dir"

#define FORMAT_POPULATER_NAME @"yyyy_MM_dd_HH_mm_ss"
#define FULL_FORMAT_DATE @"yyyy-MM-dd HH:mm:ss"
#define SQLITE_FORMAT_DATE @"%Y-%m-%d %H:%M:%S"

#define VN_FORMAT_DATE_DOUBLE @"dd/MM/YYYY" // 08/08/2017
#define VN_FORMAT_DATE_SINGLE @"d/M/Y" // 8/8/17
#define VN_FORMAT_DATE_FULL @"d/M/Y HH:mm:ss"

#define FORMAT_TIME_FULL @"HH:mm:ss"

/***************** Define Notification ******************/

#define NOTIFY_SERVER_PUSH_MESSAGE             @"NOTIFY_SERVER_PUSH_MESSAGE"

#define NOTIFY_REACHABLE_NETWORK               @"NOTIFY_REACHABLE_NETWORK"

#define NOTIFY_VCL_DID_LOAD                    @"NOTIFY_VCL_DID_LOAD"
#define NOTIFY_VCL_WILL_APPEAR                 @"NOTIFY_VCL_WILL_APPEAR"
#define NOTIFY_VCL_DID_APPEAR                  @"NOTIFY_VCL_DID_APPEAR"
#define NOTIFY_VCL_WILL_DISAPPEAR              @"NOTIFY_VCL_WILL_DISAPPEAR"
#define NOTIFY_VCL_DID_DISAPPEAR               @"NOTIFY_VCL_DID_DISAPPEAR"


/***************** Short Function ******************/

#define _NULL                               [NSNull null]
#define _isNULL(OBJ)                        (OBJ == [NSNull null] ? YES : NO)
#define _valNULL(OBJ)                       (OBJ != [NSNull null] ? OBJ : @"")

#define _getObj(OBJ, defaultValue)          (_isNULL(OBJ) ? defaultValue : OBJ)

#define _isNil(OBJ)                         (OBJ == nil ? YES : NO)
#define _valNil(OBJ)                        (OBJ != nil ? OBJ : @"")

#define RUN_ON_MAIN_QUEUE(BLOCK_CODE)           dispatch_async(dispatch_get_main_queue(),BLOCK_CODE)
#define RUN_ON_BACKGROUND_QUEUE(BLOCK_CODE)     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),BLOCK_CODE)

/***************** Simple Callback Delegate ******************/

// -- Xu ly tra ve cua cac UIView action --
typedef void (^HandleControlAction)(id _self, int _id, NSDictionary* _params, NSError* error);

@protocol ICallbackParentDelegate <NSObject>

@required
- (void)onCallback:(id)_self andCallerId:(NSInteger)callerId withParams:(NSDictionary*)params withError:(NSError*)error;

@end


#endif /* DbConstant_h */

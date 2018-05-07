//
//  DbLocationManager.h
//  ObjcApp
//
//  Created by Dylan Bui on 5/7/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

//#import <Foundation/Foundation.h>
//
//@interface DbLocationManager : NSObject
//
//@end

#import "DbLocationDefines.h"

//! Project version number for DbLocationManager.
//FOUNDATION_EXPORT double DbLocationManagerVersionNumber;

//! Project version string for DbLocationManager.
//FOUNDATION_EXPORT const unsigned char DbLocationManagerVersionString[];


/**
 An abstraction around CLLocationManager that provides a block-based asynchronous API for obtaining the device's location.
 DbLocationManager automatically starts and stops system location services as needed to minimize battery drain.
 */
@interface DbLocationManager : NSObject

/** Returns the current state of location services for this app, based on the system settings and user authorization status. */
+ (DbLocationServicesState)locationServicesState;

/** Returns the singleton instance of this class. */
+ (instancetype)sharedInstance;

#pragma mark Location Requests

/**
 Default Asynchronously requests the current location of the device using location services.
 @param block           The block to execute upon success, failure, or timeout.

 @return The location request ID, which can be used to force early completion or cancel the request while it is in progress.
 */
- (DbLocationRequestID)requestLocation:(DbLocationRequestBlock)block;

/**
 Asynchronously requests the current location of the device using location services.
 
 @param desiredAccuracy The accuracy level desired (refers to the accuracy and recency of the location).
 @param timeout         The maximum amount of time (in seconds) to wait for a location with the desired accuracy before completing. If
 this value is 0.0, no timeout will be set (will wait indefinitely for success, unless request is force completed or canceled).
 @param block           The block to execute upon success, failure, or timeout.
 
 @return The location request ID, which can be used to force early completion or cancel the request while it is in progress.
 */
- (DbLocationRequestID)requestLocationWithDesiredAccuracy:(DbLocationAccuracy)desiredAccuracy
                                                    timeout:(NSTimeInterval)timeout
                                                      block:(DbLocationRequestBlock)block;

/**
 Asynchronously requests the current location of the device using location services, optionally delaying the timeout countdown until the user has
 responded to the dialog requesting permission for this app to access location services.
 
 @param desiredAccuracy      The accuracy level desired (refers to the accuracy and recency of the location).
 @param timeout              The maximum amount of time (in seconds) to wait for a location with the desired accuracy before completing. If
 this value is 0.0, no timeout will be set (will wait indefinitely for success, unless request is force completed or canceled).
 @param delayUntilAuthorized A flag specifying whether the timeout should only take effect after the user responds to the system prompt requesting
 permission for this app to access location services. If YES, the timeout countdown will not begin until after the
 app receives location services permissions. If NO, the timeout countdown begins immediately when calling this method.
 @param block                The block to execute upon success, failure, or timeout.
 
 @return The location request ID, which can be used to force early completion or cancel the request while it is in progress.
 */
- (DbLocationRequestID)requestLocationWithDesiredAccuracy:(DbLocationAccuracy)desiredAccuracy
                                                    timeout:(NSTimeInterval)timeout
                                       delayUntilAuthorized:(BOOL)delayUntilAuthorized
                                                      block:(DbLocationRequestBlock)block;

/**
 Creates a subscription for location updates that will execute the block once per update indefinitely (until canceled), regardless of the accuracy of each location.
 This method instructs location services to use the highest accuracy available (which also requires the most power).
 If an error occurs, the block will execute with a status other than DbLocationStatusSuccess, and the subscription will be canceled automatically.
 
 @param block The block to execute every time an updated location is available.
 The status will be DbLocationStatusSuccess unless an error occurred; it will never be DbLocationStatusTimedOut.
 
 @return The location request ID, which can be used to cancel the subscription of location updates to this block.
 */
- (DbLocationRequestID)subscribeToLocationUpdatesWithBlock:(DbLocationRequestBlock)block;

/**
 Creates a subscription for location updates that will execute the block once per update indefinitely (until canceled), regardless of the accuracy of each location.
 The specified desired accuracy is passed along to location services, and controls how much power is used, with higher accuracies using more power.
 If an error occurs, the block will execute with a status other than DbLocationStatusSuccess, and the subscription will be canceled automatically.
 
 @param desiredAccuracy The accuracy level desired, which controls how much power is used by the device's location services.
 @param block           The block to execute every time an updated location is available. Note that this block runs for every update, regardless of
 whether the achievedAccuracy is at least the desiredAccuracy.
 The status will be DbLocationStatusSuccess unless an error occurred; it will never be DbLocationStatusTimedOut.
 
 @return The location request ID, which can be used to cancel the subscription of location updates to this block.
 */
- (DbLocationRequestID)subscribeToLocationUpdatesWithDesiredAccuracy:(DbLocationAccuracy)desiredAccuracy
                                                                 block:(DbLocationRequestBlock)block;

/**
 Creates a subscription for significant location changes that will execute the block once per change indefinitely (until canceled).
 If an error occurs, the block will execute with a status other than DbLocationStatusSuccess, and the subscription will be canceled automatically.
 
 @param block The block to execute every time an updated location is available.
 The status will be DbLocationStatusSuccess unless an error occurred; it will never be DbLocationStatusTimedOut.
 
 @return The location request ID, which can be used to cancel the subscription of significant location changes to this block.
 */
- (DbLocationRequestID)subscribeToSignificantLocationChangesWithBlock:(DbLocationRequestBlock)block;

/** Immediately forces completion of the location request with the given requestID (if it exists), and executes the original request block with the results.
 For one-time location requests, this is effectively a manual timeout, and will result in the request completing with status DbLocationStatusTimedOut.
 If the requestID corresponds to a subscription, then the subscription will simply be canceled. */
- (void)forceCompleteLocationRequest:(DbLocationRequestID)requestID;

/** Immediately cancels the location request (or subscription) with the given requestID (if it exists), without executing the original request block. */
- (void)cancelLocationRequest:(DbLocationRequestID)requestID;


@end



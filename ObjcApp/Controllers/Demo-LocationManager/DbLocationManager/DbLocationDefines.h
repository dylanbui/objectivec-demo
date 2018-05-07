//
//  DbLocationDefines.h
//  ObjcApp
//
//  Created by Dylan Bui on 5/7/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#ifndef DbLocationDefines_h
#define DbLocationDefines_h

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

static const CLLocationAccuracy kDbHorizontalAccuracyThresholdCity =         5000.0;  // in meters
static const CLLocationAccuracy kDbHorizontalAccuracyThresholdNeighborhood = 1000.0;  // in meters
static const CLLocationAccuracy kDbHorizontalAccuracyThresholdBlock =         100.0;  // in meters
static const CLLocationAccuracy kDbHorizontalAccuracyThresholdHouse =          15.0;  // in meters
static const CLLocationAccuracy kDbHorizontalAccuracyThresholdRoom =            5.0;  // in meters

static const NSTimeInterval kDbUpdateTimeStaleThresholdCity =             600.0;  // in seconds
static const NSTimeInterval kDbUpdateTimeStaleThresholdNeighborhood =     300.0;  // in seconds
static const NSTimeInterval kDbUpdateTimeStaleThresholdBlock =             60.0;  // in seconds
static const NSTimeInterval kDbUpdateTimeStaleThresholdHouse =             15.0;  // in seconds
static const NSTimeInterval kDbUpdateTimeStaleThresholdRoom =               5.0;  // in seconds

/** The possible states that location services can be in. */
typedef NS_ENUM(NSInteger, DbLocationServicesState) {
    /** User has already granted this app permissions to access location services, and they are enabled and ready for use by this app.
     Note: this state will be returned for both the "When In Use" and "Always" permission levels. */
    DbLocationServicesStateAvailable,
    /** User has not yet responded to the dialog that grants this app permission to access location services. */
    DbLocationServicesStateNotDetermined,
    /** User has explicitly denied this app permission to access location services. (The user can enable permissions again for this app from the system Settings app.) */
    DbLocationServicesStateDenied,
    /** User does not have ability to enable location services (e.g. parental controls, corporate policy, etc). */
    DbLocationServicesStateRestricted,
    /** User has turned off location services device-wide (for all apps) from the system Settings app. */
    DbLocationServicesStateDisabled
};

/** The possible states that heading services can be in. */
typedef NS_ENUM(NSInteger, DbHeadingServicesState) {
    /** Heading services are available on the device */
    DbHeadingServicesStateAvailable,
    /** Heading services are available on the device */
    DbHeadingServicesStateUnavailable,
};

/** A unique ID that corresponds to one location request. */
typedef NSInteger DbLocationRequestID;

/** A unique ID that corresponds to one heading request. */
//typedef NSInteger DbHeadingRequestID;

/** An abstraction of both the horizontal accuracy and recency of location data.
 Room is the highest level of accuracy/recency; City is the lowest level. */
typedef NS_ENUM(NSInteger, DbLocationAccuracy) {
    // 'None' is not valid as a desired accuracy.
    /** Inaccurate (>5000 meters, and/or received >10 minutes ago). */
    DbLocationAccuracyNone = 0,
    
    // The below options are valid desired accuracies.
    /** 5000 meters or better, and received within the last 10 minutes. Lowest accuracy. */
    DbLocationAccuracyCity,
    /** 1000 meters or better, and received within the last 5 minutes. */
    DbLocationAccuracyNeighborhood,
    /** 100 meters or better, and received within the last 1 minute. */
    DbLocationAccuracyBlock,
    /** 15 meters or better, and received within the last 15 seconds. */
    DbLocationAccuracyHouse,
    /** 5 meters or better, and received within the last 5 seconds. Highest accuracy. */
    DbLocationAccuracyRoom,
};

/** An alias of the heading filter accuracy in degrees.
 Specifies the minimum amount of change in degrees needed for a heading service update. Observers will not be notified of updates less than the stated filter value. */
typedef CLLocationDegrees DbHeadingFilterAccuracy;

/** A status that will be passed in to the completion block of a location request. */
typedef NS_ENUM(NSInteger, DbLocationStatus) {
    // These statuses will accompany a valid location.
    /** Got a location and desired accuracy level was achieved successfully. */
    DbLocationStatusSuccess = 0,
    /** Got a location, but the desired accuracy level was not reached before timeout. (Not applicable to subscriptions.) */
    DbLocationStatusTimedOut,
    
    // These statuses indicate some sort of error, and will accompany a nil location.
    /** User has not yet responded to the dialog that grants this app permission to access location services. */
    DbLocationStatusServicesNotDetermined,
    /** User has explicitly denied this app permission to access location services. */
    DbLocationStatusServicesDenied,
    /** User does not have ability to enable location services (e.g. parental controls, corporate policy, etc). */
    DbLocationStatusServicesRestricted,
    /** User has turned off location services device-wide (for all apps) from the system Settings app. */
    DbLocationStatusServicesDisabled,
    /** An error occurred while using the system location services. */
    DbLocationStatusError
};

/** A status that will be passed in to the completion block of a heading request. */
typedef NS_ENUM(NSInteger, DbHeadingStatus) {
    // These statuses will accompany a valid heading.
    /** Got a heading successfully. */
    DbHeadingStatusSuccess = 0,
    
    // These statuses indicate some sort of error, and will accompany a nil heading.
    /** Heading was invalid. */
    DbHeadingStatusInvalid,
    
    /** Heading services are not available on the device */
    DbHeadingStatusUnavailable
};

/**
 A block type for a location request, which is executed when the request succeeds, fails, or times out.
 
 @param currentLocation The most recent & accurate current location available when the block executes, or nil if no valid location is available.
 @param achievedAccuracy The accuracy level that was actually achieved (may be better than, equal to, or worse than the desired accuracy).
 @param status The status of the location request - whether it succeeded, timed out, or failed due to some sort of error. This can be used to
 understand what the outcome of the request was, decide if/how to use the associated currentLocation, and determine whether other
 actions are required (such as displaying an error message to the user, retrying with another request, quietly proceeding, etc).
 */
typedef void(^DbLocationRequestBlock)(CLLocation *currentLocation, DbLocationAccuracy achievedAccuracy, DbLocationStatus status);

/**
 A block type for a heading request, which is executed when the request succeeds.
 
 @param currentHeading  The most recent current heading available when the block executes.
 @param status          The status of the request - whether it succeeded or failed due to some sort of error. This can be used to understand if any further action is needed.
 */
//typedef void(^DbHeadingRequestBlock)(CLHeading *currentHeading, DbHeadingStatus status);



#endif /* DbLocationDefines_h */

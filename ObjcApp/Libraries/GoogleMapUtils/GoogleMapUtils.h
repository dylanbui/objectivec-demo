//
//  GoogleMapUtils.h
//  PropzyDiy
//
//  Created by Dylan Bui on 2/5/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//  Base on : https://github.com/DrAma999/Route-Directions-Object

#import <Foundation/Foundation.h>
#import <GoogleMaps/GoogleMaps.h>

// MKPolyline => dung cho Apple Map Kit

@class MKPolyline, CLLocation, GMSPolyline;

//typedef void (^RouteDirectionsObjectWeakSelfWithResponse)(NSError * error, NSDictionary * routeDistance, NSDictionary * routeDuration , MKPolyline * routePolyline, NSArray * routes, NSArray * steps, CLLocation * startPoint, CLLocation * endPoint, NSArray * directions);

//typedef void (^RouteDirectionsObjectWeakSelfWithResponse)(NSError * error, NSDictionary * routeDistance, NSDictionary * routeDuration , GMSPolyline * routePolyline, NSArray * routes, NSArray * steps, CLLocation * startPoint, CLLocation * endPoint, NSArray * directions);

typedef void (^RouteDirectionsObjectWeakSelfWithResponse)(NSError * error, NSDictionary * routeDistance, NSDictionary * routeDuration , GMSPath * routePath, NSArray * routes, NSArray * steps, CLLocation * startPoint, CLLocation * endPoint, NSArray * directions);

typedef void (^AddressValidationObjectWeakSelfWithResponse)(NSError * error, NSString * addressStatus, NSArray * formattedAddress, NSArray *addressesGPSLocations, NSArray *rawData);

typedef void (^ReverseAddressObjectWeakSelfWithResponse)(NSError * error, NSString * addressStatus, NSArray * formattedAddress, NSArray *addressesGPSLocations, NSArray *rawData);


@interface GoogleMapUtils : NSObject

@property (nonatomic, strong) NSString *googleApiKey;

- (instancetype)initWithGoogleApiKey:(NSString *)apiKey;

- (void)createDirectionRequestWithStartPoint:(NSString*)aStartPoint andEndPoint:(NSString*)anEndPoint  withCallBackBlock:(RouteDirectionsObjectWeakSelfWithResponse)aBlock;

- (void)validateAddress:(NSString*)anAddress withCallBackBlock:(AddressValidationObjectWeakSelfWithResponse)aBlock;

- (void)reverseAddressFromLocation:(CLLocationCoordinate2D)location withCallBackBlock:(ReverseAddressObjectWeakSelfWithResponse)aBlock;



@end

/****************************************************************************
 INPUT
 NSString * aStartPoint: address or comma seprated GPS coordinates.
 NSString * anEndPoint: address or comma seprated GPS coordinates.
 
 NSString * anAddress: address that should be validated.
 
 
 ******************************************************************************/


/****************************************************************************
 OUTPUT
 NSError * error: contains an error object that could be related to newworking, json parsing, or invalis adresses and routes. USe [error localizedDescription] to show the error cause.
 NSDictionary * routeDistance: a dictionary with two key-value. Key "text" will ask for a fomatted distance text, key "value" will ask for a number that represents the distance in meters.
 NSDictionary * routeDuration: a dictionary with two key-value. Key "text" will ask for a fomatted time duration text, key "value" will ask for a number that represents the duration in seconds.
 MKPolyline * routePolyline: an MKPolyline object object that could be used to show an MKPolylineView that overlays the map.
 NSArray * routes: main google response array, use if you need something that is not returned.
 NSArray * steps: array of dictionaries containing information about the route navigation step.
 CLLocation * startPoint, CLLocation * endPoint: start point and end point of the route.
 NSArray * directions: contains an array of strings aboute route indications. Note that they contains HTML tags.
 NSString * addressStatus: address validation status.
 NSArray * formattedAddress: array of corresponding addresses dictionary found. formattedAddress e addressesGPSLocations are paired.
 NSArray * addressesGPSLocations: array of corresponding addresses found in GPS coordinates (dictionary with keys "lat" e "lng". formattedAddress e addressesGPSLocations are paired.
 
 ******************************************************************************/


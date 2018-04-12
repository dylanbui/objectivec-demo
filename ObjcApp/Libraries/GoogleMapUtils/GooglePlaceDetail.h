//
//  GooglePlace.h
//  PropzyDiy
//
//  Created by Dylan Bui on 4/11/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface GooglePlaceDetail : NSObject

@property (readonly) NSString *placeId;
@property (readonly) NSString *name;
@property (readonly) NSString *formattedAddress;
@property (readonly) CLLocation *location;

- (instancetype)initWithJSONData:(NSDictionary *)jsonDictionary;

@end

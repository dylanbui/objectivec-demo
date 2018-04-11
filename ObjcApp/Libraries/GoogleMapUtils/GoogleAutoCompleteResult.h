//
//  GoogleAutoCompleteResult.h
//  PropzyDiy
//
//  Created by Dylan Bui on 4/11/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface GoogleAutoCompleteResult : NSObject

@property (readonly) NSString *name;
@property (readonly) NSString *description;
@property (readonly) NSString *placeID;

@property (readonly) NSString *mainAddress;
@property (readonly) NSString *secondaryAddress;

@property (readonly) CLLocationCoordinate2D locationCoordinates;

- (instancetype)initWithJSONData:(NSDictionary *)jsonDictionary;

@end

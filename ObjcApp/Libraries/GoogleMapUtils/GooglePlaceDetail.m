//
//  GooglePlace.m
//  PropzyDiy
//
//  Created by Dylan Bui on 4/11/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import "GooglePlaceDetail.h"

@implementation GooglePlaceDetail {
    NSDictionary *_jsonDictionary;
}

- (instancetype)initWithJSONData:(NSDictionary *)jsonDictionary
{
    self = [super init];
    if (self) {
        _jsonDictionary = jsonDictionary;
    }
    return self;
}

#pragma mark - Properties

- (NSString *)placeId
{
    NSString *place_id = [NSString new];
    if(_jsonDictionary[@"place_id"] != [NSNull null]){
        place_id = _jsonDictionary[@"place_id"];
    }
    return place_id;
}

- (NSString *)name
{
    NSString *name = [NSString new];
    if(_jsonDictionary[@"name"] != [NSNull null]){
        name = _jsonDictionary[@"name"];
    }
    return name;
}

- (NSString *)formattedAddress
{
    NSString *description = [NSString new];
    if(_jsonDictionary[@"formatted_address"] != [NSNull null]){
        description = _jsonDictionary[@"formatted_address"];
    }
    return description;
}

- (CLLocation *)location
{
    CLLocation *location = [[CLLocation alloc] init];
    if(_jsonDictionary[@"geometry"] != [NSNull null] && _jsonDictionary[@"geometry"][@"location"] != [NSNull null]) {
        NSNumber *latitude = _jsonDictionary[@"geometry"][@"location"][@"lat"];
        NSNumber *longitude = _jsonDictionary[@"geometry"][@"location"][@"lng"];
        
        location = [[CLLocation alloc] initWithLatitude:latitude.doubleValue longitude:longitude.doubleValue];
    }
    return location;
    
}


@end

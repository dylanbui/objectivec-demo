//
//  GoogleAutoCompleteResult.m
//  PropzyDiy
//
//  Created by Dylan Bui on 4/11/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import "GoogleAutoCompleteResult.h"

@implementation GoogleAutoCompleteResult {
    NSDictionary *_jsonDictionary;
}

- (instancetype)initWithJSONData:(NSDictionary *)jsonDictionary {
    self = [super init];
    if (self) {
        _jsonDictionary = jsonDictionary;
    }
    return self;
}

#pragma mark - Properties

- (NSString *)name
{
    NSString *name = [NSString new];
    if([_jsonDictionary[@"terms"] objectAtIndex:0][@"value"] != [NSNull null]){
        name = [_jsonDictionary[@"terms"] objectAtIndex:0][@"value"];
    }
    return name;
}

- (NSString *)description
{
    NSString *description = [NSString new];
    if(_jsonDictionary[@"description"] != [NSNull null]){
        description = _jsonDictionary[@"description"];
    }
    return description;
}

- (NSString *)placeID
{
    NSString *placeID = [NSString new];
    if(_jsonDictionary[@"place_id"] != [NSNull null]){
        placeID = _jsonDictionary[@"place_id"];
    }
    return placeID;
}

- (NSString *)mainAddress
{
    NSString *address = [NSString new];
    if([_jsonDictionary valueForKeyPath:@"structured_formatting.main_text"] != [NSNull null]){
        address = [_jsonDictionary valueForKeyPath:@"structured_formatting.main_text"];
    }
    return address;
}

- (NSString *)secondaryAddress
{
    NSString *address = [NSString new];
    if([_jsonDictionary valueForKeyPath:@"structured_formatting.main_text"] != [NSNull null]){
        address = [_jsonDictionary valueForKeyPath:@"structured_formatting.secondary_text"];
    }
    return address;
}



@end

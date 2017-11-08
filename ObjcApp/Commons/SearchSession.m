//
//  SearchSession.m
//  ObjcApp
//
//  Created by Dylan Bui on 11/8/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "SearchSession.h"

@interface SearchSession ()

@end

@implementation SearchSession

@synthesize northWest = _northWest;
@synthesize northEast = _northEast;
@synthesize southWest = _southWest;
@synthesize southEast = _southEast;

+ (SearchSession *)instance
{
    static SearchSession *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SearchSession alloc] initInstance];
    });
    return instance;
}

- (id)initInstance
{
    if (self = [super init]) {
        self.orderType = 1;
        self.currentPage = 0;
        self.limitItem = 20;
    }
    return self;
}

- (void)setNorthWest:(CLLocationCoordinate2D)location
{
    _northWest = location;
    self.nearleftlat = location.latitude;
    self.nearleftlong = location.longitude;
}

- (void)setNorthEast:(CLLocationCoordinate2D)location
{
    _northEast = location;
    self.nearrightlat = location.latitude;
    self.nearrightlong = location.longitude;
}

- (void)setSouthWest:(CLLocationCoordinate2D)location
{
    _southWest = location;
    self.farleftlat = location.latitude;
    self.farleftlong = location.longitude;
}

- (void)setSouthEast:(CLLocationCoordinate2D)location
{
    _southEast = location;
    self.farrightlat = location.latitude;
    self.farrightlong = location.longitude;
}

- (NSDictionary *)parseSearchParams
{
    NSDictionary *filter = @{@"nearleftlat" : [NSNumber numberWithDouble:self.nearleftlat],
                             @"nearleftlong" : [NSNumber numberWithDouble:self.nearleftlong],
                             @"nearrightlat" : [NSNumber numberWithDouble:self.nearrightlat],
                             @"nearrightlong" : [NSNumber numberWithDouble:self.nearrightlong],
                             
                             @"farleftlat" : [NSNumber numberWithDouble:self.farleftlat],
                             @"farleftlong" : [NSNumber numberWithDouble:self.farleftlong],
                             @"farrightlat" : [NSNumber numberWithDouble:self.farrightlat],
                             @"farrightlong" : [NSNumber numberWithDouble:self.farrightlong]};
    
    NSDictionary *paging = @{@"limit" : [NSNumber numberWithInt:self.limitItem],
                             @"page" : [NSNumber numberWithInt:self.currentPage]};
    
    NSDictionary *ordering = @{@"name" : [NSNull null],
                               @"operator" : [NSNull null],
                               @"orderType" : [NSNumber numberWithInt:self.orderType]};
    
    NSDictionary *additional = @{@"paging" : paging,
                                 @"ordering" : ordering};
    
    NSDictionary *searchParams = @{@"filter" : filter,
                                   @"additional" : additional};
    
    return searchParams;
}

#pragma mark -
#pragma mark Define mapping
#pragma mark -

+ (NSMutableDictionary *)om_objectMapping
{
    NSMutableDictionary * mapping = [super om_objectMapping];
    if (mapping) {
        // @{ @"property_name": @"json_name"}
        NSDictionary * objectMapping = @{
                                         @"nearleftlat": @"nearleftlat",
                                         @"nearleftlong": @"nearleftlong",
                                         @"nearrightlat": @"nearrightlat",
                                         @"nearrightlong": @"nearrightlong",
                                         
                                         @"farleftlat": @"farleftlat",
                                         @"farleftlong": @"farleftlong",
                                         @"farrightlat": @"farrightlat",
                                         @"farrightlong": @"farrightlong",
                                         
                                         @"orderType": @"orderType",
                                         @"currentPage": @"currentPage",
                                         @"limitItem": @"limitItem"
                                         };
        [mapping addEntriesFromDictionary:objectMapping];
    }
    return mapping;
}


@end

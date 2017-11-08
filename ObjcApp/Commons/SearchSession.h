//
//  SearchSession.h
//  ObjcApp
//
//  Created by Dylan Bui on 11/8/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "DbObject.h"

@interface SearchSession : DbObject

// -- northWest - Tay Bac --
@property (nonatomic, assign) CLLocationCoordinate2D    northWest;
@property (nonatomic) double    nearleftlat;
@property (nonatomic) double    nearleftlong;
// -- northEast - Dong Bac --
@property (nonatomic, assign) CLLocationCoordinate2D    northEast;
@property (nonatomic) double    nearrightlat;
@property (nonatomic) double    nearrightlong;
// -- southWest - Tay Nam --
@property (nonatomic, assign) CLLocationCoordinate2D    southWest;
@property (nonatomic) double    farleftlat;
@property (nonatomic) double    farleftlong;
// -- southEast - Dong Nam --
@property (nonatomic, assign) CLLocationCoordinate2D    southEast;
@property (nonatomic) double    farrightlat;
@property (nonatomic) double    farrightlong;

@property (nonatomic) int      orderType;
//-- 1: Gia tăng dần
//-- 2: Giá giảm dần
//-- 3: Diện tích tăng dần
//-- 4: Diện tích giảm dần
@property (nonatomic) int      currentPage; // số thứ tự page
@property (nonatomic) int      limitItem; // số item muốn lấy cho 1 page

+ (id)instance;

- (NSDictionary *)parseSearchParams;

@end

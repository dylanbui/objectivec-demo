//
//  DbPlaceSearchViewController.h
//  ObjcApp
//
//  Created by Dylan Bui on 4/10/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DbUtils.h"
#import "GooglePlacesApiClient.h"

@class DbPlaceSearchViewController;

typedef void (^ DidReturnPlace)(DbPlaceSearchViewController *, GooglePlaceDetail *);

@interface DbPlaceSearchViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic, strong) NSString *apiKey;
@property (nonatomic, strong) NSString *language;
@property (nonatomic, strong) NSString *country;

@property (nonatomic) CLLocationCoordinate2D currentLocation;

@property (nonatomic) DidReturnPlace didReturnPlace;

- (instancetype)init;

- (void)addSubViewPlaceSearch;

@end

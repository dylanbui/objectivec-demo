//
//  DbPlaceSearchViewController.h
//  ObjcApp
//
//  Created by Dylan Bui on 4/10/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GooglePlacesApiClient.h"
@import GooglePlaces;

@interface DbPlaceSearchViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic, strong) NSString *apiKey;

@end

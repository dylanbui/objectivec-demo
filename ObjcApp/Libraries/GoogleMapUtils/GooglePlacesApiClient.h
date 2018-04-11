//
//  GooglePlacesApiClient.h
//  PropzyDiy
//
//  Created by Dylan Bui on 4/11/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "GoogleAutoCompleteResult.h"
#import "GooglePlace.h"

@interface GooglePlacesApiClient : NSObject

@property (strong, nonatomic) NSString *apiKey;
@property (strong, nonatomic) NSString *language;
@property (strong, nonatomic) NSString *country;

+ (instancetype)sharedInstance;

- (void)retrieveGooglePlaceInformation:(NSString *)searchWord withCompletion:(void (^)(NSArray *searchResults, NSError *error))completion;

- (void)retrieveJsonDetailsAbout:(NSString *)place withCompletion:(void (^)(GooglePlace *place, NSError *error))completion;

@end

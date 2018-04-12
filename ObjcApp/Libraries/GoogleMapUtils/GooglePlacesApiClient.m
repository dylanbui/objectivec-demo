//
//  GooglePlacesApiClient.m
//  PropzyDiy
//
//  Created by Dylan Bui on 4/11/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import "GooglePlacesApiClient.h"

#define apiUrlPlaceDetail @"https://maps.googleapis.com/maps/api/place/details/json?placeid=%@&sensor=true&key=%@"
#define apiUrlPlaceDetailByGps @"https://maps.googleapis.com/maps/api/geocode/json?latlng=%f,%f&sensor=true&key=%@"
#define apiUrlAutoComplete @"https://maps.googleapis.com/maps/api/place/autocomplete/json?input=%@&types=geocode&sensor=true&key=%@"

@interface GooglePlacesApiClient ()

@property (nonatomic, strong) NSCache *searchResultsCache;
@property (strong, nonatomic) NSMutableArray *searchResults;

@end

@implementation GooglePlacesApiClient

+ (instancetype)sharedInstance
{
    static GooglePlacesApiClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^(void){
        _sharedClient = [[GooglePlacesApiClient alloc] init];
    });
    
    return _sharedClient;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.country = @"VN";
        self.language = @"vi";
    }
    return self;
}

#pragma mark - Network Methods

// Demo : https://maps.googleapis.com/maps/api/place/autocomplete/json?input=50nhat&types=geocode&sensor=true&key=AIzaSyBK_MVp9sT3n-klZ4BIMnKHi1cjHJyYNFA&components=country:VN&language=vi
- (void)retrieveGooglePlaceInformation:(NSString *)searchWord withCompletion:(void (^)(NSArray *searchResults, NSError *error))completion
{
    if (!searchWord) {
        return;
    }
    
    searchWord = searchWord.lowercaseString;
    self.searchResults = [NSMutableArray array];
    
    if ([self.searchResultsCache objectForKey:searchWord]) {
        NSArray * pastResults = [self.searchResultsCache objectForKey:searchWord];
        self.searchResults = [NSMutableArray arrayWithArray:pastResults];
        completion(self.searchResults, nil);
    } else {
        NSString *urlString = [NSString stringWithFormat:apiUrlAutoComplete, searchWord, self.apiKey];
        urlString = [self addOptions:urlString];
        
        [self callGoogleServerApi:urlString withCompletion:^(NSDictionary *result, NSError *error) {
            if (error != nil) {
                completion(nil, error);
                return;
            }
            
            NSArray *results = [result valueForKey:@"predictions"];
            for (NSDictionary *jsonDictionary in results) {
                GoogleAutoCompleteResult *location = [[GoogleAutoCompleteResult alloc] initWithJSONData:jsonDictionary];
                [self.searchResults addObject:location];
            }
            
            // -- Save to cache --
            [self.searchResultsCache setObject:self.searchResults forKey:searchWord];
            completion(self.searchResults, nil);
        }];
    }
}

// Demo : https://maps.googleapis.com/maps/api/place/details/json?placeid=ChIJG0cCweYudTERk2_SnTRQJ0A&sensor=true&key=AIzaSyBK_MVp9sT3n-klZ4BIMnKHi1cjHJyYNFA&components=country:VN&language=vi
- (void)retrievePlaceDetailsById:(NSString *)placeId withCompletion:(void (^)(GooglePlaceDetail *place, NSError *error))completion
{
    NSString *urlString = [NSString stringWithFormat:apiUrlPlaceDetail, placeId, self.apiKey];
    urlString = [self addOptions:urlString];
    
    [self callGoogleServerApi:urlString withCompletion:^(NSDictionary *result, NSError *error) {
        if (error != nil) {
            completion(nil, error);
            return;
        }
        
        GooglePlaceDetail *place = [[GooglePlaceDetail alloc] initWithJSONData:[result valueForKey:@"result"]];
        completion(place, nil);
    }];
}

// Demo : https://maps.googleapis.com/maps/api/geocode/json?latlng=10.794369,106.680117&sensor=true&key=AIzaSyBK_MVp9sT3n-klZ4BIMnKHi1cjHJyYNFA
- (void)retrievePlaceDetailsByGps:(CLLocationCoordinate2D)location withCompletion:(void (^)(GooglePlaceDetail *place, NSError *error))completion
{
    NSString *urlString = [NSString stringWithFormat:apiUrlPlaceDetailByGps, location.latitude, location.longitude, self.apiKey];
    
    [self callGoogleServerApi:urlString withCompletion:^(NSDictionary *result, NSError *error) {
        if (error != nil) {
            completion(nil, error);
            return;
        }
        // -- ket qua tra ve la array --
        // -- not existed field name => name == [NSNull null] -- 
        NSArray *results = [result valueForKey:@"results"];
        GooglePlaceDetail *place = [[GooglePlaceDetail alloc] initWithJSONData:[results firstObject]];
        completion(place, nil);
    }];
    
}

#pragma mark - Properties

- (NSString *)addOptions:(NSString *)strUrl
{
    if (self.country != nil) {
        strUrl = [NSString stringWithFormat:@"%@&components=country:%@", strUrl, self.country];
    }
    if (self.language != nil) {
        strUrl = [NSString stringWithFormat:@"%@&language=%@", strUrl, self.language];
    }
    return strUrl;
}

- (NSMutableArray *)searchResults
{
    if (!_searchResults) {
        _searchResults = [NSMutableArray array];
    }
    return _searchResults;
}

- (NSCache *)searchResultsCache
{
    if (!_searchResultsCache) {
        _searchResultsCache = [[NSCache alloc] init];
    }
    return _searchResultsCache;
}

- (void)callGoogleServerApi:(NSString *)urlString withCompletion:(void (^)(NSDictionary *result, NSError *error))completion
{
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        if (error || [result[@"status"] isEqualToString:@"NOT_FOUND"] || [result[@"status"] isEqualToString:@"REQUEST_DENIED"]){
            if (!error){
                NSDictionary *userInfo = @{@"error":result[@"status"]};
                NSError *newError = [NSError errorWithDomain:@"API Error" code:666 userInfo:userInfo];
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(nil, newError);
                });
                return;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil, error);
            });
            return;
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(result, nil);
            });
        }
    }];
    
    [task resume];
}

@end

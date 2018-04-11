//
//  GooglePlacesApiClient.m
//  PropzyDiy
//
//  Created by Dylan Bui on 4/11/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import "GooglePlacesApiClient.h"

#define apiUrlPlaceDetail @"https://maps.googleapis.com/maps/api/place/details/json?placeid=%@&sensor=true&key=%@"
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

-(void)retrieveGooglePlaceInformation:(NSString *)searchWord withCompletion:(void (^)(NSArray *searchResults, NSError *error))completion {
    
    if (!searchWord) {
        return;
    }
    
    searchWord = searchWord.lowercaseString;
    
    self.searchResults = [NSMutableArray array];
    
    if ([self.searchResultsCache objectForKey:searchWord]) {
        NSArray * pastResults = [self.searchResultsCache objectForKey:searchWord];
        self.searchResults = [NSMutableArray arrayWithArray:pastResults];
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(self.searchResults, nil);
        });
    } else {
        
        NSString *urlString = [NSString stringWithFormat:apiUrlAutoComplete, searchWord, self.apiKey];
        urlString = [self addOptions:urlString];
        NSLog(@"%@", urlString);
        
        NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSDictionary *jSONresult = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];;
            
            if (error || [jSONresult[@"status"] isEqualToString:@"NOT_FOUND"] || [jSONresult[@"status"] isEqualToString:@"REQUEST_DENIED"]){
                if (!error){
                    NSDictionary *userInfo = @{@"error":jSONresult[@"status"]};
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
            } else {
                
                NSArray *results = [jSONresult valueForKey:@"predictions"];
                for (NSDictionary *jsonDictionary in results) {
                    GoogleAutoCompleteResult *location = [[GoogleAutoCompleteResult alloc] initWithJSONData:jsonDictionary];
                    [self.searchResults addObject:location];
                }
                
                // -- Save to cache --
                [self.searchResultsCache setObject:self.searchResults forKey:searchWord];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(self.searchResults, nil);
                });
            }
        }];
        
        [task resume];
    }
}

- (void)retrieveJsonDetailsAbout:(NSString *)place withCompletion:(void (^)(GooglePlace *place, NSError *error))completion
{
    // NSString *urlString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/details/json?placeid=%@&key=%@",place,apiKey];
    NSString *urlString = [NSString stringWithFormat:apiUrlPlaceDetail, place, self.apiKey];
    urlString = [self addOptions:urlString];
    
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
            // NSDictionary *placeDictionary = [result valueForKey:@"result"];
            GooglePlace *place = [[GooglePlace alloc] initWithJSONData:[result valueForKey:@"result"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(place, nil);
            });
        }
    }];
    
    [task resume];
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

@end

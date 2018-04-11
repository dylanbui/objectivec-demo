//
//  GoogleMapUtils.m
//  PropzyDiy
//
//  Created by Dylan Bui on 2/5/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "GoogleMapUtils.h"
#import <GoogleMaps/GoogleMaps.h>
//#import <MapKit/MapKit.h> // User for Apple Map

@interface GoogleMapUtils ()

//DATA FOR ROUTING
@property (strong, nonatomic) NSDictionary * duration;
@property (strong, nonatomic) NSDictionary * distance;
@property (strong, nonatomic) NSArray * routes;
@property (strong, nonatomic) NSString * overviewPolyLine;
@property (strong, nonatomic) NSArray * polylinePointsLocations;
@property (strong, nonatomic) NSArray * legs;
@property (strong, nonatomic) NSArray * steps;
@property (strong, nonatomic) CLLocation * startPoint;
@property (strong, nonatomic) CLLocation * endPoint;
@property (strong, nonatomic) NSArray * directions;

//@property (strong, nonatomic) MKPolyline * line;
@property (strong, nonatomic) GMSPolyline * line;
@property (strong, nonatomic) GMSPath * path;

//DATA FOR ADDRESS VALIDATION
@property (strong, nonatomic) NSArray * formattedAddresses;
@property (strong, nonatomic) NSArray * addressesGPSLocations;

@property (copy, nonatomic) RouteDirectionsObjectWeakSelfWithResponse callBackBlock;
@property (copy, nonatomic) AddressValidationObjectWeakSelfWithResponse validationCallBackBlock;
@property (copy, nonatomic) ReverseAddressObjectWeakSelfWithResponse reverseCallBackBlock;


- (void) createData:(NSDictionary *)response andError:(NSError**)anError;
- (NSURL*)generateURL:(NSString*)serviceURL params:(NSDictionary*)params;
- (NSMutableArray *)decodePolyLine:(NSString *)encodedStr;
//- (MKPolyline *) createMKPolylineAnnotation;

@end

@implementation GoogleMapUtils

@synthesize duration;
@synthesize distance;
@synthesize routes;
@synthesize overviewPolyLine;
@synthesize polylinePointsLocations;
@synthesize legs;
@synthesize steps;
@synthesize endPoint;
@synthesize startPoint;
@synthesize directions;
@synthesize line;
@synthesize path;

@synthesize addressesGPSLocations;
@synthesize formattedAddresses;

@synthesize callBackBlock;
@synthesize validationCallBackBlock;
@synthesize reverseCallBackBlock;

@synthesize googleApiKey;

- (instancetype)initWithGoogleApiKey:(NSString *)apiKey
{
    if (self = [super init]) {
        self.googleApiKey = apiKey;
    }
    return self;
}

- (void)createData:(NSDictionary *)response andError:(NSError**)anError
{
    self.routes = [response objectForKey:@"routes"];
    if (![self.routes count]) {
        NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
        [errorDetail setValue:@"No routes in the response" forKey:NSLocalizedDescriptionKey];
        *anError = [NSError errorWithDomain:@"it.cloudintouch.routedirectionsobject" code:100 userInfo:errorDetail];
        return;
    }
    self.legs = [[self.routes objectAtIndex:0] valueForKeyPath:@"legs"];
    self.steps = [[self.legs objectAtIndex:0] valueForKeyPath:@"steps"];
    self.duration = [[self.legs valueForKeyPath:@"duration"]lastObject];
    self.distance = [[self.legs valueForKeyPath:@"distance"]lastObject];
    NSDictionary * startPointDict = [[self.legs valueForKeyPath:@"start_location"]lastObject];
    NSDictionary * endPointDict = [[self.legs valueForKeyPath:@"end_location"]lastObject];
    self.startPoint = [[CLLocation alloc]initWithLatitude:[[startPointDict objectForKey:@"lat" ]doubleValue] longitude:[[startPointDict objectForKey:@"lng" ]doubleValue] ];
    self.endPoint = [[CLLocation alloc]initWithLatitude:[[endPointDict objectForKey:@"lat" ]doubleValue]  longitude:[[endPointDict objectForKey:@"lng" ]doubleValue] ];
    NSDictionary *route = [routes objectAtIndex:0];
    if (route) {
        self.overviewPolyLine = [[[self.routes valueForKeyPath: @"overview_polyline"] valueForKeyPath:@"points"]objectAtIndex:0];
        
        
        self.polylinePointsLocations = [self decodePolyLine:overviewPolyLine];
        CLLocation * endPointPoly = [self.polylinePointsLocations lastObject];
        float threshold = [self.endPoint distanceFromLocation:endPointPoly];
        if (fabs(threshold)>1000) {
            NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
            [errorDetail setValue:@"Inconsistent polyline" forKey:NSLocalizedDescriptionKey];
            *anError = [NSError errorWithDomain:@"it.cloudintouch.routedirectionsobject" code:300 userInfo:errorDetail];
        }
        
        self.directions = [self.steps valueForKeyPath:@"html_instructions"];
        self.path = [GMSPath pathFromEncodedPath:self.overviewPolyLine];
    }
    else{
        NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
        [errorDetail setValue:@"No route in the response" forKey:NSLocalizedDescriptionKey];
        *anError = [NSError errorWithDomain:@"it.cloudintouch.routedirectionsobject" code:200 userInfo:errorDetail];
    }
}

// -- User for Apple Map Kit --
//- (MKPolyline *) createMKPolylineAnnotation
//{
//    NSInteger numberOfSteps = [self.polylinePointsLocations count];
//
//    CLLocationCoordinate2D coordinates[numberOfSteps];
//    for (NSInteger index = 0; index < numberOfSteps; index++) {
//        CLLocation *location = [self.polylinePointsLocations objectAtIndex:index];
//        CLLocationCoordinate2D coordinate = location.coordinate;
//
//        coordinates[index] = coordinate;
//    }
//
//    return  [MKPolyline polylineWithCoordinates:coordinates count:numberOfSteps];
//}


-(NSMutableArray *)decodePolyLine:(NSString *)encodedStr
{
    NSMutableString *encoded = [[NSMutableString alloc] initWithCapacity:[encodedStr length]];
    [encoded appendString:encodedStr];
    [encoded replaceOccurrencesOfString:@"\\\\" withString:@"\\"
                                options:NSLiteralSearch
                                  range:NSMakeRange(0, [encoded length])];
    NSInteger len = [encoded length];
    NSInteger index = 0;
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSInteger lat=0;
    NSInteger lng=0;
    while (index < len) {
        NSInteger b;
        NSInteger shift = 0;
        NSInteger result = 0;
        do {
            b = [encoded characterAtIndex:index++] - 63;
            result |= (b & 0x1f) << shift;
            shift += 5;
        } while (b >= 0x20);
        NSInteger dlat = ((result & 1) ? ~(result >> 1) : (result >> 1));
        lat += dlat;
        shift = 0;
        result = 0;
        do {
            b = [encoded characterAtIndex:index++] - 63;
            result |= (b & 0x1f) << shift;
            shift += 5;
        } while (b >= 0x20);
        NSInteger dlng = ((result & 1) ? ~(result >> 1) : (result >> 1));
        lng += dlng;
        NSNumber *latitude = [[NSNumber alloc] initWithFloat:lat * 1e-5];
        NSNumber *longitude = [[NSNumber alloc] initWithFloat:lng * 1e-5];
        
        CLLocation *location = [[CLLocation alloc] initWithLatitude:[latitude floatValue] longitude:[longitude floatValue]];
        [array addObject:location];
    }
    
    return array;
}

- (NSURL*)generateURL:(NSString*)serviceURL params:(NSDictionary*)params
{
    NSString * composedURL = serviceURL;
    if (params) {
        NSMutableArray* pairs = [NSMutableArray array];
        for (NSString* key in params.keyEnumerator) {
            NSString* value = [params objectForKey:key];
            if (!value) {
                continue;
            }
            
            NSString* escaped_value = (NSString *) [value stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"!*'();:@&=+$,/?%#[]"]];
            
            [pairs addObject:[NSString stringWithFormat:@"%@=%@", key, escaped_value]];
        }
        
        NSString* query = [pairs componentsJoinedByString:@"&"];
        NSString* url = [NSString stringWithFormat:@"%@?%@", composedURL, query];
        //        NSLog(@"String url %@",url);
        return [NSURL URLWithString:url];
    } else {
        return [NSURL URLWithString:composedURL];
    }
}

- (void)createDirectionRequestWithStartPoint:(NSString*)aStartPoint andEndPoint:(NSString*)anEndPoint
                           withCallBackBlock:(RouteDirectionsObjectWeakSelfWithResponse)aBlock
{
    self.callBackBlock = aBlock;
    
    NSMutableString * string = [NSMutableString stringWithFormat: @"http://maps.googleapis.com/maps/api/directions/json"];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:[NSString stringWithFormat:@"%@", aStartPoint] forKey:@"origin"];
    [parameters setObject:[NSString stringWithFormat:@"%@", anEndPoint] forKey:@"destination"];
    [parameters setObject:@"true" forKey:@"sensor"];
    [parameters setObject:([[[NSLocale preferredLanguages]objectAtIndex:0] isEqualToString:@"it"] ? @"it" : @"en") forKey:@"language"];
    [parameters setObject:@"driving" forKey:@"mode"];
    // -- Add google api key --
    [parameters setObject:@"key" forKey:googleApiKey];
    
    NSURL * requestURL = [self generateURL:string params:parameters];
    //    NSLog(@"%@",requestURL);
    NSURLRequest * req = [[NSURLRequest alloc]initWithURL:requestURL];
    
    // Send a synchronous request
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData * data = [self sendSynchronousRequest:req returningResponse:&response error:&error];
    
    if (self.callBackBlock) {
        if (error) {
            self.callBackBlock(error, nil, nil, nil, nil, nil, nil, nil, nil);
            return ;
        }
        id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        if (error) {
            self.callBackBlock(error, nil, nil, nil, nil, nil, nil, nil, nil);
            return ;
        }
        [self createData:object andError:&error];
        if (error ) {
            
            if (error.code == 300){
                
                self.callBackBlock(nil, self.distance, self.duration, nil, self.routes, self.steps, self.startPoint, self.endPoint, self.directions);
                return;
            }
            else{
                self.callBackBlock(error, nil, nil, nil, nil, nil, nil, nil, nil);
                return ;
            }
        }
        
        self.callBackBlock(nil, self.distance, self.duration, self.path, self.routes, self.steps, self.startPoint, self.endPoint, self.directions);        
    }
    
    
}

- (void)validateAddress:(NSString*)anAddress withCallBackBlock:(AddressValidationObjectWeakSelfWithResponse)aBlock
{
    self.validationCallBackBlock = aBlock;
    
    NSMutableString * string = [NSMutableString stringWithFormat: @"http://maps.googleapis.com/maps/api/geocode/json"];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:[NSString stringWithFormat:@"%@", anAddress] forKey:@"address"];
    [parameters setObject:@"true" forKey:@"sensor"];
    // -- Add google api key --
    [parameters setObject:@"key" forKey:googleApiKey];
    
    NSURL * requestURL = [self generateURL:string params:parameters];
    NSLog(@"%@",requestURL);
    NSURLRequest * req = [[NSURLRequest alloc]initWithURL:requestURL];
    
    // Send a synchronous request
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData * data = [self sendSynchronousRequest:req returningResponse:&response error:&error];
    
    if (self.validationCallBackBlock) {
        if (error) {
            self.validationCallBackBlock(error, nil, nil, nil, nil);
            return ;
        }
        id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        if (error) {
            self.validationCallBackBlock(error, nil, nil, nil, nil);
            return ;
        }
        
        NSString * addressStatus = [object objectForKey:@"status"];
        if (![addressStatus isEqualToString:@"OK"]) {
            NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
            [errorDetail setValue:[object objectForKey:@"error_message"] forKey:NSLocalizedDescriptionKey];
            error = [NSError errorWithDomain:@"it.cloudintouch.routedirectionsobject" code:300 userInfo:errorDetail];
            self.validationCallBackBlock(error, addressStatus, nil, nil, nil);
            return;
        }
        
        NSArray * results = [object objectForKey:@"results"];
        self.formattedAddresses = [results valueForKeyPath:@"formatted_address"];
        NSArray * geometries = [results valueForKeyPath:@"geometry.location"];
        NSMutableArray * array = [[NSMutableArray alloc]initWithCapacity:50];
        for (NSDictionary * locationDict in geometries) {
            CLLocation * addressGPS = [[CLLocation alloc]initWithLatitude: [[locationDict objectForKey:@"lat"]doubleValue] longitude: [[locationDict objectForKey:@"lng"]doubleValue]];
            [array addObject:addressGPS];
        }
        
        self.addressesGPSLocations = [array copy];
        self.validationCallBackBlock(nil, addressStatus, self.formattedAddresses, self.addressesGPSLocations, results);
    }
    
}


- (void)reverseAddressFromLocation:(CLLocationCoordinate2D)location withCallBackBlock:(ReverseAddressObjectWeakSelfWithResponse)aBlock
{
    self.reverseCallBackBlock = aBlock;
    
    //    NSString *url = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%f,%f&sensor=true", location.latitude, location.longitude];
    NSMutableString * string = [NSMutableString stringWithFormat: @"http://maps.googleapis.com/maps/api/geocode/json"];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:[NSString stringWithFormat:@"%f,%f", location.latitude, location.longitude] forKey:@"latlng"];
    [parameters setObject:@"true" forKey:@"sensor"];
    // -- Add google api key --
    [parameters setObject:@"key" forKey:googleApiKey];
    
    NSURL * requestURL = [self generateURL:string params:parameters];
    NSLog(@"%@",requestURL);
    NSURLRequest * req = [[NSURLRequest alloc]initWithURL:requestURL];
    
    // Send a synchronous request
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData * data = [self sendSynchronousRequest:req returningResponse:&response error:&error];
    
    if (self.reverseCallBackBlock) {
        if (error) {
            self.reverseCallBackBlock(error, nil, nil, nil, nil);
            return ;
        }
        id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        if (error) {
            self.reverseCallBackBlock(error, nil, nil, nil, nil);
            return ;
        }
        
        NSString * addressStatus = [object objectForKey:@"status"];
        if (![addressStatus isEqualToString:@"OK"]) {
            NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
            [errorDetail setValue:[object objectForKey:@"error_message"] forKey:NSLocalizedDescriptionKey];
            error = [NSError errorWithDomain:@"it.cloudintouch.routedirectionsobject" code:300 userInfo:errorDetail];
            self.reverseCallBackBlock(error, addressStatus, nil, nil, nil);
            return;
        }
        
        NSArray * results = [object objectForKey:@"results"];
        self.formattedAddresses = [results valueForKeyPath:@"formatted_address"];
        NSArray * geometries = [results valueForKeyPath:@"geometry.location"];
        NSMutableArray * array = [[NSMutableArray alloc]initWithCapacity:50];
        for (NSDictionary * locationDict in geometries) {
            CLLocation * addressGPS = [[CLLocation alloc]initWithLatitude: [[locationDict objectForKey:@"lat"]doubleValue]
                                                                longitude: [[locationDict objectForKey:@"lng"]doubleValue]];
            [array addObject:addressGPS];
        }
        
        self.addressesGPSLocations = [array copy];
        self.reverseCallBackBlock(nil, addressStatus, self.formattedAddresses, self.addressesGPSLocations, results);
    }
    
}

- (NSData *)sendSynchronousRequest:(NSURLRequest *)request
                 returningResponse:(NSURLResponse **)response
                             error:(NSError **)error
{
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    
    
    NSError __block *err = NULL;
    NSData __block *data;
    NSURLResponse __block *resp;
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request
                                     completionHandler:^(NSData* _data, NSURLResponse* _response, NSError* _error) {
                                         resp = _response;
                                         err = _error;
                                         data = _data;
                                         dispatch_group_leave(group);
                                         
                                     }] resume];
    
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    
    if (response)
    {
        *response = resp;
    }
    if (error)
    {
        *error = err;
    }
    
    return data;
}


@end

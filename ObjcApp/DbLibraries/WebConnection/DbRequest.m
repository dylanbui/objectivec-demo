//
//  DbRequest.m
//  ObjcApp
//
//  Created by Dylan Bui on 12/25/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "DbRequest.h"

@interface DbRequest()

@end


@implementation DbRequest

- (instancetype)init
{
    if (self = [super init]) {
        self.requestId = 0;
        self.requestUrl = nil;
        self.method = DBRQ_GET;
        self.requestType = DBRQ_JSON;
        self.dictParams = nil;
        self.dictAdditionalHeaders = nil;
        
        // -- Define default --
        //self.dictAdditionalHeaders = @{@"Accept-Encoding": @"gzip", @"Accept-Language": @"vi-VN"};
        self.dictAdditionalHeaders = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"gzip", @"Accept-Encoding", @"vi-VN", @"Accept-Language", nil];
    }
    return self;
}

- (NSString *)getMethodName
{
    NSArray *arr = @[@"GET", @"POST", @"PUT", @"DELETE"];
    return (NSString *)[arr objectAtIndex:self.method];
}

#pragma mark - Private methods

- (void)addParamsToUrl:(NSDictionary *)params
{
    NSMutableString *strParams = [[NSMutableString alloc] init];
    NSArray *allkeys = [params allKeys];
    
    for (NSInteger index = 0; index < allkeys.count; index ++) {
        NSString *key = [allkeys objectAtIndex:index];
        id value = [params objectForKey:key];
        if ([value isKindOfClass:[NSString class]]) {
            // value = [self urlEncodeUsingEncoding:NSUTF8StringEncoding];
            value = [value stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
        if (index == 0) {
            [strParams appendFormat:@"%@=%@", key, value];
        }
        else {
            [strParams appendFormat:@"&%@=%@", key, value];
        }
        
    }
    self.requestUrl = [NSString stringWithFormat:@"%@%@", self.requestUrl, strParams];
}

//- (NSString *)urlEncodeUsingEncoding:(NSString *)unencodedString with:(NSStringEncoding)encoding
//{
//    return (NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
//                                                               (CFStringRef)unencodedString,
//                                                               NULL,
//                                                               (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
//                                                               CFStringConvertNSStringEncodingToEncoding(encoding));
//
////    return (NSString *)CFURLCreateStringByAddingPercentEscapes(
////                                                        NULL,
////                                                        (CFStringRef)unencodedString,
////                                                        NULL,
////                                                        (CFStringRef)@"!*'();:@&=+$,/?%#[]",
////                                                        CFStringConvertNSStringEncodingToEncoding(encoding));
//}



//- (NSString *)parameterListForGetMethod
//{
//    NSMutableString *strParams = [[NSMutableString alloc] init];
//    NSArray *allkeys = [self.paramDict allKeys];
//    for (NSInteger index = 0; index < allkeys.count; index ++) {
//        NSString *key = [allkeys objectAtIndex:index];
//        id value = [self.paramDict objectForKey:key];
//        if ([value isKindOfClass:[NSString class]]) {
//            value = [value urlEncodeUsingEncoding:NSUTF8StringEncoding];
//        }
//        if (index == 0) {
//            [strParams appendFormat:@"%@=%@", key, value];
//        }
//        else {
//            [strParams appendFormat:@"&%@=%@", key, value];
//        }
//    }
//    return [NSString stringWithString:strParams];
//}


@end


//@interface Request()
//@property (nonatomic, strong) NSString                  *externalUrl;
//@end
//
//@implementation Request
//
//- (id)init {
//    if (self = [super init]) {
//        _paramDict = [[NSMutableDictionary alloc] initWithCapacity:10];
//        self.additionalHeaders = [NSMutableDictionary dictionary];
//        self.method = @"POST";
//        _shouldFollowRedirect = YES;
//        _rqType = RQ_NOCACHE;
//        _cacheType = CT_RESPONSE;
//        _shouldSilentLogin = YES;
//        _shouldPrintLog = YES;
//    }
//    return self;
//}
//
//- (BOOL)hasBody {
//    if ([_method caseInsensitiveCompare:@"post"] == NSOrderedSame ||
//        [_method caseInsensitiveCompare:@"put"] == NSOrderedSame ||
//        [_method caseInsensitiveCompare:@"delete"] == NSOrderedSame) {
//        return TRUE;
//    }
//    return FALSE;
//}
//
//- (void)addParameter:(NSString *)name value:(id)val {
//    if (!name || !val) {
//        return;
//    }
//    if ([val isKindOfClass:[NSString class]]) {
//        //val = [Utils makeJsonEscapeCharacter:val];
//    }
//    [self.paramDict setValue:val forKey:name];
//}
//
//- (NSData *)getBodyOfRequestInJson {
//    if (self.customBody != nil) return self.customBody;
//    if ([self.paramDict count] == 0) return nil;
//    NSError *error = nil;
//    NSData *data = [NSJSONSerialization dataWithJSONObject:self.paramDict options:kNilOptions error:&error];
//    if (error) {
//        DLog(@"Generate JSON data failed: %@", error);
//        return nil;
//    }
//    return data;
//}
//
//- (NSString *)getTargetRequestURL {
//    NSString *url = [[[AppManager shareInstance] getServiceApis] objectForKey:[NSString stringWithFormat:@"cloud.api.url.%@.%@", self.service, self.entry]];
//    if (url.length == 0) {
//        return _externalUrl;
//    }
//    if (self.trailingParam.length > 0) {
//        url = [url stringByAppendingFormat:@"/%@", self.trailingParam];
//    }
//    if(![url containString:@"itunes.apple.com"] && ![url containString:@"graph.facebook.com"] && ![url containString:@"api.linkedin.com"]){
//        if ([self.method isEqualToString:@"GET"]) {
//            NSString *parameterList = [self parameterListForGetMethod];
//            if (parameterList.length > 0) {
//                url = [NSString stringWithFormat:@"%@?%@", url, parameterList];
//            }
//        }
//        else {
//            if([[UserManager shareInstance] isGuestMode]){
//                url = [NSString stringWithFormat:@"%@", url];
//            }
//            else{
//                url = [NSString stringWithFormat:@"%@?access_token=%@", url, [[UserManager shareInstance] getAppToken]];
//            }
//
//
//        }
//    }
//    if([url containString:@"graph.facebook.com"]) {
//        NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
//        NSString *userName  = [userdefault objectForKey:@"fbUsername"];
//        url = [url stringByReplacingOccurrencesOfString:@"me()" withString:[NSString stringWithFormat:@"'%@'", userName ]];
//    }
//    return url;
//}
//
//- (void)setAdditionalHeaderName:(NSString *)name value:(NSString *)val {
//    [_additionalHeaders setValue:val forKey:name];
//}
//
//- (NSDictionary *)getAdditionalHeaders {
//    return _additionalHeaders;
//}
//
//#pragma mark - cache methods
//- (NSString *)getTargetKeyForRequest {
//    //check cached folder
//    //Nam: note - shouldn't use NSData to hash.
//    NSMutableString *key = [NSMutableString string];
//    [key appendString:[self getTargetRequestURL]];
//    if ([self hasBody]) {
//        NSString *body = [[NSString alloc] initWithData:[self getBodyOfRequestInJson] encoding:NSUTF8StringEncoding];
//        [key appendString:body];
//    }
//    return [NSString stringWithFormat:@"%@", [key md5]];
//}
//
//- (void)setCustomUrl:(NSString *)customUrl {
//    self.externalUrl = customUrl;
//}
//#pragma mark - Private methods
//- (NSString *)parameterListForGetMethod {
//    NSMutableString *strParams = [[NSMutableString alloc] init];
//    NSArray *allkeys = [self.paramDict allKeys];
//    for (NSInteger index = 0; index < allkeys.count; index ++) {
//        NSString *key = [allkeys objectAtIndex:index];
//        id value = [self.paramDict objectForKey:key];
//        if ([value isKindOfClass:[NSString class]]) {
//            value = [value urlEncodeUsingEncoding:NSUTF8StringEncoding];
//        }
//        if (index == 0) {
//            [strParams appendFormat:@"%@=%@", key, value];
//        }
//        else {
//            [strParams appendFormat:@"&%@=%@", key, value];
//        }
//    }
//    return [NSString stringWithString:strParams];
//}
//@end


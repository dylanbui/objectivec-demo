//
//  NSObject+PropzyApi.m
//  PropzyTenant
//
//  Created by Dylan Bui on 5/19/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "NSObject+PropzyApi.h"

@implementation NSObject (PropzyApi)

+ (void)startUploadImageType:(NSString *)type
                andImageData:(id)imageData
                  parameters:(NSDictionary *)parameters
                    progress:(void (^)(NSProgress *uploadProgress))progress
           completionHandler:(void (^)(NSURLResponse *response, DbResponseObject *responseObject, NSError *error))completion
{
    
    UserSession *userSession = [UserSession instance];
    NSString *requestUrl = [NSString stringWithFormat:@"%@/upload?access_token=%@", UPLOAD_PHOTO_BASE_URL, userSession.accessToken];
    //http://124.158.14.26:9090/file/api
    // NSString *url = [NSString stringWithFormat:@"%@/upload", UPLOAD_PHOTO_BASE_URL];
    if (DEBUG_WEB_SERVICE) {
        NSLog(@"\n -- START -- \n requestUrl = %@ \n parameters = %@ \n -- END --", requestUrl, [parameters description]);
    }
    
    // -- Convert to array --
    NSArray *arrImageData;
    if ([imageData isKindOfClass:[UIImage class]]) {
        arrImageData = [[NSArray alloc] initWithObjects:imageData, nil];
    } else if ([imageData isKindOfClass:[NSArray class]]) {
        arrImageData = (NSArray *) imageData;
    }
    
    if (parameters == nil) {
        parameters = [[NSDictionary alloc] initWithObjectsAndKeys:type, @"type",nil];
    } else {
        NSMutableDictionary *dict = [parameters mutableCopy];
        [dict setObject:type forKey:@"type"];
        parameters = nil;
        parameters = dict;        
    }
    
    
    NSMutableArray *arrUploadData = [NSMutableArray new];
    NSString *fileName = [NSString stringWithFormat:@"%@.png", type];
    for (UIImage *img in arrImageData) {
        @autoreleasepool {
            NSDictionary* uploadData = [[NSDictionary alloc] initWithObjectsAndKeys:
                                        @"file", @"file_id",
                                        fileName, @"file_name",
                                        @"image/png", @"mime_type",
                                        UIImagePNGRepresentation(img), @"file_data",nil];
            
            [arrUploadData addObject:uploadData];
            uploadData = nil;
        }
    }
    
    DbWebConnection *service = [DbWebConnection instance];
    [service upload:requestUrl
     withParameters:parameters
      andUploadData:arrUploadData
           progress:^(NSProgress *uploadProgress) {
               progress(uploadProgress);
           }
  completionHandler:^(NSURLResponse *response, NSDictionary *responseDict, NSError *error) {
      if (error) {
          completion(response, nil, error);
          return;
      }
      // -- Convert data to ResponseObject --
      DbResponseObject *responseObject = [[DbResponseObject alloc] initWithDictionary_om:responseDict];
      completion(response, responseObject, error);
  }];
}


+ (void)startWebService:(NSString *)requestUrl
                 method:(NSString *)method
             parameters:(NSDictionary *)parameters
             withCallId:(int)callId
            andCallback:(id)callback
            showLoading:(bool)showLoading
{
    UserSession *userSession = [UserSession instance];
    requestUrl = [NSString stringWithFormat:@"%@?access_token=%@", requestUrl, userSession.accessToken];
    
    if (DEBUG_WEB_SERVICE) {
        NSLog(@"\n -- START -- \n requestUrl = %@ \n parameters = %@ \n callId = %d \n -- END --", requestUrl, [parameters description], callId);
    }
    
    DbResponseBlock callbackBlock = nil;
    id<IDbWebConnectionDelegate> callbackDelegate = nil;
    if ([callback isKindOfClass:NSClassFromString(@"NSBlock")]) {
        // -- Xu ly Block --
        callbackBlock = (DbResponseBlock) callback;
    } else {
        callbackDelegate = (id<IDbWebConnectionDelegate>)callback;
    }
    
    // -- Show loading --
    if (showLoading && callbackDelegate != nil) {
        [DbUtils showLoading:callbackDelegate];
    }
    
    [[DbWebConnection instance] request:requestUrl method:method parameters:parameters
                             progress:^(NSProgress *progress) {
                                 if (callbackDelegate != nil) {
                                     if ([callbackDelegate respondsToSelector:@selector(onRequestProgress:andCallerId:)]) {
                                         [callbackDelegate onRequestProgress:progress andCallerId:callId];
                                         return;
                                     }
                                     
                                 }
                             } success:^(NSURLSessionDataTask *sessionDataTask, id response) {
                                 if (DEBUG_WEB_SERVICE) {
                                     NSLog(@"\n----- RETURN ------ \n %@ \n----- RETURN ------", [response description]);
                                 }
                                 
                                 // -- Hide loading --
                                 if (showLoading && callbackDelegate != nil) {
                                     [DbUtils hideLoading:callbackDelegate];
                                 }
                                 
                                 // -- Convert data to ResponseObject --
                                 DbResponseObject *responseObject = [[DbResponseObject alloc] initWithDictionary_om:response];
                                 
                                 if (callbackDelegate != nil) {
                                     [callbackDelegate onRequestCompleteWithContent:responseObject andCallerId:callId];
                                 } else {
                                     callbackBlock(responseObject, nil);
                                 }
                                 
                             } failure:^(NSURLSessionDataTask *sessionDataTask, NSError *error) {
                                 // -- Hide loading --
                                 if (showLoading && callbackDelegate != nil) {
                                     [DbUtils hideLoading:callbackDelegate];
                                 }
                                 
                                 // -- Error --
                                 if (callbackDelegate != nil) {
                                     [callbackDelegate onRequestErrorWithContent:@"Error" andCallerId:callId andError:error];
                                 } else {
                                     callbackBlock(nil, error);
                                 }
                             }];
    
}



@end

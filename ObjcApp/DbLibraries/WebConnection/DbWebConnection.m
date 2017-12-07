//
//  WebConnection.m
//  PropzyDiy
//
//  Created by Dylan Bui on 2/13/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "DbWebConnection.h"

// -- DbUploadData --

@interface DbUploadData()

@end

@implementation DbUploadData

- (NSString *)description
{
    NSDictionary *dict = @{@"fileId": self.fileId, @"mimeType": self.mimeType,
                           @"fileName": self.fileName, @"fileLength": @(self.fileData.length)};
    return [dict description];
}

@end

// -- DbWebConnection --

@interface DbWebConnection ()

@property (nonatomic,strong) AFHTTPSessionManager* sessionManager;

@end

@implementation DbWebConnection

@synthesize sessionManager;
@synthesize isReachable;

+ (id)instance
{
    static DbWebConnection *__instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance = [[DbWebConnection alloc] init];
    });
    return __instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isReachable = [[AFNetworkReachabilityManager sharedManager] isReachable];
        self.sessionManager = [AFHTTPSessionManager manager];
    }
    return self;
}

#pragma mark -
#pragma mark - Run with delegate
#pragma mark -

- (void)get:(NSString *)strURL
 parameters:(NSDictionary *)dictParams
withDelegate:(id<IDbWebConnectionDelegate>)delegate
andCallerId:(int)callerId
{
    [self request:strURL method:@"GET" parameters:dictParams withDelegate:delegate andCallerId:callerId];
}

- (void)post:(NSString *)strURL
  parameters:(NSDictionary *)dictParams
withDelegate:(id<IDbWebConnectionDelegate>)delegate
 andCallerId:(int)callerId
{
    [self request:strURL method:@"POST" parameters:dictParams withDelegate:delegate andCallerId:callerId];
}

- (void)request:(NSString *)strURL
         method:(NSString *)method
     parameters:(NSDictionary *)dictParams
   withDelegate:(id<IDbWebConnectionDelegate>)delegate
    andCallerId:(int)callerId
{
    [self request:strURL method:method parameters:dictParams
         progress:^(NSProgress *progress) {
             if ([delegate respondsToSelector:@selector(onRequestProgress:andCallerId:)]) {
                 [delegate onRequestProgress:progress andCallerId:callerId];
             }
         }
          success:^(NSURLSessionDataTask *task, id responseObject) {
              if([responseObject isKindOfClass:[NSDictionary class]] || [responseObject isKindOfClass:[NSArray class]]) {
                  if ([delegate respondsToSelector:@selector(onRequestCompleteWithContent:andCallerId:)]) {
                      [delegate onRequestCompleteWithContent:responseObject andCallerId:callerId];
                      return;
                  }
              }
              // -- Call error --
              if ([delegate respondsToSelector:@selector(onRequestErrorWithContent:andCallerId:andError:)]) {
                  // -- Error tranfer data to server --
                  NSError* error = [self errorTransferDataWithTitle:@"JSON parsing failed" link:strURL
                                                       transferData:dictParams
                                                         returnData:responseObject code:WS_RETURN_ERROR];
                  [delegate onRequestErrorWithContent:@"Error" andCallerId:callerId andError:error];
              }
          }
          failure:^(NSURLSessionDataTask *task, NSError *error) {
              if ([delegate respondsToSelector:@selector(onRequestErrorWithContent:andCallerId:andError:)]) {
                  [delegate onRequestErrorWithContent:@"Error" andCallerId:callerId andError:error];
              }
          }];
}

#pragma mark -
#pragma mark - Run with Block
#pragma mark -

- (void)get:(NSString *)strURL
 parameters:(NSDictionary *)dictParams
  withBlock:(DbResponseBlock)block
{
    [self request:strURL method:@"GET" parameters:dictParams progress:nil
          success:^(NSURLSessionDataTask *task, id responseObject) {
              block(responseObject, nil);
          }
          failure:^(NSURLSessionDataTask *task, NSError *error) {
              block(nil, error);
          }];
}

- (void)post:(NSString *)strURL
  parameters:(NSDictionary *)dictParams
   withBlock:(DbResponseBlock)block
{
    [self request:strURL method:@"POST" parameters:dictParams progress:nil
          success:^(NSURLSessionDataTask *task, id responseObject) {
              block(responseObject, nil);
          }
          failure:^(NSURLSessionDataTask *task, NSError *error) {
              block(nil, error);
          }];
}

#pragma mark -
#pragma mark - Root connect function
#pragma mark -

- (void)request:(NSString *)strURL
         method:(NSString *)method
     parameters:(NSDictionary *)dictParams
       progress:(void (^)(NSProgress *))downloadProgress
        success:(void (^)(NSURLSessionDataTask *, id))success
        failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    // -- Cellular Data Is Turned Off --
    if (!self.isReachable)
    {
        NSError* error = [self errorNetworkConnection];
        failure(nil, error);
        return;
    }

    // -- Set Request is Json --
    [sessionManager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    // -- Set Response is Json --
    [sessionManager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    
    NSError *serializationError = nil;
    NSMutableURLRequest *request = [sessionManager.requestSerializer requestWithMethod:method
                                                                             URLString:[[NSURL URLWithString:strURL relativeToURL:nil] absoluteString]
                                                                            parameters:dictParams
                                                                                 error:&serializationError];
    // -- Use gzip decompression --
    [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"vi-VN" forHTTPHeaderField:@"Accept-Language"];
    
    if (serializationError) {
        NSLog(@"serializationError : %@", [serializationError description]);
        return;
    }
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [sessionManager dataTaskWithRequest:request
                         uploadProgress:^(NSProgress * _Nonnull _uploadProgress) { }
                       downloadProgress:^(NSProgress * _Nonnull _downloadProgress) {
                           if (downloadProgress != nil) {
                               downloadProgress(_downloadProgress);
                           }
                       }
                      completionHandler:^(NSURLResponse * _Nonnull _response, id  _Nullable _responseObject, NSError * _Nullable _error) {
                          // -- Error --
                          if (_error) {
                              failure(dataTask, _error);
                              return;
                          }
                          
                          if([_responseObject isKindOfClass:[NSDictionary class]] || [_responseObject isKindOfClass:[NSArray class]]) {
                              // -- Success --
                              success(dataTask, _responseObject);
                              return;
                          }

                          // -- Call error : Error tranfer data to server --
                          NSError* err = [self errorTransferDataWithTitle:@"JSON parsing failed" link:strURL
                                                             transferData:dictParams
                                                               returnData:_responseObject code:WS_RETURN_ERROR];
                          failure(dataTask, err);
                      }];
    [dataTask resume];
}

#pragma mark -
#pragma mark - Upload function
#pragma mark -

/*
 NSData *imageData = UIImageJPEGRepresentation([UIImage imageNamed:@"basics_iphone1.jpg"], 1);
 NSDictionary* uploadData = [[NSDictionary alloc] initWithObjectsAndKeys:@"userfile",@"file_id",
 @"splash_default.jpg",@"file_name",
 @"image/jpeg",@"mime_type",
 imageData,@"file_data",nil];
 */

- (void)upload:(NSString *)strUrl
withParameters:(NSDictionary *)dictParams
 andUploadData:(id)uploadData
      progress:(void (^)(NSProgress *uploadProgress))progress
completionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completion
{
    // -- Cellular Data Is Turned Off --
    if (!self.isReachable)
    {
        NSError* error = [self errorNetworkConnection];
        completion(nil, nil, error);
        return;
    }
    
    // -- Set Response is Json --
    [sessionManager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    
    NSMutableURLRequest *request =
    [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:strUrl parameters:dictParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        // -- Convert to array --
        NSArray *arrUploadData;
        if ([uploadData isKindOfClass:[DbUploadData class]]) {
            arrUploadData = [[NSArray alloc] initWithObjects:uploadData, nil];
        } else if ([uploadData isKindOfClass:[NSArray class]]) {
            arrUploadData = (NSArray *) uploadData;
        }
        
        for (DbUploadData *data in arrUploadData) {
            @autoreleasepool {
                [formData appendPartWithFileData:data.fileData
                                            name:data.fileId
                                        fileName:data.fileName
                                        mimeType:data.mimeType];
            }
//                        [formData appendPartWithFileData:UIImageJPEGRepresentation([UIImage imageNamed:@"demo_1.jpg"], 1.0)
//                                                    name:@"image_file"
//                                                fileName:@"bg_merge_1.jpg"
//                                                mimeType:@"image/jpeg"];
        }
        
        
    } error:nil];
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [sessionManager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      // This is not called back on the main queue.
                      // You are responsible for dispatching to the main queue for UI updates
//                      dispatch_async(dispatch_get_main_queue(), ^{ // -- Update the progress view -- });
                      progress(uploadProgress);
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      completion(response, responseObject, error);
                  }];    
    [uploadTask resume];
}

#pragma mark -
#pragma mark - Sync Request
#pragma mark -

- (NSDictionary *)syncRequestJsonWithUrl:(NSString *)requestString
                                response:(NSURLResponse **)response
                                   error:(NSError **)error
{
    NSURL *url = [NSURL URLWithString:requestString];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url
                                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                          timeoutInterval:50];
    theRequest.HTTPMethod = @"GET";
    [theRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSData *data = [self syncRequest:theRequest response:response error:error];
    NSError *e = nil;
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&e];
    return jsonData;
}

- (NSDictionary *)postSynchronousJsonDataWithURLString:(NSString *)requestString
                                                params:(NSDictionary *)params
                                     returningResponse:(NSURLResponse **)response
                                                 error:(NSError **)error
{    
    NSURL *url = [NSURL URLWithString:requestString];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url
                                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                          timeoutInterval:10];
    
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSString *postString = [self generateParams:params];
    
    [theRequest setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];

    NSData *data = [self syncRequest:theRequest response:response error:error];
    NSError *e = nil;
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&e];
    return jsonData;
}

- (NSData *)syncRequest:(NSURLRequest *)request
               response:(NSURLResponse **)response
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
    
    if (response) {
        *response = resp;
    }
    if (error) {
        *error = err;
    }
    
    return data;
}

#pragma mark -
#pragma mark === Private Function ===
#pragma mark -

- (NSError *)errorNetworkConnection
{
    // -- Error call server --
    // Init my error : An error occurred
    NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
    [errorDetail setValue:@"Cellular Data Is Turned Off" forKey:NSLocalizedDescriptionKey];
    return [NSError errorWithDomain:@"WebServiceClientErrorDomain" code:WS_NETWORK_CONNECTION_ERROR userInfo:errorDetail];
}

- (NSError *)errorTransferDataWithTitle:(NSString *)title link:(NSString *)link
                           transferData:(NSDictionary *)transferData
                             returnData:(id)returnData
                                   code:(int)code
{
    // -- Error tranfer data to server --
    NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
    [errorDetail setValue:title forKey:NSLocalizedDescriptionKey];
    [errorDetail setValue:link forKey:@"link"];
    [errorDetail setValue:transferData forKey:@"transferData"];
    [errorDetail setValue:returnData forKey:@"returnData"];
    return [NSError errorWithDomain:@"WebConnectionErrorDomain" code:code userInfo:errorDetail];
}

- (NSString *)generateParams:(NSDictionary*)params
{
    NSMutableArray* pairs = [NSMutableArray array];
    for (NSString* key in params.keyEnumerator) {
        NSString* value = [params objectForKey:key];
        if (!value) {
            continue;
        }
        // deprecated in iOS 9.0
        //            NSString* escaped_value = (__bridge_transfer  NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)value, NULL,(CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8);
        NSString* escaped_value = (NSString *) [value stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"!*'();:@&=+$,/?%#[]"]];
        
        [pairs addObject:[NSString stringWithFormat:@"%@=%@", key, escaped_value]];
    }
    
    return [pairs componentsJoinedByString:@"&"];
}

@end

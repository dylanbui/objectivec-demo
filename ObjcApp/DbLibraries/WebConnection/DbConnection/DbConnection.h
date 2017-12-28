//
//  DbConnection.h
//  ObjcApp
//
//  Created by Dylan Bui on 12/25/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "AFNetworkReachabilityManager.h"

#import "DbRequest.h"
#import "DbUploadRequest.h"
#import "DbResponse.h"

#define WS_DEFAULT_HTTP_ERROR 1000
#define WS_CONNECTION_HTTP_ERROR WS_DEFAULT_HTTP_ERROR + 1
#define WS_URL_ERROR WS_CONNECTION_HTTP_ERROR + 1
#define WS_JSON_PARSING_FAILED WS_URL_ERROR + 1
#define WS_RETURN_ERROR WS_JSON_PARSING_FAILED + 1
#define WS_NETWORK_CONNECTION_ERROR WS_RETURN_ERROR + 1

//typedef void (^DbConnectionBlock)(id response, NSError *error);
typedef void (^DbConnectionBlock)(DbResponse *response, NSError *error);

@protocol IDbConnectionDelegate;


@interface DbConnection : NSObject

@property (atomic) bool                             isReachable;


+ (id)instance;

- (void)dispatchRequest:(DbRequest *)request onResponse:(DbResponse *)response withDelegate:(id<IDbConnectionDelegate>)delegate;
- (void)dispatchRequest:(DbRequest *)request onResponse:(DbResponse *)response withBlock:(DbConnectionBlock)block;


- (void)get:(NSString *)strURL
 parameters:(NSDictionary *)dictParams
withDelegate:(id<IDbConnectionDelegate>)delegate
andCallerId:(int)callerId;

- (void)post:(NSString *)strURL
  parameters:(NSDictionary *)dictParams
withDelegate:(id<IDbConnectionDelegate>)delegate
 andCallerId:(int)callerId;

//- (void)request:(NSString *)strURL
//         method:(NSString *)method
//     parameters:(NSDictionary *)dictParams
//   withDelegate:(id<IDbConnectionDelegate>)delegate
//    andCallerId:(int)callerId;

- (void)get:(NSString *)strURL
 parameters:(NSDictionary *)dictParams
  withBlock:(DbConnectionBlock)block;

- (void)post:(NSString *)strURL
  parameters:(NSDictionary *)dictParams
   withBlock:(DbConnectionBlock)block;

//- (void)request:(NSString *)strURL
//         method:(NSString *)method
//     parameters:(NSDictionary *)dictParams
//       progress:(void (^)(NSProgress *))downloadProgress
//        success:(void (^)(NSURLSessionDataTask *, id))success
//        failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;

- (void)dispatchUploadRequest:(DbUploadRequest *)uploadRequest
                   onResponse:(DbResponse *)response
                     progress:(void (^)(NSProgress *uploadProgress))progress
            completionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completion;

- (void)upload:(NSString *)strUrl
withParameters:(NSDictionary *)dictParams
 andUploadData:(id)uploadData
      progress:(void (^)(NSProgress *uploadProgress))progress
completionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completion;


#pragma mark Sync Request

/*
 
 Use :
 
 // Send a synchronous request
 NSURLResponse *response = nil;
 NSError *error = nil;
 NSData *data = [NSURLSession sendSynchronousRequest:req returningResponse:&response error:&error];
 
 if (error) {
 // Error
 } else {
 // convert data to string
 NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
 // convert json data to object
 NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&e];
 }
 
 */

- (NSDictionary *)syncRequestJsonWithUrl:(NSString *)requestString
                                response:(NSURLResponse **)response
                                   error:(NSError **)error;

- (NSDictionary *)postSynchronousJsonDataWithURLString:(NSString *)requestString
                                                params:(NSDictionary *)params
                                     returningResponse:(NSURLResponse **)response
                                                 error:(NSError **)error;

- (NSData *)syncRequest:(NSURLRequest *)request
               response:(NSURLResponse **)response
                  error:(NSError **)error;

@end


@protocol IDbConnectionDelegate <NSObject>

@required

- (void)onRequest:(DbRequest *)request completeWithResponse:(DbResponse *)response;
- (void)onRequest:(DbRequest *)request withError:(NSError*)error;

- (void)onRequestCompleteWithContent:(id)content andCallerId:(int)callerId;
- (void)onRequestErrorWithContent:(id)content andCallerId:(int)callerId andError:(NSError*) error;

@optional

- (void)onRequest:(DbRequest *)request withProgress:(NSProgress *)downloadProgress;
- (void)onRequestProgress:(NSProgress *)downloadProgress andCallerId:(int)callerId;

@end

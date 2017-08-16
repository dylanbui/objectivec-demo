//
//  NSObject+PropzyApi.h
//  PropzyTenant
//
//  Created by Dylan Bui on 5/19/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constant.h"
#import "UserSession.h"
#import "DbWebConnection.h"
#import "DbResponseObject.h"

@interface NSObject (PropzyApi)

+ (void)startUploadImageType:(NSString *)type
                andImageData:(id)imageData
                  parameters:(NSDictionary *)parameters
                    progress:(void (^)(NSProgress *uploadProgress))progress
           completionHandler:(void (^)(NSURLResponse *response, DbResponseObject *responseObject, NSError *error))completion;


+ (void)startWebService:(NSString *)requestUrl
                 method:(NSString *)method
             parameters:(NSDictionary *)parameters
             withCallId:(int)callId
            andCallback:(id)callback
            showLoading:(bool)showLoading;


@end

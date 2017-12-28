//
//  DbRequest.h
//  ObjcApp
//
//  Created by Dylan Bui on 12/25/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DbObject.h"

//typedef enum _DB_REQUEST_TYPE {
//    DBRQ_NOCACHE = 1,
//    DBRQ_GETCACHEFIRST = 2,
//    DBRQ_GETCACHEIFFAILED = 4,
//    DBRQ_SAVEDATA = 8
//} DB_REQUEST_TYPE;

typedef enum _DB_REQUEST_METHOD {
    DBRQ_GET,
    DBRQ_POST,
    DBRQ_PUT,
    DBRQ_DELETE
} DB_REQUEST_METHOD;

typedef enum _DB_REQUEST_TYPE {
    DBRQ_NORMAL,
    DBRQ_JSON
} DB_REQUEST_TYPE;


typedef enum _CACHETYPE {
    CT_RESPONSE,
    CT_THUMBNAIL
} CACHETYPE;

//AFHTTPRequestSerializer

@protocol IDbRequest <NSObject>

@end


@interface DbRequest : DbObject

@property (nonatomic, assign)   int                 requestId;
@property (nonatomic, strong) NSString                  *requestUrl;
@property (nonatomic, assign)   DB_REQUEST_METHOD                method;
//@property (nonatomic, assign)   DB_REQUEST_POST_TYPE            rqPostType;
@property (nonatomic, assign)   DB_REQUEST_TYPE                 requestType;

//@property (nonatomic, strong)     NSString                *service;
//@property (nonatomic, strong)     NSString                *entry;
//@property (nonatomic, strong)     NSString                *extFolder;
//@property (nonatomic, strong)   NSString                *trailingParam;
//@property (nonatomic, assign)   BOOL                    shouldFollowRedirect;
//@property (nonatomic, assign)   CACHETYPE               cacheType;
//@property (nonatomic, assign)   BOOL                    shouldSilentLogin;

//@property (nonatomic, strong)   NSMutableDictionary     *dictParams;
@property (nonatomic, strong)   NSDictionary     *dictParams;
@property (nonatomic, strong)   NSMutableDictionary     *dictAdditionalHeaders;

//@property (nonatomic, strong)   NSData                  *customBody;
//@property (nonatomic, assign)   BOOL                    shouldPrintLog;

- (void)addParamsToUrl:(NSDictionary *)params;

- (NSString *)getMethodName;
- (NSString *)getRequestTypeName;

- (void)addAdditionalHeaders:(NSDictionary *)dict;
- (void)addAdditionalHeaders:(NSString *)value forKey:(NSString *)key;


//- (BOOL)hasBody;
//- (void)addParameter:(NSString *)name value:(id)val;
//- (NSData *)getBodyOfRequestInJson;
//- (NSString *)getTargetRequestURL;
//- (void)setAdditionalHeaderName:(NSString *)name value:(NSString *)val;
//- (NSDictionary *)getAdditionalHeaders;
//- (NSString *)getTargetKeyForRequest;
//- (void)setCustomUrl:(NSString *)customUrl;

@end

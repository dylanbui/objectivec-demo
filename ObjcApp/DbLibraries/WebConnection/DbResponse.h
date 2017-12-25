//
//  DbResponse.h
//  ObjcApp
//
//  Created by Dylan Bui on 12/25/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DbObject.h"
#import "DbRequest.h"

typedef enum _DB_RESPONSE_TYPE {
    DBRP_NORMAL = 1,
    DBRP_JSON = 2
} DB_RESPONSE_TYPE;





@interface DbResponse : DbObject

@property (nonatomic, strong) DbRequest          *request;
@property (nonatomic) id                        responseBody;
@property (nonatomic, assign)   DB_RESPONSE_TYPE                 responseType;


@property (nonatomic, strong) NSString          *message;
@property (nonatomic) BOOL                      result;
@property (nonatomic) int                       code;
@property (nonatomic) id                        data;

- (void)parseResponseBody:(id)data;

@end



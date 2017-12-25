//
//  DbResponse.m
//  ObjcApp
//
//  Created by Dylan Bui on 12/25/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "DbResponse.h"

@implementation DbResponse

@synthesize message;
@synthesize result;
@synthesize code;
@synthesize data;

- (void)parseResponseBody:(id)data
{
    self.responseBody = data;
    if ([data isKindOfClass:[NSDictionary class]]) {
        self.data = [data objectForKey:@"data"];
        self.message = [data objectForKey:@"message"];
        self.code = [[data objectForKey:@"code"] intValue];
        self.result = [[data objectForKey:@"result"] boolValue];
    }
}

- (NSString *)description
{
    return @"";
}

+ (NSMutableDictionary *)om_objectMapping
{
    NSMutableDictionary * mapping = [super om_objectMapping];
    if (mapping) {
        NSDictionary * objectMapping = @{ @"message": @"message",
                                          @"result": @"result",
                                          @"code": @"code",
                                          @"data": @"data" };
        [mapping addEntriesFromDictionary:objectMapping];
    }
    return mapping;
}


@end

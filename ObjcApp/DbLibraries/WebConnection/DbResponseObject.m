//
//  ResponseObject.m
//  SAM_Demo
//
//  Created by Dylan Bui on 1/3/17.
//  Copyright © 2017 Dylan Bui. All rights reserved.
//

#import "DbResponseObject.h"

@implementation DbResponseObject

@synthesize message;
@synthesize result;
@synthesize code;
@synthesize data;

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

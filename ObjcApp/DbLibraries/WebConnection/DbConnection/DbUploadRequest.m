//
//  DbUploadRequest.m
//  ObjcApp
//
//  Created by Dylan Bui on 12/25/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "DbUploadRequest.h"

@interface DbUploadRequest()

@end

@implementation DbUploadRequest

- (instancetype)init {
    if (self = [super init]) {
        self.method = DBRQ_POST;
    }
    return self;    
}


- (NSString *)description
{
    return @"";
//    NSDictionary *dict = @{@"fileId": self.fileId, @"mimeType": self.mimeType,
//                           @"fileName": self.fileName, @"fileLength": @(self.fileData.length)};
//    return [dict description];
}

@end

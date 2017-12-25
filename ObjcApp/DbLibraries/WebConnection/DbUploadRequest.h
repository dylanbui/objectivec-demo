//
//  DbUploadRequest.h
//  ObjcApp
//
//  Created by Dylan Bui on 12/25/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DbRequest.h"

@interface DbUploadData : NSObject

@property (nonatomic, strong) NSData *fileData;
@property (nonatomic, strong) NSString *fileId;
@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, strong) NSString *mimeType;

@end


@interface DbUploadRequest : DbRequest

@property (nonatomic, strong) id uploadData;

@end

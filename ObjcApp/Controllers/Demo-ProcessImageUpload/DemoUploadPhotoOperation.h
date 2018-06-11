//
//  DemoUploadPhotoOperation.h
//  ObjcApp
//
//  Created by Dylan Bui on 6/12/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import "DbOperation.h"

@interface DemoUploadPhotoOperation : DbOperation

@property (nonatomic, strong) NSString *uploadUrl;

@property (nonatomic) int indexPhoto;
@property (nonatomic) int totalPhoto;

@property (nonatomic, copy) void (^uploadProgressOperationBlock)(id result, NSProgress *uploadProgress);

- (instancetype)init;


@end

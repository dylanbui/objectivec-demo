//
//  UploadPhotoOperation.h
//  PropzyDiy
//
//  Created by Dylan Bui on 3/31/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

//#import "Constant.h"
#import "DbOperation.h"
#import "DbOperationQueue.h"

#import "DbWebConnection.h"
#import "DbResponseObject.h"
//#import "DbUploadData.h"
#import "MBProgressHUD.h"


@interface DbUploadOperation : DbOperation

//@property (weak) id <IDbWebConnectionDelegate> delegate;

//@property (nonatomic, strong) DbUploadData *uploadData;
@property (nonatomic, strong) NSString *uploadUrl;
@property (nonatomic, strong) id uploadData;
@property (nonatomic, strong) NSString *mineType;
@property (nonatomic, strong) NSDictionary *attachParams;

@property (nonatomic, strong) MBProgressHUD *processView;

//@property (nonatomic) int indexPhoto;
//@property (nonatomic) int totalPhoto;

/**
 Completion block to be called once the the request and parsing is completed. Will return the parsed answers or nil.
 */
@property (nonatomic, copy) void (^progressOperationBlock)(NSProgress *progress);



- (instancetype)init;

@end

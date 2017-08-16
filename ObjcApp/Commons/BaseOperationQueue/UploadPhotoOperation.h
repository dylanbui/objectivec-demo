//
//  UploadPhotoOperation.h
//  PropzyDiy
//
//  Created by Dylan Bui on 3/31/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "BaseOperation.h"
#import "PhotoDataTable.h"
#import "MBProgressHUD.h"

@interface UploadPhotoOperation : BaseOperation

@property (nonatomic, strong) PhotoDataTable *uploadPhoto;
@property (nonatomic, strong) NSString *uploadUrl;
@property (nonatomic, strong) MBProgressHUD *processView;

@property (nonatomic) int indexPhoto;
@property (nonatomic) int totalPhoto;


- (instancetype)init;

@end

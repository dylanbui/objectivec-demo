//
//  UploadPhotoOperation.m
//  PropzyDiy
//
//  Created by Dylan Bui on 3/31/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "DbUploadOperation.h"

@implementation DbUploadOperation

#pragma mark - Init

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

#pragma mark - Start

- (void)start
{
    // -- Start task --
    [super start];
    
    if (self.startOperationBlock != nil)
        self.startOperationBlock(self, nil);
    
    DbUploadData* dbUploadData = [[DbUploadData alloc] init];
    dbUploadData.fileId = @"file";
    dbUploadData.fileName = @"none_type";
    dbUploadData.mimeType = self.mineType;
    
    if ([self.mineType isEqualToString:@"image/jpeg"] || [self.mineType isEqualToString:@"image/jpg"]) {
        dbUploadData.fileName = @"file_image.jpg";
        dbUploadData.fileData = UIImageJPEGRepresentation(self.uploadData, 1.0);
    } else if ([self.mineType isEqualToString:@"image/png"]) {
        dbUploadData.fileName = @"file_image.png";
        dbUploadData.fileData = UIImagePNGRepresentation(self.uploadData);
    } else {
        dbUploadData.fileName = @"none_type";
        dbUploadData.fileData = self.uploadData;
    }
    
    // -- Cach tinh % tren tong so file --
    /*
     double balance = 1.0 / [tong file];
     i <=> For i tung file
     double fractionCompleted = (i * balance) + (progress.fractionCompleted * balance);
     NSLog(@"fractionCompleted => %f", fractionCompleted);
     fractionCompleted = MIN(1.0, fractionCompleted);
     self.processView.progress = fractionCompleted;
     */
    
    DbWebConnection *service = [DbWebConnection instance];
    [service upload:self.uploadUrl withParameters:self.attachParams andUploadData:dbUploadData
           progress:^(NSProgress *uploadProgress) {
               
               // -- Update progress view --
               if (self.processView) {
                   dispatch_async(dispatch_get_main_queue(), ^{
                       // -- Update the progress view --
                       // NSLog(@"messageId = %d => %f", self.uploadPhoto.rowId, uploadProgress.fractionCompleted);
                       self.processView.progress = uploadProgress.fractionCompleted;
                   });
               }
               
               if (self.progressOperationBlock)
                   self.progressOperationBlock(uploadProgress);
               
           }
  completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
      
      // -- This is MAIN THREAD --
//      NSDictionary *imageData = [(NSDictionary *)responseObject objectForKey:@"data"];
//      
//      NSDictionary *updateData = [[NSDictionary alloc] initWithObjectsAndKeys:
//                                  [imageData objectForKey:@"file_name"], @"server_name",
//                                  [imageData objectForKey:@"link"], @"server_link",
//                                  nil];
//      
//      [self.uploadPhoto updateData:updateData andWhere:[NSString stringWithFormat:@"id = %d", self.uploadPhoto.rowId]];
    
      if (self.completionOperationBlock)
          self.completionOperationBlock(self, responseObject, nil);
      
      // -- Done task --
      [self finish];
  }];
}

#pragma mark - Cancel

- (void)cancel
{
    [super cancel];
    // -- Call finish --
    [self finish];
}

@end

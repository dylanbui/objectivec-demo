//
//  UploadPhotoOperation.m
//  PropzyDiy
//
//  Created by Dylan Bui on 3/31/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "UploadPhotoOperation.h"
#import "Constant.h"
#import "WebConnection.h"
#import "FCFileManager.h"

@implementation UploadPhotoOperation

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
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // -- Update the progress view --
        self.processView.label.text = [NSString stringWithFormat:@"Files : %d/%d", self.indexPhoto, self.totalPhoto];
    });
    
    // -- Check file existed --
    NSData *fileData = [FCFileManager readFileAtPathAsData:[NSString stringWithFormat:@"%@/%@", LIB_DIR, self.uploadPhoto.name]];
    if (fileData == nil) {
        NSLog(@"Khong co du lieu tai id = %d", self.uploadPhoto.rowId);
        // -- Cancel task --
        [self cancel];
        return;
    }
    
    NSDictionary* uploadData = [[NSDictionary alloc] initWithObjectsAndKeys:
                                @"file", @"file_id",
                                self.uploadPhoto.name, @"file_name",
                                @"image/png", @"mime_type",
                                fileData, @"file_data",nil];
    
    WebConnection *service = [WebConnection instance];
    [service upload:self.uploadUrl withParameters:nil andUploadData:uploadData
           progress:^(NSProgress *uploadProgress) {
               dispatch_async(dispatch_get_main_queue(), ^{
                   // -- Update the progress view --
//                   NSLog(@"messageId = %d => %f", self.uploadPhoto.rowId, uploadProgress.fractionCompleted);
                   self.processView.progress = uploadProgress.fractionCompleted;
               });
           }
  completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
      
      // -- This is MAIN THREAD --
      
      if (error) {
          NSLog(@"Upload error : %@", [error description]);
          self.completionOperationBlock(nil, error);
          return;
      }
      
      NSDictionary *imageData = [(NSDictionary *)responseObject objectForKey:@"data"];
      
      NSDictionary *updateData = [[NSDictionary alloc] initWithObjectsAndKeys:
                                  [imageData objectForKey:@"file_name"], @"server_name",
                                  [imageData objectForKey:@"link"], @"server_link",
                                  nil];
      
      NSLog(@"[updateData description] = %@", [updateData description]);
      
      [self.uploadPhoto updateData:updateData andWhere:[NSString stringWithFormat:@"id = %d", self.uploadPhoto.rowId]];
      
      self.completionOperationBlock(self.uploadPhoto, nil);
      
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

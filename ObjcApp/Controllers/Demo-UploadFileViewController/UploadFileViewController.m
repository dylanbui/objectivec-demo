//
//  UploadFileViewController.m
//  ObjcApp
//
//  Created by Dylan Bui on 12/6/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "UploadFileViewController.h"
#import "CropPhotoViewController.h"
#import "UIImage+Resize.h"

@interface UploadFileViewController ()

@property (nonatomic, weak) IBOutlet UIImageView *imgUpload;
@property (nonatomic, weak) IBOutlet UITextView* txtvData;


@end

@implementation UploadFileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)btnChooseImage_Click:(id)sender
{
    CropPhotoViewController *vclCropPhoto = [CropPhotoViewController sharedInstance];
    vclCropPhoto.didCropToImage = ^(UIImage * _Nonnull image, CGRect cropRect, NSInteger angle){
        self.imgUpload.image = [image cropCenterToSize:AVATAR_SIZE];
    };
    [[DbUtils getTopViewController] presentViewController:vclCropPhoto animated:YES completion:nil];
}

- (IBAction)btnDoUpoad_Click:(id)sender
{
    DbUploadData* uploadData = [[DbUploadData alloc] init];
    uploadData.fileId = @"upload_file";
    
    // -- Use for PHP Server --
    uploadData.fileName = @"avatar_14.jpg";
    uploadData.mimeType = @"image/jpeg";
    uploadData.fileData = UIImageJPEGRepresentation(self.imgUpload.image, 1.0);
    
    // -- Use for JAVA Server --
//    uploadData.fileName = @"avatar_14.png";
//    uploadData.mimeType = @"image/png";
//    uploadData.fileData = UIImagePNGRepresentation(self.imgUpload.image);
    
    NSLog(@"[uploadData description] = %@", [uploadData description]);
    
    DbWebConnection *service = [DbWebConnection instance];
    [service upload:@"http://localhost/i-test/db-upload.php"
     withParameters:@{@"type": @"avatar"}
      andUploadData:uploadData
           progress:^(NSProgress *uploadProgress) {
               
           }
  completionHandler:^(NSURLResponse *response, NSDictionary *responseDict, NSError *error) {
      if (error) {
          NSLog(@"[error description] = %@", [error description]);
          return;
      }
      
      NSLog(@"[responseDict description] = %@", [responseDict description]);
      
      // -- Convert data to ResponseObject --
//      DbResponseObject *responseObject = [[DbResponseObject alloc] initWithDictionary_om:responseDict];
//      completion(response, responseObject, error);
  }];
    
}

- (IBAction)btnDoPost_Click:(id)sender
{
    DbWebConnection *service = [DbWebConnection instance];
    
    NSDictionary *params = @{@"buildingId" : @2,
                             @"buildingName" : @"194 Golden Building",
                             @"buildingAddress" : @"473 Điện Biên Phủ, Phường 25, Quận Bình Thạnh, Hồ Chí Minh",
                             @"latitude" : @10.79997,
                             @"longitude" : @106.718483};
    
    // -- Do dang chuyen request la json nen khonh the post du lieu cho server php duoc --
    // -- neu muon chuyen duoc phai dong dong 166 trong DbWebConnection.m --
    // -- Set Request is Json --
    //[sessionManager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    
    [service post:@"http://localhost/i-test/db-post.php"
       parameters:params withBlock:^(NSDictionary *responseDict, NSError *error) {
          
           if (error) {
               NSLog(@"[error description] = %@", [error description]);
               self.txtvData.text = [NSString stringWithFormat:@"[error description] = %@", [error description]];
               return;
           }
           
           NSLog(@"[responseDict description] = %@", [responseDict description]);
           self.txtvData.text = [NSString stringWithFormat:@"[responseDict description] = %@", responseDict];
           
       }];
    
    // -- Convert data to ResponseObject --
    //      DbResponseObject *responseObject = [[DbResponseObject alloc] initWithDictionary_om:responseDict];
    //      completion(response, responseObject, error);
    
}




@end

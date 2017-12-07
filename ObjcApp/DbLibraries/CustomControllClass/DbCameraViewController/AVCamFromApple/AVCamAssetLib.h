//
//  AVCamAssetLib.h
//  ObjcApp
//
//  Created by Dylan Bui on 12/4/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AVCamAssetLib : NSObject

- (void)getLatestImageWithSuccess:(void (^)(UIImage *image))onSuccess;

- (void)saveImage:(UIImage *)imageToSave onCompletion:(void (^)(void))onCompletion;

@end

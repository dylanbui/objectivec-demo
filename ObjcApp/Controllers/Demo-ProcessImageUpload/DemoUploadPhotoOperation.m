//
//  DemoUploadPhotoOperation.m
//  ObjcApp
//
//  Created by Dylan Bui on 6/12/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import "DemoUploadPhotoOperation.h"

@implementation DemoUploadPhotoOperation

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
    if (self.cancelled) {
        return;
    }
    
    // -- Start task --
    [super start];
    
    // Switch to determinate mode
    dispatch_async(dispatch_get_main_queue(), ^{
        // -- Start Block --
        if (self.startOperationBlock != nil) {
            self.startOperationBlock(nil, nil);
        }
    });
    sleep(0.5);
    // -- Progress --
    int progress = 1;
    NSProgress *objProgress = [NSProgress progressWithTotalUnitCount:100];
    while (progress < 100) {
        progress += 1;
        objProgress.completedUnitCount = progress;
        // -- Process Block --
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.uploadProgressOperationBlock != nil) {
                self.uploadProgressOperationBlock(nil, objProgress);
            }
        });
        usleep(50000);
    }
    sleep(1);
    // Back to indeterminate mode
    dispatch_async(dispatch_get_main_queue(), ^{
        // -- Done Block --
        self.completionOperationBlock(nil, nil, nil);
    });
    
    // -- Done task --
    [self finish];
}

#pragma mark - Cancel

- (void)cancel
{
    [super cancel];
    // -- Call finish --
    [self finish];
}

@end

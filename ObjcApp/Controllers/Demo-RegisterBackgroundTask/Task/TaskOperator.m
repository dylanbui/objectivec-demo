//
//  TaskOperator.m
//  ObjcApp
//
//  Created by Dylan Bui on 6/3/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import "TaskOperator.h"
#import "TaskIDGenerator.h"

@implementation TaskOperator

- (instancetype)initWithUrl:(NSURL *)url
{
    if (self = [super init]) {
        self.url = url;
        //        self.name = @"Answers-Retrieval";
    }
    return self;
}


#pragma mark - Start

- (void)start
{
    // -- Call parent start --
    [super start];
        
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithURL:self.url
                                        completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                  {
                                      self.completionOperationBlock(self, [UIImage imageWithData:data], error);
                                      
                                      // -- Set finish status --
                                      [self finish];
                                  }];
    
    [task resume];
}

#pragma mark - Cancel

- (void)cancel
{
    [super cancel];
    
    [self finish];
}

#pragma mark - TaskProtocol

- (void)taskStart
{
    [self start];
}

- (NSArray<NSString *> *)taskRunBackgroundMode
{
    return @[UIApplicationDidBecomeActiveNotification];
}

- (NSInteger)taskPriority
{
    return 1;
}

@end

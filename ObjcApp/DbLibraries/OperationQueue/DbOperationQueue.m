//
//  BaseOperationQueue.m
//  PropzyDiy
//
//  Created by Dylan Bui on 3/24/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "DbOperationQueue.h"

@interface DbOperationQueue ()

/**
 Completion block for all operator.
 */
@property (nonatomic, copy) void (^completionBlock)(void);
@property (nonatomic, copy) void (^cancelBlock)(NSError *);

@end


@implementation DbOperationQueue

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    
    return self;
}

- (instancetype)initCompletionQueueWithBlock:(void(^)(void)) block
{
    if (self = [super init]) {
        [self setCompletionQueue:block];
    }
    
    return self;
}

- (void)setCancelQueue:(void(^)(NSError *))block
{
    self.cancelBlock = block;
}

- (void)setCompletionQueue:(void(^)(void)) block
{
    self.completionBlock = block;
    // -- Add Observer notify when 'operations' property change --
    [self addObserver:self forKeyPath:@"operations" options:0 context:NULL];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context
{
    if (object == self && [keyPath isEqualToString:@"operations"]) {
        if ([self.operations count] == 0) {
            // Do something here when your queue has completed
            if (self.completionBlock) {
                // NSLog(@"queue has completed");
                self.completionBlock();
            }            
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object
                               change:change context:context];
    }
}

- (void)cancelAllOperations:(NSError *)reason
{
    // -- This method sends a cancel message to all operations currently in the queue. Queued operations are cancelled before they begin executing. If an operation is already executing, it is up to that operation to recognize the cancellation and stop what it is doing. --
    /*
     In NSOperation:
     if (!self.isCancelled)
     // then do something
     else
     return;
     */
    
    [super cancelAllOperations];
    // -- Still call completion when cancel --
    if (self.cancelBlock) {
        NSLog(@"cancelAllOperations");
        self.cancelBlock(reason);
    }
}

@end

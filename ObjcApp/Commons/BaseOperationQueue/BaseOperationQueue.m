//
//  BaseOperationQueue.m
//  PropzyDiy
//
//  Created by Dylan Bui on 3/24/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "BaseOperationQueue.h"

@interface BaseOperationQueue ()

/**
 Completion block for all operator.
 */
@property (nonatomic, copy) void (^completion)();

@end


@implementation BaseOperationQueue

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    
    return self;
}

- (instancetype)initCompletionQueueWithBlock:(void(^)()) block
{
    if (self = [super init]) {
        [self setCompletionQueue:block];
    }
    
    return self;
}

- (void)setCompletionQueue:(void(^)()) block
{
    self.completion = block;
    // -- Add Observer notify when 'operations' property change --
    [self addObserver:self forKeyPath:@"operations" options:0 context:NULL];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context
{
    if (object == self && [keyPath isEqualToString:@"operations"]) {
        if ([self.operations count] == 0) {
            // Do something here when your queue has completed
            if (self.completion) {
                 NSLog(@"queue has completed");
                self.completion();
            }            
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object
                               change:change context:context];
    }
}


- (void)cancelAllOperations
{
    [super cancelAllOperations];
}

@end

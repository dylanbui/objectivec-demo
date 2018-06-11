//
//  BaseOperation.m
//  PropzyDiy
//
//  Created by Dylan Bui on 3/24/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "DbOperation.h"

@implementation DbOperation

/*
 We need to do old school synthesizing as the compiler has trouble creating the internal ivars.
 */
@synthesize ready = _ready;
@synthesize executing = _executing;
@synthesize finished = _finished;

#pragma mark - Init

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        self.ready = YES;
    }
    
    return self;
}

- (instancetype)initWithCompletion:(void (^)(id owner, id result, NSError *error))completion
{
    self = [super init];
    
    if (self)
    {
        self.completionOperationBlock = completion;
    }
    
    return self;
}


#pragma mark - State

- (void)setReady:(BOOL)ready
{
    if (_ready != ready)
    {
        [self willChangeValueForKey:NSStringFromSelector(@selector(isReady))];
        _ready = ready;
        [self didChangeValueForKey:NSStringFromSelector(@selector(isReady))];
    }
}

- (BOOL)isReady
{
    return _ready;
}

- (void)setExecuting:(BOOL)executing
{
    if (_executing != executing)
    {
        [self willChangeValueForKey:NSStringFromSelector(@selector(isExecuting))];
        _executing = executing;
        [self didChangeValueForKey:NSStringFromSelector(@selector(isExecuting))];
    }
}

- (BOOL)isExecuting
{
    return _executing;
}

- (void)setFinished:(BOOL)finished
{
    if (_finished != finished)
    {
        [self willChangeValueForKey:NSStringFromSelector(@selector(isFinished))];
        _finished = finished;
        [self didChangeValueForKey:NSStringFromSelector(@selector(isFinished))];
    }
}

- (BOOL)isFinished
{
    return _finished;
}

- (BOOL)isAsynchronous
{
    return YES;
}

#pragma mark - Control

- (void)start
{
    if (self.cancelled) {
        return;
    }
    
    if (!self.isExecuting)
    {
        self.ready = NO;
        self.executing = YES;
        self.finished = NO;
        // NSLog(@"\"%@\" Operation Started.", self.name);
    }
}

- (void)finish
{
    if (self.executing)
    {
        // NSLog(@"\"%@\" Operation Finished.", self.name);
        self.executing = NO;
        self.finished = YES;
    }
}

@end

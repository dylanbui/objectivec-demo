//
//  UpdateTaskOther.m
//  ObjcApp
//
//  Created by Dylan Bui on 6/4/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import "UpdateTaskOther.h"

@implementation UpdateTaskOther

@synthesize taskID = _taskID;

#pragma mark - TaskProtocol

- (void)taskStart
{
    NSLog(@"Start UpdateTaskOther : : %ld", self.taskID);
}

- (void)taskCancel
{
    NSLog(@"taskCancel UpdateTaskOther : %ld", self.taskID);
}

- (NSArray<NSString *> *)taskRunBackgroundMode
{
    return @[UIApplicationDidEnterBackgroundNotification];
}

- (NSInteger)taskPriority
{
    return 8;
}

@end


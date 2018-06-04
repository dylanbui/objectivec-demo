//
//  UpdateTaskHard.m
//  ObjcApp
//
//  Created by Dylan Bui on 6/4/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import "UpdateTaskHard.h"

@implementation UpdateTaskHard

@synthesize taskID = _taskID;

#pragma mark - TaskProtocol

- (void)taskStart
{
    NSLog(@"Start UpdateTaskHard : : %ld", self.taskID);
}

- (void)taskCancel
{
    NSLog(@"taskCancel UpdateTaskHard : %ld", self.taskID);
}


- (TASK_MODEL)taskRunBackgroundMode
{
    return APP_DID_BECOME_ACTIVE;
}

- (NSInteger)taskPriority
{
    return 3;
}

@end


//
//  UpdateCountryUnitTask.m
//  ObjcApp
//
//  Created by Dylan Bui on 6/4/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import "UpdateCountryUnitTask.h"

@interface UpdateCountryUnitTask()

@property (nonatomic, strong) NSString *runningMode;

@end

@implementation UpdateCountryUnitTask

@synthesize taskID = _taskID;

#pragma mark - TaskProtocol

- (void)taskStart:(NSString *)runningMode
{
    self.runningMode = runningMode;

    RUN_ON_BACKGROUND_QUEUE(^{
        NSLog(@"Start mode : --- %@ --- UpdateCountryUnitTask : %ld --- taskPriority : %d", runningMode, self.taskID, 15);
        NSLog(@"%@", @" -------------------");
        if ([runningMode isEqualToString:NOTIFY_REACHABLE_NETWORK]) {
            [NSThread sleepForTimeInterval: 2];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"UPDATE_USER_INFORMATION" object:self userInfo:nil];
        }
    });
}

- (void)taskCancel
{
    NSLog(@"taskCancel UpdateCountryUnitTask : %ld", self.taskID);
}

- (NSArray<NSString *> *)taskRunBackgroundMode
{
    return @[UIApplicationDidFinishLaunchingNotification, UIApplicationDidBecomeActiveNotification, NOTIFY_REACHABLE_NETWORK, @"UPDATE_USER_INFORMATION"];
}

- (NSString *)taskGroup
{
    return SYSTEM_TASK;
}

- (NSInteger)taskPriority
{
    return 15;
}



@end

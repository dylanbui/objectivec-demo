//
//  TaskManager.h
//  ObjcApp
//
//  Created by Dylan Bui on 6/4/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

// -- Da lam xong ben DIY tot hon --

#import "TaskDefines.h"

@interface TaskManager : NSObject

+ (id)sharedInstance;

- (TaskRegisterID)subscribeTask:(TaskObject)task;

- (void)removeTask:(TaskObject)task;

- (void)removeTaskById:(TaskRegisterID)taskId;

- (void)removeAllTask;

@end

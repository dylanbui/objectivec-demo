//
//  TaskManager.h
//  ObjcApp
//
//  Created by Dylan Bui on 6/4/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//


#import "TaskDefines.h"

@interface TaskManager : NSObject

+ (id)instance;

- (TaskRegisterID)subscribeTask;

@end

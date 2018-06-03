//
//  TaskManager.m
//  ObjcApp
//
//  Created by Dylan Bui on 6/4/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import "TaskManager.h"

@interface TaskManager()

@end

@implementation TaskManager

+ (TaskManager *)instance
{
    static TaskManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[TaskManager alloc] initInstance];
    });
    return instance;
}

- (id)initInstance
{
    if (self = [super init]) {
        //self.extendData = [[NSMutableDictionary alloc] init];
    }
    return self;
}

@end

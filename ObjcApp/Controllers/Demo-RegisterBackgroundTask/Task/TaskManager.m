//
//  TaskManager.m
//  ObjcApp
//
//  Created by Dylan Bui on 6/4/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import "TaskManager.h"
#import "TaskIDGenerator.h"


@interface TaskManager()

@property (nonatomic, strong) NSArray *arrTaskRegisted;


@end

@implementation TaskManager

static id _sharedInstance;
+ (TaskManager *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (id)init
{
    NSAssert(_sharedInstance == nil, @"Only one instance of TaskManager should be created. Use +[TaskManager sharedInstance] instead.");
    
    if (self = [super init]) {
        
        self.arrTaskRegisted = [[NSArray alloc] init];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(processNotificationCenter:)
                                                     name:UIApplicationDidBecomeActiveNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(processNotificationCenter:)
                                                     name:UIApplicationWillResignActiveNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(processNotificationCenter:)
                                                     name:UIApplicationWillEnterForegroundNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(processNotificationCenter:)
                                                     name:UIApplicationDidEnterBackgroundNotification
                                                   object:nil];
    }
    return self;
}

- (TaskRegisterID)subscribeTask:(TaskObject)task
{
    NSMutableArray *newTaskRegisted = [[NSMutableArray alloc] initWithArray:self.arrTaskRegisted];
    [newTaskRegisted addObject:task];
    // -- Sort --
    self.arrTaskRegisted = [newTaskRegisted sortedArrayUsingComparator:^NSComparisonResult(TaskObject obj1, TaskObject obj2) {
        NSInteger priority_1 = [obj1 taskPriority];
        NSInteger priority_2 = [obj2 taskPriority];
        return priority_1 - priority_2;
    }];

    task.taskID = [TaskIDGenerator getUniqueRegisterID];
    return task.taskID;
}

- (void)removeTask:(TaskObject)task
{
    // -- Cancel Task --
    [task taskCancel];
    // -- Remove task in array --
    NSMutableArray *newTaskRegisted = [[NSMutableArray alloc] initWithArray:self.arrTaskRegisted];
    [newTaskRegisted removeObject:task];
    self.arrTaskRegisted = newTaskRegisted;
}

- (void)removeTaskById:(TaskRegisterID)taskId
{
    for (TaskObject obj in self.arrTaskRegisted) {
        if (obj.taskID == taskId) {
            [self removeTask:obj];
        }
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)processNotificationCenter:(NSNotification *)notification
{
    for (TaskObject obj in self.arrTaskRegisted) {
        // -- Do khac kien truct nen phai if 2 lan de kiem tra --
        if (notification.name == UIApplicationDidBecomeActiveNotification) {
            if ([obj taskRunBackgroundMode] == APP_DID_BECOME_ACTIVE) {
                [obj taskStart];
            }
        } else if (notification.name == UIApplicationWillResignActiveNotification) {
            if ([obj taskRunBackgroundMode] == APP_WILL_RESIGN_ACTIVE) {
                [obj taskStart];
            }
        } else if (notification.name == UIApplicationDidEnterBackgroundNotification) {
            if ([obj taskRunBackgroundMode] == APP_DID_ENTER_BACKGROUND) {
                [obj taskStart];
            }
        } else if (notification.name == UIApplicationWillEnterForegroundNotification) {
            if ([obj taskRunBackgroundMode] == APP_WILL_ENTER_FOREGROUND) {
                [obj taskStart];
            }
        }
    }

//    } else if ([notification.name isEqualToString:NOTIFY_REACHABLE_NETWORK]) {
//        // -- Synchronize user data when network connected --
//        [self synchronizeUserData:nil];
//
//    }
}

@end

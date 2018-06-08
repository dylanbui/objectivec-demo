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




@property (nonatomic, strong) NSArray *arrSupportMode;

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
        // -- Default system mode --
        self.arrSupportMode = @[
                                UIApplicationDidEnterBackgroundNotification,
                                UIApplicationWillEnterForegroundNotification,
                                UIApplicationDidFinishLaunchingNotification,
                                UIApplicationDidBecomeActiveNotification,
                                UIApplicationWillResignActiveNotification,
                                UIApplicationDidReceiveMemoryWarningNotification,
                                UIApplicationWillTerminateNotification,
                                UIApplicationSignificantTimeChangeNotification];
        // -- Start AddObserver --
        [self reAddObserver];
    }
    return self;
}

- (void)addExtendRunMode:(NSArray *)arrMode
{
    self.arrSupportMode = [self.arrSupportMode arrayByAddingObjectsFromArray:arrMode];
    // -- Start AddObserver --
    [self reAddObserver];
}

- (TaskRegisterID)subscribeTask:(TaskObject)task
{
    NSMutableArray *newTaskRegisted = [[NSMutableArray alloc] initWithArray:self.arrTaskRegisted];
    [newTaskRegisted addObject:task];
    // -- Sort --
    self.arrTaskRegisted = [newTaskRegisted sortedArrayUsingComparator:^NSComparisonResult(TaskObject obj1, TaskObject obj2) {
        NSInteger priority_1 = [self getPriorityByTaskObject:obj1];
        NSInteger priority_2 = [self getPriorityByTaskObject:obj2];
        // return priority_2 - priority_1; // Desc giam dan
        return priority_1 - priority_2; // Asc tang dan
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

- (void)removeTaskByGroup:(NSString *)taskGroup
{
    for (TaskObject obj in self.arrTaskRegisted) {
        NSString *groupName = [self getGroupNameByTaskObject:obj];
        if ([groupName isEqualToString:taskGroup]) {
            [self removeTask:obj];
        }
    }
}

- (void)removeAllTask
{
    for (TaskObject obj in self.arrTaskRegisted) {
        [obj taskCancel];
    }
 
    NSMutableArray *newTaskRegisted = [[NSMutableArray alloc] initWithArray:self.arrTaskRegisted];
    [newTaskRegisted removeAllObjects];
    self.arrTaskRegisted = newTaskRegisted;
}

#pragma mark - Cycle Live
#pragma mark -

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Private function
#pragma mark -

- (NSString *)getGroupNameByTaskObject:(TaskObject)taskObj
{
    return [taskObj respondsToSelector:@selector(taskGroup)] ? [taskObj taskGroup] : SYSTEM_TASK;
}

- (NSInteger)getPriorityByTaskObject:(TaskObject)taskObj
{
    return [taskObj respondsToSelector:@selector(taskPriority)] ? [taskObj taskPriority] : 1;
}

- (void)reAddObserver
{
    // -- Remove all Notify --
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    for (NSString *mode in self.arrSupportMode) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(processNotificationCenter:)
                                                     name:mode
                                                   object:nil];
    }
}

- (void)processNotificationCenter:(NSNotification *)notification
{
    for (TaskObject obj in self.arrTaskRegisted) {
        if ([[obj taskRunBackgroundMode] containsObject:notification.name]) {
            [obj taskStart:notification.name];
            NSLog(@"%@ -- obj = %@", notification.name, NSStringFromClass([obj class]));
        }
    }
}

@end

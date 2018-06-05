//
//  TaskManagerViewController.m
//  ObjcApp
//
//  Created by Dylan Bui on 6/3/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import "TaskManagerViewController.h"
#import "TaskManager.h"
#import "UpdateCountryUnitTask.h"
#import "UpdateTaskHard.h"
#import "UpdateTaskOther.h"

@interface TaskManagerViewController ()

@end

@implementation TaskManagerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    TaskManager *taskManager = [TaskManager sharedInstance];
    
    UpdateCountryUnitTask *task_1 = [[UpdateCountryUnitTask alloc] init];
    [taskManager subscribeTask:task_1];
//    NSLog(@"TaskRegisterID = %ld", [taskManager subscribeTask:task_1]);
    
    UpdateTaskHard *task_2 = [[UpdateTaskHard alloc] init];
    [taskManager subscribeTask:task_2];
//    NSLog(@"TaskRegisterID = %ld", [taskManager subscribeTask:task_2]);
    
    UpdateTaskOther *task_3 = [[UpdateTaskOther alloc] init];
    [taskManager subscribeTask:task_3];
//    NSLog(@"TaskRegisterID = %ld", [taskManager subscribeTask:task_3]);
    
}


@end

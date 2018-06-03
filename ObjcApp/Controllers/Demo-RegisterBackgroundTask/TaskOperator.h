//
//  TaskOperator.h
//  ObjcApp
//
//  Created by Dylan Bui on 6/3/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import "TaskDefines.h"
#import "DbOperation.h"

@interface TaskOperator : DbOperation <TaskProtocol>

@property (nonatomic, strong) NSURL *url;

- (instancetype)initWithUrl:(NSURL *)url;

@end

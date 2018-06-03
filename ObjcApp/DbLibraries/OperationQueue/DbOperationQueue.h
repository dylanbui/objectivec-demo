//
//  BaseOperationQueue.h
//  PropzyDiy
//
//  Created by Dylan Bui on 3/24/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//  Build on : http://williamboles.me/networking-with-nsoperation-as-your-wingman/
//

#import <Foundation/Foundation.h>

@interface DbOperationQueue : NSOperationQueue

- (instancetype)init;

- (instancetype)initCompletionQueueWithBlock:(void(^)(void)) block;

- (void)setCompletionQueue:(void(^)(void)) block;

@end

//
//  BaseOperation.h
//  PropzyDiy
//
//  Created by Dylan Bui on 3/24/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//  Build on : http://williamboles.me/networking-with-nsoperation-as-your-wingman/ 

#import <Foundation/Foundation.h>

/**
 Abstract class for asynchronus operations.
 */
@interface DbOperation : NSOperation

/**
 Start block to be called once the the request begin start.
 */
@property (nonatomic, copy) void (^startOperationBlock)(id owner, id data);

/**
 Completion block to be called once the the request and parsing is completed. Will return the parsed answers or nil.
 */
@property (nonatomic, copy) void (^completionOperationBlock)(id owner, id result, NSError *error);


/**
 Finishes the execution of the operation.
 
 @note - This shouldn’t be called externally as this is used internally by subclasses. To cancel an operation use cancel instead.
 */
- (void)finish;

@end

//
//  ResponseObject.h
//  SAM_Demo
//
//  Created by Dylan Bui on 1/3/17.
//  Copyright © 2017 Dylan Bui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DbObject.h"

@interface DbResponseObject : DbObject

@property (strong, nonatomic) NSString          *message;
@property (nonatomic) BOOL                      result;
@property (nonatomic) int                       code;
@property (nonatomic) id                        data;


@end

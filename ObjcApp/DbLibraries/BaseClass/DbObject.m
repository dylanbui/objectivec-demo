//
//  BaseObject.m
//  SAM_Demo
//
//  Created by Dylan Bui on 1/3/17.
//  Copyright © 2017 Dylan Bui. All rights reserved.
//

#import "DbObject.h"

@implementation DbObject

- (instancetype)init
{
    self = [super init];
    if(self) {
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
    }
    return self;
}

- (void)resetAllData
{
    NSDictionary *mappingRules = [[self class] om_objectMapping];
    for (NSString *propertyName in mappingRules) {
        // -- Nhung bien nao trong ten co 'global' thi khong xoa gia tri --
        if ([propertyName containsString:@"global"])
            continue;
        
        id value = [self valueForKey:propertyName];
        if ([value isKindOfClass:[NSDictionary class]]
            || [value isKindOfClass:[NSMutableDictionary class]]
            || [value isKindOfClass:[NSArray class]]
            || [value isKindOfClass:[NSMutableArray class]]) {
            [self setValue:[NSNull null] forKey:propertyName];
        } else if ([value isKindOfClass:[NSString class]]) {
            [self setValue:@"" forKey:propertyName];
        } else {
            // -- Khong dung duoc cho so tu nhien no la NSNumber --
            // -- @"" su dung duoc cho C Types --
            [self setValue:@"" forKey:propertyName];
        }
    }
}


@end

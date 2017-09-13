//
//  NSMutableDictionary+DbHelper.m
//  PropzyPama
//
//  Created by Dylan Bui on 9/13/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "NSMutableDictionary+DbHelper.h"

@implementation NSMutableDictionary (DbHelper)

- (void)db_setBool:(BOOL)value forKey:(NSString *)key
{
    [self setObject:[NSNumber numberWithBool:value] forKey:key];
}

- (void)db_setInteger:(NSInteger)value forKey:(NSString *)key
{
    [self setObject:[NSNumber numberWithInteger:value] forKey:key];
}

- (void)db_setLong:(long)value forKey:(NSString *)key
{
    [self setObject:[NSNumber numberWithLong:value] forKey:key];
}

- (void)db_setLongLong:(long long)value forKey:(NSString *)key
{
    [self setObject:[NSNumber numberWithLongLong:value] forKey:key];
}

- (void)db_setInt:(int)value forKey:(NSString *)key
{
    [self db_setLong:value forKey:key];
}

- (void)db_setFloat:(float)value forKey:(NSString *)key
{
    [self setObject:[NSNumber numberWithFloat:value] forKey:key];
}

- (void)db_setDouble:(double)value forKey:(NSString *)key
{
    [self setObject:[NSNumber numberWithDouble:value] forKey:key];
}

- (void)db_setTimeInterval:(NSTimeInterval)value forKey:(NSString *)key
{
    [self db_setDouble:value forKey:key];
}

- (void)db_setCGPoint:(CGPoint)value forKey:(NSString *)key
{
    [self setObject:[NSValue valueWithCGPoint:value] forKey:key];
}

- (void)db_setCGRect:(CGRect)value forKey:(NSString *)key
{
    [self setObject:[NSValue valueWithCGRect:value] forKey:key];
}

- (void)db_setCGSize:(CGSize)value forKey:(NSString *)key
{
    [self setObject:[NSValue valueWithCGSize:value] forKey:key];
}

- (void)db_setCGAffineTransform:(CGAffineTransform)value forKey:(NSString *)key
{
    [self setObject:[NSValue valueWithCGAffineTransform:value] forKey:key];
}

- (void)db_setUIEdgeInsets:(UIEdgeInsets)value forKey:(NSString *)key
{
    [self setObject:[NSValue valueWithUIEdgeInsets:value] forKey:key];
}

- (void)db_setUIOffset:(UIOffset)value forKey:(NSString *)key
{
    [self setObject:[NSValue valueWithUIOffset:value] forKey:key];
}

@end

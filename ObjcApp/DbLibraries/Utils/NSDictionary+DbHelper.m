//
//  NSDictionary+DbHelper.m
//  PropzyPama
//
//  Created by Dylan Bui on 9/13/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "NSDictionary+DbHelper.h"

@implementation NSDictionary (DbHelper)

#pragma mark - ForKey

- (BOOL)db_boolForKey:(NSString *)key defaultValue:(BOOL)defaultValue
{
    id obj = [self objectForKey:key];
    if (obj && [obj isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)obj boolValue];
    } else {
        return defaultValue;
    }
}

- (BOOL)db_boolForKey:(NSString *)key
{
    return [self db_boolForKey:key defaultValue:NO];
}

- (NSInteger)db_integerForKey:(NSString *)key defaultValue:(NSInteger)defaultValue
{
    id obj = [self objectForKey:key];
    if (obj) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)obj integerValue];
        } else if ([obj isKindOfClass:[NSString class]]) {
            return [(NSString *)obj integerValue];
        }
    }
    
    return defaultValue;
}

- (NSInteger)db_integerForKey:(NSString *)key
{
    return [self db_integerForKey:key defaultValue:0];
}

- (long)db_longForKey:(NSString *)key defaultValue:(long)defaultValue
{
    id obj = [self objectForKey:key];
    if (obj) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)obj longValue];
        } else if ([obj isKindOfClass:[NSString class]]) {
            return (long)[(NSString *)obj integerValue];
        }
    }
    
    return defaultValue;
}

- (long)db_longForKey:(NSString *)key
{
    return [self db_longForKey:key defaultValue:0];
}

- (long long)db_longLongForKey:(NSString *)key defaultValue:(long long)defaultValue
{
    id obj = [self objectForKey:key];
    if (obj) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)obj longLongValue];
        } else if ([obj isKindOfClass:[NSString class]]) {
            return (long long)strtoll([(NSString *)obj UTF8String], NULL, 0);
        }
    }
    
    return defaultValue;
}

- (long long)db_longLongForKey:(NSString *)key
{
    return [self db_longLongForKey:key defaultValue:0];
}

- (int)db_intForKey:(NSString *)key defaultValue:(int)defaultValue
{
    return (int)[self db_longForKey:key defaultValue:defaultValue];
}

- (int)db_intForKey:(NSString *)key
{
    return (int)[self db_longForKey:key];
}

- (float)db_floatForKey:(NSString *)key defaultValue:(float)defaultValue
{
    id obj = [self objectForKey:key];
    if (obj) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)obj floatValue];
        } else if ([obj isKindOfClass:[NSString class]]) {
            return [(NSString *)obj floatValue];
        }
    }
    
    return defaultValue;
}

- (float)db_floatForKey:(NSString *)key
{
    return [self db_floatForKey:key defaultValue:0];
}

- (double)db_doubleForKey:(NSString *)key defaultValue:(double)defaultValue
{
    id obj = [self objectForKey:key];
    if (obj) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)obj doubleValue];
        } else if ([obj isKindOfClass:[NSString class]]) {
            return [(NSString *)obj doubleValue];
        }
    }
    
    return defaultValue;
}

- (double)db_doubleForKey:(NSString *)key
{
    return [self db_doubleForKey:key defaultValue:0];
}

- (NSTimeInterval)db_timeIntervalForKey:(NSString *)key defaultValue:(NSTimeInterval)defaultValue
{
    return [self db_doubleForKey:key defaultValue:defaultValue];
}

- (NSTimeInterval)db_timeIntervalForKey:(NSString *)key
{
    return [self db_doubleForKey:key defaultValue:0];
}

- (id)db_objectForKey:(NSString *)key defaultValue:(NSString *)defaultValue
{
    id obj = [self objectForKey:key];
    if (obj) {
        return obj;
    } else {
        return defaultValue;
    }
}

- (id)db_objectForKey:(NSString *)key
{
    return [self db_objectForKey:key defaultValue:nil];
}

- (NSString *)db_stringForKey:(NSString *)key defaultValue:(NSString *)defaultValue
{
    id obj = [self objectForKey:key];
    if (obj) {
        if ([obj isKindOfClass:[NSString class]]) {
            return obj;
        } else if ([obj isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)obj stringValue];
        }
    }
    
    return defaultValue;
}

- (NSString *)db_stringForKey:(NSString *)key
{
    return [self db_stringForKey:key defaultValue:nil];
}

- (NSArray *)db_arrayForKey:(NSString *)key defaultValue:(NSArray *)defaultValue
{
    id obj = [self objectForKey:key];
    if (obj && [obj isKindOfClass:[NSArray class]]) {
        return obj;
    } else {
        return defaultValue;
    }
}

- (NSArray *)db_arrayForKey:(NSString *)key
{
    return [self db_arrayForKey:key defaultValue:nil];
}

- (NSDictionary *)db_dictionaryForKey:(NSString *)key defaultValue:(NSDictionary *)defaultValue
{
    id obj = [self objectForKey:key];
    if (obj && [obj isKindOfClass:[NSDictionary class]]) {
        return obj;
    } else {
        return defaultValue;
    }
}

- (NSDictionary *)db_dictionaryForKey:(NSString *)key
{
    return [self db_dictionaryForKey:key defaultValue:nil];
}

- (NSDate *)db_dateForKey:(NSString *)key defaultValue:(NSDate *)defaultValue
{
    id obj = [self objectForKey:key];
    if (obj && [obj isKindOfClass:[NSDate class]]) {
        return obj;
    } else {
        return defaultValue;
    }
}

- (NSDate *)db_dateForKey:(NSString *)key
{
    return [self db_dateForKey:key defaultValue:nil];
}

- (NSData *)db_dataForKey:(NSString  *)key defaultValue:(NSData *)defaultValue
{
    id obj = [self objectForKey:key];
    if (obj && [obj isKindOfClass:[NSData class]]) {
        return obj;
    } else {
        return defaultValue;
    }
}

- (NSData *)db_dataForKey:(NSString *)key
{
    return [self db_dataForKey:key defaultValue:nil];
}

- (NSURL *)db_URLForKey:(NSString *)key defaultValue:(NSURL *)defaultValue
{
    id obj = [self objectForKey:key];
    if (obj && [obj isKindOfClass:[NSURL class]]) {
        return obj;
    } else if (obj && [obj isKindOfClass:[NSString class]]) {
        return [NSURL URLWithString:(NSString *)obj];
    }
    else {
        return defaultValue;
    }
}

- (NSURL *)db_URLForKey:(NSString *)key
{
    return [self db_URLForKey:key defaultValue:nil];
}

#pragma mark - ForPath

- (NSDictionary *)db_dictionaryForPaths:(NSArray *)paths
{
    if (paths.count == 0) {
        return nil;
    }
    
    NSDictionary *target = self;
    for (int i = 0; i < paths.count - 1; i++) {
        NSString *key = [paths objectAtIndex:i];
        target = [target db_dictionaryForKey:key];
        if (!target) {
            return nil;
        }
    }
    
    return target;
}

- (BOOL)db_boolForPath:(NSString *)path defaultValue:(BOOL)defaultValue
{
    NSArray *paths = [path componentsSeparatedByString:@"."];
    if (paths.count == 1) {
        return [self db_boolForKey:paths.lastObject];
    } else if (paths.count >= 2) {
        NSDictionary *obj = [self db_dictionaryForPaths:paths];
        return [obj db_boolForKey:paths.lastObject];
    }
    
    return defaultValue;
}

- (BOOL)db_boolForPath:(NSString *)path
{
    return [self db_boolForPath:path defaultValue:NO];
}

- (NSInteger)db_integerForPath:(NSString *)path defaultValue:(NSInteger)defaultValue
{
    NSArray *paths = [path componentsSeparatedByString:@"."];
    if (paths.count == 1) {
        return [self db_integerForKey:paths.lastObject];
    } else if (paths.count >= 2) {
        NSDictionary *obj = [self db_dictionaryForPaths:paths];
        return [obj db_integerForKey:paths.lastObject];
    }
    
    return defaultValue;
}

- (NSInteger)db_integerForPath:(NSString *)path
{
    return [self db_integerForPath:path defaultValue:0];
}

- (long)db_longForPath:(NSString *)path defaultValue:(long)defaultValue
{
    NSArray *paths = [path componentsSeparatedByString:@"."];
    if (paths.count == 1) {
        return [self db_longForKey:paths.lastObject];
    } else if (paths.count >= 2) {
        NSDictionary *obj = [self db_dictionaryForPaths:paths];
        return [obj db_longForKey:paths.lastObject];
    }
    
    return defaultValue;
}

- (long)db_longForPath:(NSString *)path
{
    return [self db_longForPath:path defaultValue:0];
}

- (long long)db_longLongForPath:(NSString *)path defaultValue:(long long)defaultValue
{
    NSArray *paths = [path componentsSeparatedByString:@"."];
    if (paths.count == 1) {
        return [self db_longLongForKey:paths.lastObject];
    } else if (paths.count >= 2) {
        NSDictionary *obj = [self db_dictionaryForPaths:paths];
        return [obj db_longLongForKey:paths.lastObject];
    }
    
    return defaultValue;
}

- (long long)db_longLongForPath:(NSString *)path
{
    return [self db_longLongForPath:path defaultValue:0];
}

- (int)db_intForPath:(NSString *)path
{
    return (int)[self db_longForPath:path];
}

- (int)db_intForPath:(NSString *)path defaultValue:(int)defaultValue
{
    return (int)[self db_longForPath:path defaultValue:defaultValue];
}

- (float)db_floatForPath:(NSString *)path
{
    return [self db_floatForPath:path defaultValue:0];
}

- (float)db_floatForPath:(NSString *)path defaultValue:(float)defaultValue
{
    NSArray *paths = [path componentsSeparatedByString:@"."];
    if (paths.count == 1) {
        return [self db_floatForKey:paths.lastObject];
    } else if (paths.count >= 2) {
        NSDictionary *obj = [self db_dictionaryForPaths:paths];
        return [obj db_floatForKey:paths.lastObject];
    }
    
    return defaultValue;
}

- (double)db_doubleForPath:(NSString *)path
{
    return [self db_doubleForPath:path defaultValue:0];
}

- (double)db_doubleForPath:(NSString *)path defaultValue:(double)defaultValue
{
    NSArray *paths = [path componentsSeparatedByString:@"."];
    if (paths.count == 1) {
        return [self db_doubleForKey:paths.lastObject];
    } else if (paths.count >= 2) {
        NSDictionary *obj = [self db_dictionaryForPaths:paths];
        return [obj db_doubleForKey:paths.lastObject];
    }
    
    return defaultValue;
}

- (NSObject *)db_objectForPath:(NSString *)path defaultValue:(NSObject *)defaultValue
{
    NSArray *paths = [path componentsSeparatedByString:@"."];
    if (paths.count == 1) {
        return [self db_objectForKey:paths.lastObject];
    } else if (paths.count >= 2) {
        NSDictionary *obj = [self db_dictionaryForPaths:paths];
        return [obj db_objectForKey:paths.lastObject];
    }
    
    return defaultValue;
}

- (NSObject *)db_objectForPath:(NSString *)path
{
    return [self db_objectForPath:path defaultValue:nil];
}

- (NSString *)db_stringForPath:(NSString *)path defaultValue:(NSString *)defaultValue
{
    NSArray *paths = [path componentsSeparatedByString:@"."];
    if (paths.count == 1) {
        return [self db_stringForKey:paths.lastObject];
    } else if (paths.count >= 2) {
        NSDictionary *obj = [self db_dictionaryForPaths:paths];
        return [obj db_stringForKey:paths.lastObject];
    }
    
    return defaultValue;
}

- (NSString *)db_stringForPath:(NSString *)path
{
    return [self db_stringForPath:path defaultValue:nil];
}

- (NSArray *)db_arrayForPath:(NSString *)path defaultValue:(NSArray *)defaultValue
{
    NSArray *paths = [path componentsSeparatedByString:@"."];
    if (paths.count == 1) {
        return [self db_arrayForKey:paths.lastObject];
    } else if (paths.count >= 2) {
        NSDictionary *obj = [self db_dictionaryForPaths:paths];
        return [obj db_arrayForKey:paths.lastObject];
    }
    
    return defaultValue;
}

- (NSArray *)db_arrayForPath:(NSString *)path
{
    return [self db_arrayForPath:path defaultValue:nil];
}

- (NSDictionary *)db_dictionaryForPath:(NSString *)path defaultValue:(NSDictionary *)defaultValue
{
    NSArray *paths = [path componentsSeparatedByString:@"."];
    if (paths.count == 1) {
        return [self db_dictionaryForKey:paths.lastObject];
    } else if (paths.count >= 2) {
        NSDictionary *obj = [self db_dictionaryForPaths:paths];
        return [obj db_dictionaryForKey:paths.lastObject];
    }
    
    return defaultValue;
}

- (NSDictionary *)db_dictionaryForPath:(NSString *)path
{
    return [self db_dictionaryForPath:path defaultValue:nil];
}

- (NSDate *)db_dateForPath:(NSString *)path defaultValue:(NSDate *)defaultValue {
    NSArray *paths = [path componentsSeparatedByString:@"."];
    if (paths.count == 1) {
        return [self db_dateForKey:paths.lastObject];
    } else if (paths.count >= 2) {
        NSDictionary *obj = [self db_dictionaryForPaths:paths];
        return [obj db_dateForKey:paths.lastObject];
    }
    
    return defaultValue;
}

- (NSDate *)db_dateForPath:(NSString *)path {
    return [self db_dateForPath:path defaultValue:nil];
}

- (NSData *)db_dataForPath:(NSString *)path defaultValue:(NSData *)defaultValue
{
    NSArray *paths = [path componentsSeparatedByString:@"."];
    if (paths.count == 1) {
        return [self db_dataForKey:paths.lastObject];
    } else if (paths.count >= 2) {
        NSDictionary *obj = [self db_dictionaryForPaths:paths];
        return [obj db_dataForKey:paths.lastObject];
    }
    
    return defaultValue;
}

- (NSData *)db_dataForPath:(NSString *)path
{
    return [self db_dataForPath:path defaultValue:nil];
}

- (NSURL *)db_URLForPath:(NSString *)path defaultValue:(NSURL *)defaultValue
{
    NSArray *paths = [path componentsSeparatedByString:@"."];
    if (paths.count == 1) {
        return [self db_URLForKey:paths.lastObject];
    } else if (paths.count >= 2) {
        NSDictionary *obj = [self db_dictionaryForPaths:paths];
        return [obj db_URLForKey:paths.lastObject];
    }
    
    return defaultValue;
}

- (NSURL *)db_URLForPath:(NSString *)path
{
    return [self db_URLForPath:path defaultValue:nil];
}

#pragma mark - Util
#pragma mark -

- (NSString *)encodeParamsForUrl
{
    NSMutableArray* pairs = [NSMutableArray array];
    for (NSString* key in self.keyEnumerator) {
        NSString* value = [self db_stringForKey:key defaultValue:@""];
        if (!value) {
            continue;
        }
        // deprecated in iOS 9.0
        //            NSString* escaped_value = (__bridge_transfer  NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)value, NULL,(CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8);
        NSString* escaped_value = (NSString *) [value stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"!*'();:@&=+$,/?%#[]"]];
        
        [pairs addObject:[NSString stringWithFormat:@"%@=%@", key, escaped_value]];
    }
    return [pairs componentsJoinedByString:@"&"];
}

@end

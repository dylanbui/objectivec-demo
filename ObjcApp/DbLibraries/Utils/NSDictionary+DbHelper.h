//
//  NSDictionary+DbHelper.h
//  PropzyPama
//
//  Created by Dylan Bui on 9/13/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * @brief Category methods to get values.
 *
 * USAGE:
 *   [dict db_integerForKey:@"value"]
 *     -> If the value was integer, it returns NSInteger value.
 *   [dict db_stringForKey:@"user.name"]
 *     -> You can get value from a nested dictionary.
 *        These methods are useful to get values from dictionary parsed JSON.
 */

@interface NSDictionary (DbHelper)

#pragma mark - ForKey

- (BOOL)db_boolForKey:(NSString *)key defaultValue:(BOOL)defaultValue;
- (BOOL)db_boolForKey:(NSString *)key;
- (NSInteger)db_integerForKey:(NSString *)key defaultValue:(NSInteger)defaultValue;
- (NSInteger)db_integerForKey:(NSString *)key;

- (long)db_longForKey:(NSString *)key defaultValue:(long)defaultValue;
- (long)db_longForKey:(NSString *)key;
- (long long)db_longLongForKey:(NSString *)key defaultValue:(long long)defaultValue;
- (long long)db_longLongForKey:(NSString *)key;
- (int)db_intForKey:(NSString *)key defaultValue:(int)defaultValue;
- (int)db_intForKey:(NSString *)key;

- (float)db_floatForKey:(NSString *)key defaultValue:(float)defaultValue;
- (float)db_floatForKey:(NSString *)key;
- (double)db_doubleForKey:(NSString *)key defaultValue:(double)defaultValue;
- (double)db_doubleForKey:(NSString *)key;

- (NSTimeInterval)db_timeIntervalForKey:(NSString *)key defaultValue:(NSTimeInterval)defaultValue;
- (NSTimeInterval)db_timeIntervalForKey:(NSString *)key;
- (id)db_objectForKey:(NSString *)key defaultValue:(id)defaultValue;
- (id)db_objectForKey:(NSString *)key;
- (NSString *)db_stringForKey:(NSString *)key defaultValue:(NSString *)defaultValue;
- (NSString *)db_stringForKey:(NSString *)key;
- (NSArray *)db_arrayForKey:(NSString *)key defaultValue:(NSArray *)defaultValue;
- (NSArray *)db_arrayForKey:(NSString *)key;
- (NSDictionary *)db_dictionaryForKey:(NSString *)key defaultValue:(NSDictionary *)defaultValue;
- (NSDictionary *)db_dictionaryForKey:(NSString *)key;

- (NSDate *)db_dateForKey:(NSString *)key defaultValue:(NSDate *)defaultValue;
- (NSDate *)db_dateForKey:(NSString *)key;
- (NSData *)db_dataForKey:(NSString *)key defaultValue:(NSData *)defaultValue;
- (NSData *)db_dataForKey:(NSString *)key;
- (NSURL *)db_URLForKey:(NSString *)key defaultValue:(NSURL *)defaultValue;
- (NSURL *)db_URLForKey:(NSString *)key;

#pragma mark - ForPath

- (BOOL)db_boolForPath:(NSString *)path defaultValue:(BOOL)defaultValue;
- (BOOL)db_boolForPath:(NSString *)path;
- (NSInteger)db_integerForPath:(NSString *)path defaultValue:(NSInteger)defaultValue;
- (NSInteger)db_integerForPath:(NSString *)path;

- (long)db_longForPath:(NSString *)key defaultValue:(long)defaultValue;
- (long)db_longForPath:(NSString *)key;
- (long long)db_longLongForPath:(NSString *)key defaultValue:(long long)defaultValue;
- (long long)db_longLongForPath:(NSString *)key;
- (int)db_intForPath:(NSString *)path defaultValue:(int)defaultValue;
- (int)db_intForPath:(NSString *)path;

- (float)db_floatForPath:(NSString *)path defaultValue:(float)defaultValue;
- (float)db_floatForPath:(NSString *)path;
- (double)db_doubleForPath:(NSString *)path defaultValue:(double)defaultValue;
- (double)db_doubleForPath:(NSString *)path;

- (NSObject *)db_objectForPath:(NSString *)path defaultValue:(NSObject *)defaultValue;
- (NSObject *)db_objectForPath:(NSString *)path;
- (NSString *)db_stringForPath:(NSString *)path defaultValue:(NSString *)defaultValue;
- (NSString *)db_stringForPath:(NSString *)path;
- (NSArray *)db_arrayForPath:(NSString *)path defaultValue:(NSArray *)defaultValue;
- (NSArray *)db_arrayForPath:(NSString *)path;
- (NSDictionary *)db_dictionaryForPath:(NSString *)path defaultValue:(NSDictionary *)defaultValue;
- (NSDictionary *)db_dictionaryForPath:(NSString *)path;

- (NSDate *)db_dateForPath:(NSString *)path defaultValue:(NSDate *)defaultValue;
- (NSDate *)db_dateForPath:(NSString *)path;
- (NSData *)db_dataForPath:(NSString *)path defaultValue:(NSData *)defaultValue;
- (NSData *)db_dataForPath:(NSString *)path;
- (NSURL *)db_URLForPath:(NSString *)key defaultValue:(NSURL *)defaultValue;
- (NSURL *)db_URLForPath:(NSString *)key;

@end

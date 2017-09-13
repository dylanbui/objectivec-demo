//
//  NSMutableDictionary+DbHelper.h
//  PropzyPama
//
//  Created by Dylan Bui on 9/13/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSMutableDictionary (DbHelper)

- (void)db_setBool:(BOOL)value forKey:(NSString *)key;
- (void)db_setInteger:(NSInteger)value forKey:(NSString *)key;
- (void)db_setLong:(long)value forKey:(NSString *)key;
- (void)db_setLongLong:(long long)value forKey:(NSString *)key;
- (void)db_setInt:(int)value forKey:(NSString *)key;
- (void)db_setFloat:(float)value forKey:(NSString *)key;
- (void)db_setDouble:(double)value forKey:(NSString *)key;
- (void)db_setTimeInterval:(NSTimeInterval)value forKey:(NSString *)key;
- (void)db_setCGPoint:(CGPoint)value forKey:(NSString *)key;
- (void)db_setCGRect:(CGRect)value forKey:(NSString *)key;
- (void)db_setCGSize:(CGSize)value forKey:(NSString *)key;
- (void)db_setCGAffineTransform:(CGAffineTransform)value forKey:(NSString *)key;
- (void)db_setUIEdgeInsets:(UIEdgeInsets)value forKey:(NSString *)key;
- (void)db_setUIOffset:(UIOffset)value forKey:(NSString *)key;

@end

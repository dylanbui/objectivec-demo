//
//  NSObject+SimpleMapping.h
//  PropzyDiy
//
//  Created by Dylan Bui on 3/15/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//  Build on : https://github.com/aperechnev/APJSONMapping

#import <Foundation/Foundation.h>

/**
 @brief Category that extends NSObject functionality with JSON mapping.
 
 @discussion Use this category to make NSObject able to initialize from JSON
 and vice versa.
 */
@interface NSObject (SimpleMapping)

/**
 @brief Tells to an object how to map to and to parse from JSON.
 
 @discussion You must to override this methods in your subclass add relations
 between object's properties and JSON fields.
 */
+ (NSMutableDictionary *)om_objectMapping;

/**
 @brief Initializes object with dictionary following the mapping rules.
 
 @discussion Object will be initialized with dictionary following the rules, that you
 declared in <code>objectMapping:</code> method.
 
 @param dictionary that contains source values, that will be used to initialize object's
 properties.
 
 @return An instance of object, initialized with passed dictionary.
 */
- (instancetype)initWithDictionary_om:(NSDictionary *)dictionary;

- (void)loadPropertyValueFromDictionary_om:(NSDictionary *)dictionary withMappingRules:(NSDictionary *)mappingRules;

- (void)loadPropertyValueFromDictionary_om:(NSDictionary *)dictionary;


/**
 @brief Initializes object with JSON string following the mapping rules.
 
 @discussion Object will be initialized with JSON string following the rules, that you
 declared in <code>objectMapping:</code> method.
 
 @param jsonString that contains source values, that will be used to initialize object's
 properties.
 
 @return An instance of object, initialized with passed JSON string.
 */
- (instancetype)initWithJSONString_om:(NSString *)jsonString;

/**
 @brief Maps object into dictionary
 
 @return Dictionary, that contains all object's properties, that pointed in <code>objectMapping:</code>
 method, as key-value pairs.
 */
- (NSDictionary *)om_mapToDictionary;

/**
 @brief Maps object to JSON string
 
 @return String, that contains all object's properties, that pointed in <code>objectMapping:</code>
 method, as a fields in JSON object.
 */
- (NSString *)om_mapToJSONString;

@end

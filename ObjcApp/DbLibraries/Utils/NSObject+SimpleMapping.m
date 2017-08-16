//
//  NSObject+SimpleMapping.m
//  PropzyDiy
//
//  Created by Dylan Bui on 3/15/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "NSObject+SimpleMapping.h"
#import <objc/runtime.h>

@implementation NSObject (SimpleMapping)

/*
 Example for subclass :
 
 + (NSMutableDictionary *)ap_objectMapping {
    NSMutableDictionary * mapping = [super ap_objectMapping];
    if (mapping) {
        NSDictionary * objectMapping = @{ @"someNumber": @"some_number",
                                            @"someString": @"some_string"};
        [mapping addEntriesFromDictionary:objectMapping];
    }
    return mapping;
 }

 */

+ (NSMutableDictionary *)om_objectMapping {
    return [NSMutableDictionary new];
}

#pragma mark - Dictionary mapping

- (instancetype)initWithDictionary_om:(NSDictionary *)dictionary {
    self = [self init];
    if (self) {
        [self loadPropertyValueFromDictionary_om:dictionary];
    }
    return self;
}

- (void)loadPropertyValueFromDictionary_om:(NSDictionary *)dictionary
{
    NSDictionary *mappingRules = [[self class] om_objectMapping];
    [self loadPropertyValueFromDictionary_om:dictionary withMappingRules:mappingRules];
}

- (void)loadPropertyValueFromDictionary_om:(NSDictionary *)dictionary withMappingRules:(NSDictionary *)mappingRules
{
//    NSDictionary *mappingRules = [[self class] om_objectMapping];
    
    for (NSString *propertyName in mappingRules) {
        id jsonFieldName = mappingRules[propertyName];
        Class propertyClass = [self om_classForPropertyNamed:propertyName];
        
        if (propertyClass == [NSArray class]) {
            NSString *sss = [NSString stringWithFormat:@"%@Type", propertyName];
            SEL sel = NSSelectorFromString(sss);
            if ([[self class] respondsToSelector:sel]) {
                Class typeOfPropertyObjects = ((Class (*)(id, SEL))[[self class] methodForSelector:sel])([self class], sel);
                
                NSMutableArray *array = [[NSMutableArray alloc] init];
                for (NSDictionary *dict in dictionary[jsonFieldName]) {
                    id obj = [[typeOfPropertyObjects alloc] initWithDictionary_om:dict];
                    [array addObject:obj];
                }
                
                SEL selector = NSSelectorFromString([NSString stringWithFormat:@"set%@%@:", [[propertyName substringToIndex:1] capitalizedString], [propertyName substringFromIndex:1]]);
                ((void (*)(id, SEL, id))[self methodForSelector:selector])(self, selector, array);
                
                continue;
            }
        }
        
        BOOL isRelationship = [self om_classHasMapping:propertyClass];
        if (isRelationship == YES) {
            // -- Fix : Show wrong related key --
            // NSDictionary *childDictionary = dictionary[propertyName];
            NSDictionary *childDictionary = dictionary[jsonFieldName];
            Class relationClass = [self om_classForPropertyNamed:propertyName];
            [self setValue:[[relationClass alloc] initWithDictionary_om:childDictionary]
                forKeyPath:propertyName];
            continue;
        }
        
        id value = dictionary[jsonFieldName];
        if ((value != nil) && ([value class] != [NSNull class])) {
            [self setValue:value forKey:propertyName];
        }
    }
}

- (Class)om_classForPropertyNamed:(NSString *)propertyName {
    objc_property_t property = class_getProperty([self class], propertyName.UTF8String);
    
    NSString *propertyAttributes = [NSString stringWithUTF8String:property_getAttributes(property)];
    
    NSArray *attributeComponentList = [propertyAttributes componentsSeparatedByString:@"\""];
    if (attributeComponentList.count < 2) {
        return [NSObject class];
    }
    
    NSString *propertyClassName = [attributeComponentList objectAtIndex:1];
    Class propertyClass = NSClassFromString(propertyClassName);
    
    return propertyClass;
}

- (BOOL)om_classHasMapping:(Class)class {
    BOOL hasObjectMapping = ![[class om_objectMapping] isEqualToDictionary:@{}];
    if (hasObjectMapping) {
        return YES;
    }
    
    return NO;
}

- (NSDictionary *)om_mapToDictionary {
    NSMutableDictionary *mappedDictionary = [NSMutableDictionary new];
    NSDictionary *objectMapping = [[self class] om_objectMapping];
    
    for (id objectKey in objectMapping) {
        id value = [self valueForKey:objectKey];
        if ([value isKindOfClass:[NSNull class]] == NO && value != nil) {
            
            // -- Fix : Show wrong related key --
            id dictionaryKey = objectMapping[objectKey];
            
            BOOL isRelationship = [[[value class] om_objectMapping] isEqualToDictionary:@{}] == NO;
            if (isRelationship == YES) {
                NSDictionary *mappedSubDictionary = [value om_mapToDictionary];
                // -- Fix : Show wrong related key --
                // [mappedDictionary addEntriesFromDictionary:@{ objectKey: mappedSubDictionary }];
                [mappedDictionary addEntriesFromDictionary:@{ dictionaryKey: mappedSubDictionary }];
                continue;
            }
            
            SEL sel = NSSelectorFromString([NSString stringWithFormat:@"%@Type", objectKey]);
            
            // id dictionaryKey = objectMapping[objectKey];
            
            BOOL isArray = [value isKindOfClass:[NSArray class]];
            BOOL responds = [[self class] respondsToSelector:sel];
            
            BOOL isArrayRelation = isArray && responds;
            if (isArrayRelation) {
                NSMutableArray *array = [[NSMutableArray alloc] init];
                for (NSDictionary *obj in value) {
                    if ([obj respondsToSelector:@selector(om_mapToDictionary)]) {
                        NSDictionary *dict = [obj om_mapToDictionary];
                        [array addObject:dict];
                    }
                }
                
                [mappedDictionary addEntriesFromDictionary:@{ dictionaryKey: array.copy }];
                continue;
            }
            
            [mappedDictionary addEntriesFromDictionary:@{ dictionaryKey: value }];
        }
    }
    
    return mappedDictionary;
}

#pragma mark - JSON mapping

- (instancetype)initWithJSONString_om:(NSString *)jsonString {
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                               options:NSJSONReadingMutableContainers
                                                                 error:nil];
    return [self initWithDictionary_om:dictionary];
}

- (NSString *)om_mapToJSONString {
    NSDictionary *dictionary = [self om_mapToDictionary];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:nil];
    NSString *string = [[NSString alloc] initWithData:data
                                             encoding:NSUTF8StringEncoding];
    return string;
}

@end

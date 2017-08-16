//
//  NSObject+Json.m
//  SDKDemos
//
//  Created by Dylan Bui on 11/5/13.
//
//

#import "NSObject+Json.h"

@implementation NSObject (NSObject_SBJsonWriting)

- (NSString *)JSONRepresentation
{
    __autoreleasing NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if (error != nil) return @"";
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

@end



@implementation NSString (NSString_SBJsonParsing)

- (id)JSONValue
{
    __autoreleasing NSError *error = NULL;
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    id result = [NSJSONSerialization JSONObjectWithData:data
                                                options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

@end



@implementation NSData (NSData_SBJsonParsing)

- (id)JSONValue
{
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:self
                                                options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

@end

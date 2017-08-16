//
//  NSObject+Json.h
//  SDKDemos
//
//  Created by Dylan Bui on 11/5/13.
//
//

#import <Foundation/Foundation.h>

/// Adds JSON generation to NSObject
@interface NSObject (NSObject_SBJsonWriting)

/**
 Encodes the receiver into a JSON string
 
 Although defined as a category on NSObject it is only defined for NSArray and NSDictionary.
 
 @return the receiver encoded in JSON, or nil on error.
 
 */
- (NSString *)JSONRepresentation;

@end


#pragma mark JSON Parsing

/// Adds JSON parsing methods to NSString
@interface NSString (NSString_SBJsonParsing)

/**
 Decodes the receiver's JSON text
 
 @return the NSDictionary or NSArray represented by the receiver, or nil on error.
 
 */
- (id)JSONValue;

@end

/// Adds JSON parsing methods to NSData
@interface NSData (NSData_SBJsonParsing)

/**
 Decodes the receiver's JSON data
 
 @return the NSDictionary or NSArray represented by the receiver, or nil on error.
 
 */
- (id)JSONValue;


@end

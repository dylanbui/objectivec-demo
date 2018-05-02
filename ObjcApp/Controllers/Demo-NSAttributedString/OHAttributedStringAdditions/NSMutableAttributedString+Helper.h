//
//  NSMutableAttributedString+Helper.h
//  ObjcApp
//
//  Created by Dylan Bui on 5/2/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//  Base on : https://github.com/shmidt/MASAttributes

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSMutableAttributedString (Helper)

- (void)addColor:(UIColor *)color substring:(NSString *)substring;
- (void)addBackgroundColor:(UIColor *)color substring:(NSString *)substring;
- (void)addUnderlineForSubstring:(NSString *)substring;
- (void)addStrikeThrough:(int)thickness substring:(NSString *)substring;
- (void)addShadowColor:(UIColor *)color width:(int)width height:(int)height radius:(int)radius substring:(NSString *)substring;
- (void)addFontWithName:(NSString *)fontName size:(int)fontSize substring:(NSString *)substring;
- (void)addFont:(UIFont *)font substring:(NSString *)substring;
- (void)addAlignment:(NSTextAlignment)alignment substring:(NSString *)substring;
- (void)addStrokeColor:(UIColor *)color thickness:(int)thickness substring:(NSString *)substring;
- (void)addVerticalGlyph:(BOOL)glyph substring:(NSString *)substring;

@end



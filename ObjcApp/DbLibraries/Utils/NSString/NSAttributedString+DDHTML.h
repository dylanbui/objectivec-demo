//
//  NSAttributedString+DDHTML.h
//  PropzyDiy
//
//  Created by Dylan Bui on 4/26/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//  Base : https://github.com/dbowen/NSAttributedString-DDHTML
//	https://blog.csdn.net/u012282115/article/details/36419413

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSAttributedString (DDHTML)

/**
 *  Generates an attributed string from HTML.
 *
 *  @param htmlString HTML String
 *
 *  @return Attributed string
 */
+ (NSAttributedString *)attributedStringFromHTML:(NSString *)htmlString;

/**
 *  Generates an attributed string from HTML.
 *
 *  @param htmlString HTML String
 *  @param boldFont   Font to use for \<b\> and \<strong\> tags
 *  @param italicFont Font to use for \<i\> and \<em\> tags
 *
 *  @return Attributed string
 */
+ (NSAttributedString *)attributedStringFromHTML:(NSString *)htmlString boldFont:(UIFont *)boldFont italicFont:(UIFont *)italicFont;

/**
 *  Generates an attributed string from HTML.
 *
 *  @param htmlString HTML String
 *  @param normalFont Font to use for general text
 *  @param boldFont   Font to use for \<b\> and \<strong\> tags
 *  @param italicFont Font to use for \<i\> and \<em\> tags
 *
 *  @return Attributed string
 */
+ (NSAttributedString *)attributedStringFromHTML:(NSString *)htmlString normalFont:(UIFont *)normalFont boldFont:(UIFont *)boldFont italicFont:(UIFont *)italicFont;

/**
 *  Generates an attributed string from HTML.
 *
 *  @param htmlString   HTML String
 *  @param normalFont   Font to use for general text
 *  @param boldFont     Font to use for \<b\> and \<strong\> tags
 *  @param italicFont   Font to use for \<i\> and \<em\> tags
 *  @param imageMap     Images to use in place of standard bundle images.
 *
 *  @return Attributed string
 */
+ (NSAttributedString *)attributedStringFromHTML:(NSString *)htmlString normalFont:(UIFont *)normalFont boldFont:(UIFont *)boldFont italicFont:(UIFont *)italicFont imageMap:(NSDictionary<NSString *, UIImage *> *)imageMap;

@end

NS_ASSUME_NONNULL_END

//
//  Utils.h
//  PropzySam
//
//  Created by Dylan Bui on 1/6/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "MBProgressHUD.h"
#import "RMUniversalAlert.h"

@interface DbUtils : NSObject

// -- Utility --
+ (NSString *_Nonnull)generateRandomString:(int)num;
+ (void)callPhoneNumber:(NSString *_Nonnull)phonenumber completionHandler:(void (^ __nullable)(BOOL success))completion;

// -- Thread --
+ (void)dispatchToMainQueue:(_Nonnull dispatch_block_t)block;
+ (void)dispatchToBgQueue:(_Nonnull dispatch_block_t)block;
+ (void)delayCallback:(void(^ _Nonnull)(void))callback forSeconds:(double)delayInSeconds;

+ (void)processScheduleWithBlock:(void(^ _Nonnull)(void))inBlock afterSecond:(double)delayInSeconds;

// -- Notification --
+ (void)removeNotification:(_Nonnull id)sender;
+ (void)postNotification:(NSString *_Nonnull)name object:(id _Nullable)object;
+ (void)postNotification:(NSString *_Nonnull)name object:(id _Nullable)object userInfo:(NSDictionary *_Nullable)aUserInfo;
+ (void)addNotification:(NSString *_Nonnull)name observer:(_Nonnull id)sender selector:(SEL _Nullable)selector object:(id _Nullable)object;

// -- AlertView --
+ (RMUniversalAlert *_Nullable)showAlertMessage1ButtonWithController:(UIViewController *_Nonnull)viewController
                                        title:(NSString *_Nonnull)title
                                      message:(NSString *_Nonnull)message
                                  buttonTitle:(NSString *_Nonnull)cancelButtonTitle
                                     tapBlock:(void (^_Nullable)(void))block;

+ (RMUniversalAlert *_Nullable)showAlertMessage2ButtonWithController:(UIViewController *_Nonnull)viewController
                                        title:(NSString *_Nonnull)title
                                      message:(NSString *_Nonnull)message
                                okButtonTitle:(NSString *_Nonnull)okButtonTitle
                                      okBlock:(void (^_Nullable)(void))okBlock
                            cancelButtonTitle:(NSString *_Nonnull)cancelButtonTitle
                                  cancelBlock:(void (^_Nullable)(void))cancelBlock;

+ (void)showSettingsLocationServices:(UIViewController *_Nullable)viewController;

+ (void)showSettingsNetworkConnection:(UIViewController *_Nullable)viewController;

// -- Color --
// Create a color using a string with a webcolor : ex. [Utils colorWithHexString:@"#03047F"]
+ (UIColor *_Nonnull)colorWithHexString:(NSString *_Nonnull)hexStr;
// Create a color using a hex RGB value : ex. [Utils colorWithHexValue: 0x03047F]
+ (UIColor *_Nonnull)colorWithHexValue: (NSInteger) rgbValue;

// -- Datetime --
+ (NSString *_Nonnull)dateToString:(NSNumber *_Nonnull)timeMiliSeconds withFormat:(NSString *_Nonnull)format;
+ (NSString *_Nonnull)stringFromDate:(NSDate *_Nonnull)date withFormat:(NSString *_Nonnull)format;
+ (NSString *_Nonnull)getCurrentDate:(NSString *_Nonnull)format;
+ (NSDate *_Nonnull)convertStringToNSDate:(NSString *_Nonnull)date withFormat:(NSString *_Nonnull)format;
+ (NSInteger)totalSecondFromNowTo:(NSString *_Nonnull)endTime andDateFormat:(NSString *_Nonnull)format;
+ (NSString *_Nonnull)formatTimeFromSeconds:(int)numberOfSeconds;


// -- Validate --
+ (BOOL)stringEmpty:(NSString *_Nonnull)str;
+ (NSString*_Nonnull) trimText:(NSString*_Nonnull)str;
+ (BOOL)isEmail:(NSString*_Nonnull)email;

// -- Loading View --
+ (void)showLoading:(id _Nonnull)delegateObj;
+ (void)hideLoading:(id _Nullable)delegateObj;

// -- Height of text or label --
+ (UIFont*_Nonnull)getFontSizeFixedWith:(UILabel*_Nonnull)aLabel andFont:(UIFont*_Nonnull)fontTemp withPadding:(float)padding;
+ (CGSize)sizeOfTextWithLabel:(UILabel *_Nonnull)lbl;
+ (CGSize)heightOfText:(NSString *_Nonnull)text withMaxWidth:(float)width withFont:(UIFont *_Nonnull)font;

+ (NSArray *_Nonnull)getListOfKey:(NSString *_Nonnull)key inArray:(NSArray *_Nonnull)list;

+ (UIViewController *_Nonnull)getTopViewController;

+ (void)animationAddSubView:(UIView *_Nonnull)subView toView:(UIView *_Nonnull)toView completion:(void (^_Nullable)(BOOL finished))completion;
+ (void)animationRemoveSubView:(UIView *__nullable)subView completion:(void (^_Nullable)(BOOL finished))completion;



@end

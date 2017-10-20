//
//  Utils.m
//  PropzySam
//
//  Created by Dylan Bui on 1/6/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "DbUtils.h"


@implementation DbUtils

+ (NSString *)generateRandomString:(int)num
{
    NSMutableString* string = [NSMutableString stringWithCapacity:num];
    for (int i = 0; i < num; i++) {
        [string appendFormat:@"%C", (unichar)('a' + arc4random_uniform(25))];
    }
    return [NSString stringWithString: string];
}

+ (void)callPhoneNumber:(NSString *)phonenumber completionHandler:(void (^ __nullable)(BOOL success))completion
{
    NSURL *URL = nil;
    NSURL *phoneUrl = [NSURL URLWithString:[@"telprompt://" stringByAppendingString:phonenumber]];
    NSURL *phoneFallbackUrl = [NSURL URLWithString:[@"tel://" stringByAppendingString:phonenumber]];
    
    UIApplication *application = [UIApplication sharedApplication];
    
    if ([application canOpenURL:phoneUrl]) {
        URL = phoneUrl;
    } else if ([application canOpenURL:phoneFallbackUrl]) {
        URL = phoneFallbackUrl;
    } else {
        // Show an error message: Your device can not do phone calls.
        completion(NO);
        return;
    }
    
    if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
        [application openURL:URL options:@{} completionHandler:^(BOOL success) {
            completion(success);
            // NSLog(@"Open %@: %d",URL,success);
        }];
    } else {
        BOOL success = [application openURL:URL];
        completion(success);
        // NSLog(@"Open %@: %d",URL,success);
    }
}

#pragma mark -
#pragma mark NSLayoutConstraint
#pragma mark -

+ (NSLayoutConstraint *_Nullable)getNSLayoutConstraint:(NSLayoutAttribute)layoutAttribute ofView:(UIView *_Nonnull)view
{
    NSLayoutConstraint *returnConstraint = nil;
    for (NSLayoutConstraint *constraint in view.constraints) {
        if (constraint.firstAttribute == layoutAttribute) {
            returnConstraint = constraint;
            break;
        }
    }
    return returnConstraint;
}

#pragma mark -
#pragma mark Thread
#pragma mark -

+ (void)dispatchToMainQueue:(dispatch_block_t)block
{
    dispatch_async(dispatch_get_main_queue(), block);
}

+ (void)dispatchToBgQueue:(dispatch_block_t)block
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        dispatch_async(dispatch_get_main_queue(), block);
//    });
//    dispatch_async(dispatch_get_main_queue(), block);
}

+ (void)delayCallback:(void(^)(void))callback forSeconds:(double)delayInSeconds
{
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        if(callback){
            callback();
        }
    });
}

static NSTimer *processScheduleWithBlock = nil;
+ (void)processScheduleWithBlock:(void(^)(void))inBlock afterSecond:(double)delayInSeconds
{
    if (processScheduleWithBlock) {
        [processScheduleWithBlock invalidate];
        processScheduleWithBlock = nil;
    }
    
    void (^block)(void) = [inBlock copy];
    processScheduleWithBlock = [NSTimer scheduledTimerWithTimeInterval:delayInSeconds
                                           target:self selector:@selector(executeSimpleBlock:) userInfo:block repeats:NO];
}

+ (void)executeSimpleBlock:(NSTimer *)inTimer;
{
    if([inTimer userInfo])
    {
        void (^block)(void) = (void (^)(void))[inTimer userInfo];
        block();
    }
}

#pragma mark -
#pragma mark Notification
#pragma mark -

//+ (void)removeNotification:(id)sender
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:sender];
//}
//
//+ (void)postNotification:(NSString *)name withObject:(id)object
//{
//    [[NSNotificationCenter defaultCenter] postNotificationName:name object:object];
//}
//
//+ (void)addNotification:(NSString *)name observer:(id)sender selector:(SEL)selector object:(id)object
//{
//    [[NSNotificationCenter defaultCenter] addObserver:sender selector:selector name:name object:object];
//}

+ (void)removeNotification:(id)sender
{
    [[NSNotificationCenter defaultCenter] removeObserver:sender];
}

+ (void)removeNotification:(id)sender name:(nullable NSNotificationName)aName
{
    [[NSNotificationCenter defaultCenter] removeObserver:sender name:aName object:nil];
}


+ (void)postNotification:(NSString *)name object:(id)object
{
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:object userInfo:nil];
}

+ (void)postNotification:(NSString *)name object:(id)object userInfo:(NSDictionary *)aUserInfo
{
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:object userInfo:aUserInfo];
}

+ (void)addNotification:(NSString *)name observer:(id)sender selector:(SEL)selector object:(id)object
{
    [[NSNotificationCenter defaultCenter] addObserver:sender selector:selector name:name object:object];
}


#pragma mark -
#pragma mark AlertView
#pragma mark -

+ (RMUniversalAlert *)showAlertMessage1ButtonWithController:(UIViewController *)viewController
                                        title:(NSString *)title
                                      message:(NSString *)message
                                  buttonTitle:(NSString *)cancelButtonTitle
                                     tapBlock:(void (^)(void))block;
{
    return [RMUniversalAlert showAlertInViewController:viewController
                                      withTitle:title
                                        message:message
                              cancelButtonTitle:cancelButtonTitle
                         destructiveButtonTitle:nil
                              otherButtonTitles:nil
                                       tapBlock:^(RMUniversalAlert *alert, NSInteger buttonIndex){
                                           if (block != nil) {
                                               block();
                                           }
                                       }];
}

+ (RMUniversalAlert *)showAlertMessage2ButtonWithController:(UIViewController *)viewController
                                        title:(NSString *)title
                                      message:(NSString *)message
                                okButtonTitle:(NSString *)okButtonTitle
                                      okBlock:(void (^)(void))okBlock
                            cancelButtonTitle:(NSString *)cancelButtonTitle
                                  cancelBlock:(void (^)(void))cancelBlock;
{
    return [RMUniversalAlert showAlertInViewController:viewController
                                      withTitle:title
                                        message:message
                              cancelButtonTitle:cancelButtonTitle
                         destructiveButtonTitle:nil
                              otherButtonTitles:@[okButtonTitle]
                                       tapBlock:^(RMUniversalAlert *alert, NSInteger buttonIndex){
                                           if (buttonIndex == alert.cancelButtonIndex) {
                                               if (cancelBlock != nil) {
                                                   cancelBlock();
                                               }
                                           } else if (buttonIndex >= alert.firstOtherButtonIndex) {
                                               if (okBlock != nil) {
                                                   okBlock();
                                               }
                                           }
                                       }];
}

static RMUniversalAlert *alertLocationServices = nil;
+ (void)showSettingsLocationServices:(UIViewController *)viewController;
{
    if (alertLocationServices != nil)
        return;
    alertLocationServices = [self showAlertMessage2ButtonWithController:viewController
                                          title:@"Location Services Is Turned Off"
                                        message:@"Turn On Location Services to allow maps to determine your location."
                                  okButtonTitle:@"OK"
                                        okBlock:^{
                                            alertLocationServices = nil;
                                        }
                              cancelButtonTitle:@"Settings"
                                    cancelBlock:^{
                                        alertLocationServices = nil;
                                        // -- Open settings Location Services --
                                        // iOS < 10
                                        NSURL *settingsUrl = [NSURL URLWithString:@"prefs:root=Privacy&path=LOCATION"];
                                        if (([[[UIDevice currentDevice] systemVersion] compare:@"10" options:NSNumericSearch] != NSOrderedAscending)) {
                                            // iOS >= 10
                                            settingsUrl = [NSURL URLWithString:@"App-Prefs:root=Privacy&path=LOCATION"];
                                        }
                                        [[UIApplication sharedApplication] openURL:settingsUrl];
                                    }];
}

static RMUniversalAlert *alertNetworkConnection = nil;
+ (void)showSettingsNetworkConnection:(UIViewController *)viewController;
{
    if (alertNetworkConnection != nil)
        return;
    alertNetworkConnection = [self showAlertMessage2ButtonWithController:viewController
                                          title:@"Cellular Data Is Turned Off"
                                        message:@"Turn on cellular data or use Wi-Fi to access data."
                                  okButtonTitle:@"OK"
                                        okBlock:^{
                                            alertNetworkConnection = nil;
                                        }
                              cancelButtonTitle:@"Settings"
                                    cancelBlock:^{
                                        alertNetworkConnection = nil;
                                        // -- Open settings Wifi --
                                        // iOS < 9.0
                                        NSURL *settingsUrl = [NSURL URLWithString:@"prefs:root=WIFI"];
                                        if (([[[UIDevice currentDevice] systemVersion] compare:@"9" options:NSNumericSearch] != NSOrderedAscending)) {
                                            // iOS >= 9.0
                                            settingsUrl = [NSURL URLWithString:@"App-Prefs:root=WIFI"];
                                        }
                                        [[UIApplication sharedApplication] openURL:settingsUrl];
                                    }];
}

#pragma mark -
#pragma mark Create a color using a string with a webcolor
#pragma mark -

+ (UIColor *)colorWithHexString:(NSString *)hexStr
{
    return [self colorWithHexString:hexStr alpha:1.0];
}

// Create a color using a string with a webcolor
// ex. [Utils colorWithHexString:@"#03047F"]
+ (UIColor *)colorWithHexString:(NSString *)hexStr alpha:(float)alpha
{
    NSScanner *scanner;
    unsigned int rgbval;
    
    scanner = [NSScanner scannerWithString: hexStr];
    [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
    [scanner scanHexInt: &rgbval];
    
    return [DbUtils colorWithHexValue:rgbval alpha:alpha];
}

// Create a color using a hex RGB value
// ex. [Utils colorWithHexValue: 0x03047F]
+ (UIColor *)colorWithHexValue:(NSInteger)rgbValue alpha:(float)alpha
{
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0
                           green:((float)((rgbValue & 0xFF00) >> 8))/255.0
                            blue:((float)(rgbValue & 0xFF))/255.0
                           alpha:alpha];
}

#pragma mark -
#pragma mark Date Time
#pragma mark -

+ (NSString *)dateToString:(NSNumber *)timeMiliSeconds withFormat:(NSString *)format
{
    NSString *strTimeMiliSeconds = [NSString stringWithFormat:@"%@", timeMiliSeconds];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[strTimeMiliSeconds longLongValue]/1000];
    if(date == nil) {
        date = [NSDate dateWithTimeIntervalSince1970:[strTimeMiliSeconds longLongValue]];
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:date];
}

+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format
{
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:format];
//    return [formatter stringFromDate:date];
    NSDateFormatter *tempFormatter = [[NSDateFormatter alloc] init];
    [tempFormatter setDateFormat:format];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [tempFormatter setLocale:usLocale];
    return [tempFormatter stringFromDate:date];
}

+ (NSString*)getCurrentDate:(NSString*)format
{
    NSDate *currDate = [NSDate date];
    NSDateFormatter *tempFormatter = [[NSDateFormatter alloc] init];
    [tempFormatter setDateFormat:format];
    return [tempFormatter stringFromDate:currDate];
}

+ (NSDate*)convertStringToNSDate:(NSString*)date withFormat:(NSString*)format
{
    NSDateFormatter *tempFormatter = [[NSDateFormatter alloc]init];
    [tempFormatter setDateFormat:format];
    return [tempFormatter dateFromString:date];
}

+ (NSInteger)totalSecondFromNowTo:(NSString*)endTime andDateFormat:(NSString*)format
{
    NSDateFormatter *tempFormatter = [[NSDateFormatter alloc] init];
    [tempFormatter setDateFormat:format];
    NSDate *lastDate = [tempFormatter dateFromString:endTime];
    return [lastDate timeIntervalSinceNow];
}

+ (NSString *)formatTimeFromSeconds:(int)numberOfSeconds
{
    int seconds = numberOfSeconds % 60;
    int minutes = (numberOfSeconds / 60) % 60;
    int hours = numberOfSeconds / 3600;
    
    //we have >=1 hour => example : 3h:25m
    if (hours) {
        return [NSString stringWithFormat:@"%d giờ %02d phút", hours, minutes];
    }
    //we have 0 hours and >=1 minutes => example : 3m:25s
    if (minutes) {
        return [NSString stringWithFormat:@"%d phút %02d giây", minutes, seconds];
    }
    //we have only seconds example : 25s
    return [NSString stringWithFormat:@"%d giây", seconds];
}

#pragma mark -
#pragma mark Validate
#pragma mark -

+ (BOOL)stringEmpty:(NSString *)str
{
    // -- nil == empty --
    if (str == nil || [str isKindOfClass:[NSNull class]])
        return YES;
    return ([[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length] <= 0);
}

+ (NSString*)trimText:(NSString*)str
{
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

+ (BOOL)isEmail:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (BOOL)isPhoneNumber:(NSString *)phoneNum {
    NSString *phoneRegex = @"^((\\+)|(0))[0-9]{6,14}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    
    return [phoneTest evaluateWithObject:phoneNum];
}

#pragma mark -
#pragma mark Loading View
#pragma mark -

static MBProgressHUD *loadingView = nil;

+ (void)showLoading:(id)delegateObj
{
    // Create loading object
    UIViewController *delegateViewController = delegateObj;
    
    if (delegateViewController.navigationController.view != nil)
    {
        loadingView = [[MBProgressHUD alloc] initWithView:delegateViewController.navigationController.view];
        [delegateViewController.navigationController.view addSubview:loadingView];
        [delegateViewController.navigationController.view bringSubviewToFront:loadingView];
        
    } else
    {
        loadingView = [[MBProgressHUD alloc] initWithView:delegateViewController.view];
        [delegateViewController.view addSubview:loadingView];
        [delegateViewController.view bringSubviewToFront:loadingView];
    }
    
    // -- Show loading view --
    [loadingView showAnimated:YES];
    
}

+ (void)hideLoading:(id)delegateObj
{
    // -- Show loading view --
    [loadingView hideAnimated:YES];
    [loadingView removeFromSuperview];
    loadingView = nil;
}

#pragma mark -
#pragma mark Get height of text
#pragma mark -

+ (UIFont*)getFontSizeFixedWith:(UILabel*)aLabel andFont:(UIFont*)fontTemp withPadding:(float)padding
{
    // http://eureka.ykyuen.info/2010/07/03/iphone-wrap-text-in-uilabel/
    // Use :
    //	UIFont *aFont = [UIFont boldSystemFontOfSize:28.0];
    //	UIFont *aFont = [UIFont fontWithName:@"Helvetica" size:28.0];
    //	aLabel.font = [Utils getFontSizeFixedWith:aLabel andFont:aFont];
    
    NSString *aText = aLabel.text;
    
    UIFont* returnFont = nil;
    
    CGFloat maxFontSize = [aLabel.font pointSize];
    if (maxFontSize < 30.0)
        maxFontSize = 30.0;
    
    for (int i = maxFontSize; i > 8; i--)
    {
        UIFont *font = [UIFont fontWithName:fontTemp.fontName size:(CGFloat)i];
        NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:aText
                                                                             attributes:@{NSFontAttributeName: font}];
        
        CGRect rectSize = [attributedText boundingRectWithSize:CGSizeMake(aLabel.frame.size.width - (2 * padding), CGFLOAT_MAX)
                                                       options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        
        if (rectSize.size.height <= aLabel.frame.size.height) {
            returnFont = [UIFont fontWithName:aLabel.font.fontName size:(CGFloat)i];
            break;
        }
    }
    
    return returnFont;
}

+ (CGSize)sizeOfTextWithLabel:(UILabel *)lbl
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    //set the line break mode
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attrDict = [NSDictionary dictionaryWithObjectsAndKeys:lbl.font,
                              NSFontAttributeName,
                              paragraphStyle,
                              NSParagraphStyleAttributeName,
                              nil];
    //assume your maximumSize contains {255, MAXFLOAT}
    CGRect lblRect = [lbl.text boundingRectWithSize:(CGSize){lbl.frame.size.width, 9999}
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:attrDict
                                            context:nil];
    return lblRect.size;
}

+ (CGSize)heightOfText:(NSString *)text withMaxWidth:(float)width withFont:(UIFont *)font;
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    //set the line break mode
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attrDict = [NSDictionary dictionaryWithObjectsAndKeys:font,
                              NSFontAttributeName,
                              paragraphStyle,
                              NSParagraphStyleAttributeName,
                              nil];
    //assume your maximumSize contains {255, MAXFLOAT}
    CGRect lblRect = [text boundingRectWithSize:(CGSize){width, 9999}
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:attrDict
                                        context:nil];
    return lblRect.size;
}

+ (NSArray *)getListOfKey:(NSString *)key inArray:(NSArray *)list {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in list) {
        if(dict != nil) {
            [array addObject:[dict objectForKey:key]];
        }
        
    }
    return array;
}

+ (UIViewController *)getTopViewController
{
    UIViewController *topViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return topViewController;
}

// -- Dieu kien su dung la subView va toView co cung width, height -- 
+ (void)animationAddSubView:(UIView *)subView toView:(UIView *)toView completion:(void (^ __nullable)(BOOL finished))completion
{
    // -- Get top view controller -- 
    if (toView == nil) {
        UIViewController *topViewController = [DbUtils getTopViewController];
        toView = topViewController.view;
    }
    
    subView.frame = CGRectMake(0, -20, toView.frame.size.width, toView.frame.size.height);
    [subView layoutIfNeeded];
    [subView setAlpha:0.0];
    [toView addSubview:subView];
    
    [UIView animateWithDuration:0.35 animations:^{
        [subView setAlpha:1.0];
        subView.frame = CGRectMake(0, 0, toView.frame.size.width, toView.frame.size.height);
    } completion:^(BOOL finished) {
        if (completion)
            completion(finished);
    }];
}

+ (void)animationRemoveSubView:(UIView *)subView completion:(void (^ __nullable)(BOOL finished))completion
{
    [UIView animateWithDuration:0.35 animations:^{
        [subView setAlpha:0.0];
    } completion:^(BOOL finished) {
        [subView removeFromSuperview];
        if (completion)
            completion(finished);
    }];
}

#pragma mark -
#pragma mark Fix control
#pragma mark -

// -- Refer : https://stackoverflow.com/questions/19256996/uibutton-not-showing-highlight-on-tap-in-ios7/26049216 --
+ (void)fixHighlightButtonInTableCell:(UITableView *)tableView
{
    tableView.delaysContentTouches = NO;
    
    for (UIView *currentView in tableView.subviews) {
        if ([currentView isKindOfClass:[UIScrollView class]]) {
            ((UIScrollView *)currentView).delaysContentTouches = NO;
            break;
        }
    }
}


@end

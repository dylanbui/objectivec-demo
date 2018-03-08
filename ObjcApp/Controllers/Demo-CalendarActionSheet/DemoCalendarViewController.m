//
//  DemoCalendarViewController.m
//  ObjcApp
//
//  Created by Dylan Bui on 3/7/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import "DemoCalendarViewController.h"
#import "CalendarActionSheetViewController.h"
#import "CalendarView.h"

@interface DemoCalendarViewController ()

@end

@implementation DemoCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}



- (IBAction)btnShow_Click:(UIButton *)sender
{
    NSCalendar *gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    NSDate *tomorrow = [gregorian dateByAddingUnit:NSCalendarUnitDay value:1 toDate:[NSDate date] options:0];
    
    CalendarActionSheetViewController* picker = [CalendarActionSheetViewController datePicker];
    [picker setLocale:[NSLocale localeWithLocaleIdentifier:@"vi_VN"]];
    [picker setSelectionType:ASCalendarSelectionTypeMulti];
    picker.selectedDates = @[[NSDate date], tomorrow];
    
    picker.minimumDate = [dateFormatter dateFromString:@"2018-01-08"];
    picker.maximumDate = [gregorian dateByAddingUnit:NSCalendarUnitMonth value:5 toDate:[NSDate date] options:0];
    
    picker.singleChooseAction = ^(NSDate *selectedDate) {
        NSLog(@"single = %@", [DbUtils stringFromDate:selectedDate withFormat:FULL_FORMAT_DATE]);
    };
    picker.multiChooseAction = ^(NSArray<NSDate *> *selectedDates) {
        for (NSDate *date in selectedDates) {
            NSLog(@"multi = %@", [DbUtils stringFromDate:date withFormat:FULL_FORMAT_DATE]);
        }
    };
    
//    [self presentSemiViewControllerDefaultPickerOption:picker];
    NSDictionary *option;
    if (sender.tag == 1) {
        option = @{
                   KNSemiModalOptionKeys.pushParentBack    : @(NO),
                   KNSemiModalOptionKeys.animationDuration : @(1.0),
                   KNSemiModalOptionKeys.shadowOpacity     : @(0.3),
                   KNSemiModalOptionKeys.transitionStyle : @(KNSemiModalTransitionStyleSlideUp),
                   KNSemiModalOptionKeys.position : @(KNSemiModalPositionBottom),
                   };
    } else if (sender.tag == 2) {
        option = @{
                   KNSemiModalOptionKeys.pushParentBack    : @(NO),
                   KNSemiModalOptionKeys.animationDuration : @(1.0),
                   KNSemiModalOptionKeys.shadowOpacity     : @(0.3),
                   KNSemiModalOptionKeys.transitionStyle : @(KNSemiModalTransitionStyleSlideDown),
                   KNSemiModalOptionKeys.position : @(KNSemiModalPositionTop),
                   };
    } else if (sender.tag == 3) {
        option = @{
                   KNSemiModalOptionKeys.pushParentBack    : @(NO),
                   KNSemiModalOptionKeys.animationDuration : @(1.0),
                   KNSemiModalOptionKeys.shadowOpacity     : @(0.3),
                   KNSemiModalOptionKeys.transitionStyle : @(KNSemiModalTransitionStyleSlideUp),
                   KNSemiModalOptionKeys.position : @(KNSemiModalPositionCenter),
                   };
    } else if (sender.tag == 4) {
        option = @{
                   KNSemiModalOptionKeys.pushParentBack    : @(NO),
                   KNSemiModalOptionKeys.animationDuration : @(1.0),
                   KNSemiModalOptionKeys.shadowOpacity     : @(0.3),
                   KNSemiModalOptionKeys.transitionStyle : @(KNSemiModalTransitionStyleFadeInOut),
                   KNSemiModalOptionKeys.position : @(KNSemiModalPositionCenter),
                   };
    } else if (sender.tag == 5) {
        option = @{
                   KNSemiModalOptionKeys.pushParentBack    : @(NO),
                   KNSemiModalOptionKeys.animationDuration : @(1.0),
                   KNSemiModalOptionKeys.shadowOpacity     : @(0.3),
                   KNSemiModalOptionKeys.transitionStyle : @(KNSemiModalTransitionStyleSlideSmallDown),
                   KNSemiModalOptionKeys.position : @(KNSemiModalPositionCenter),
                   };
    }
    
    //[self presentSemiViewController:picker withOptions:option];
    
    CalendarView *calView = [[CalendarView alloc] init];
    [self presentSemiView:calView withOptions:option];
    
    
//    [self presentSemiViewController:picker withOptions:@{
//                                                     KNSemiModalOptionKeys.pushParentBack    : @(YES),
//                                                     KNSemiModalOptionKeys.animationDuration : @(1.0),
//                                                     KNSemiModalOptionKeys.shadowOpacity     : @(0.3),
//                                                     KNSemiModalOptionKeys.transitionStyle : @(KNSemiModalTransitionStyleSlideSmallDown),
//                                                     KNSemiModalOptionKeys.position : @(KNSemiModalPositionBottom),
//                                                     }];

    
    
    
//    [[self kn_targetToStoreValues] ym_registerOptions:options defaults:@{
//                                                                         KNSemiModalOptionKeys.traverseParentHierarchy : @(YES),
//                                                                         KNSemiModalOptionKeys.pushParentBack : @(YES),
//                                                                         KNSemiModalOptionKeys.animationDuration : @(0.5),
//                                                                         KNSemiModalOptionKeys.parentAlpha : @(0.5),
//                                                                         KNSemiModalOptionKeys.parentScale : @(0.8),
//                                                                         KNSemiModalOptionKeys.shadowOpacity : @(0.8),
//                                                                         KNSemiModalOptionKeys.transitionStyle : @(KNSemiModalTransitionStyleSlideUp),
//                                                                         KNSemiModalOptionKeys.disableCancel : @(NO),
//                                                                         }];
    
    
    
}



@end

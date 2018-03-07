//
//  CalendarActionSheetViewController.h
//  ObjcApp
//
//  Created by Dylan Bui on 3/7/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIViewController+KNSemiModal.h"
#import "FSCalendar.h"

typedef void (^ asCalendarMultiChoose)(NSArray<NSDate *> *selectedDates);
typedef void (^ asCalendarSingleChoose)(NSDate *selectedDate);
typedef void (^ asCalendarCancel)(void);

typedef NS_ENUM(NSInteger, ASCalendarSelectionType) {
    ASCalendarSelectionTypeSingle,
    ASCalendarSelectionTypeMulti,
    ASCalendarSelectionTypeRange
};


@interface CalendarActionSheetViewController : UIViewController

@property (weak, nonatomic) IBOutlet FSCalendar *fsCalendar;

@property (weak, nonatomic) IBOutlet UIButton *btnClose;
@property (weak, nonatomic) IBOutlet UIButton *btnDone;
@property (weak, nonatomic) IBOutlet UIButton *btnToday;

@property (nonatomic, getter=isShowToday) BOOL showToday;
@property (nonatomic, strong) NSArray<NSDate *> *selectedDates;

@property (nonatomic) asCalendarMultiChoose multiChooseAction;
@property (nonatomic) asCalendarSingleChoose singleChooseAction;
@property (nonatomic) asCalendarCancel cancelAction;

/**
 A date object representing the minimum day enable、visible and selectable.
 */
@property (nonatomic, strong) NSDate *minimumDate;

/**
 A date object representing the maximum day enable、visible and selectable.
 */
@property (nonatomic, strong) NSDate *maximumDate;

- (void)setSelectionType:(ASCalendarSelectionType)type;

- (void)setLocale:(NSLocale *)locale;


/*! Should the view be closed on selection of a date
 * \param autoClose should close view on selection
 */
- (void)setAutoCloseOnSelectDate:(BOOL)autoClose;


+ (CalendarActionSheetViewController *)datePicker;

@end

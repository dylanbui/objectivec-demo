//
//  CalendarActionSheetViewController.m
//  ObjcApp
//
//  Created by Dylan Bui on 3/7/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import "CalendarActionSheetViewController.h"

@interface CalendarActionSheetViewController () <FSCalendarDataSource, FSCalendarDelegate> {
    ASCalendarSelectionType _selectionType;
    BOOL _autoCloseOnSelectDate;
    NSLocale *_locale;
}

@end

@implementation CalendarActionSheetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _selectionType = ASCalendarSelectionTypeSingle;
        _autoCloseOnSelectDate = NO;
        _showToday = YES;
        _selectedDates = @[];
    }
    return self;
}

+ (CalendarActionSheetViewController *)datePicker
{
    return [[CalendarActionSheetViewController alloc] initWithNibName:@"CalendarActionSheetViewController" bundle:[NSBundle bundleForClass:self.class]];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (_locale) {
        self.fsCalendar.locale = _locale;
    }
    
    if (_selectionType == ASCalendarSelectionTypeSingle){
        self.fsCalendar.allowsMultipleSelection = NO;
    } else {
        self.fsCalendar.allowsMultipleSelection = YES;
    }
    
    if (!self.showToday)
        self.fsCalendar.today = nil;
    
    // Do any additional setup after loading the view from its nib.
    for (NSDate *date in self.selectedDates) {
        [self.fsCalendar selectDate:date scrollToDate:NO];
    }
    
    if (self.fsCalendar.delegate == nil)
        self.fsCalendar.delegate = self;
    
    if (self.fsCalendar.dataSource == nil)
        self.fsCalendar.dataSource = self;
    
    [self.fsCalendar reloadData];
}


- (IBAction)btnClose_Click:(id)sender
{
    NSLog(@"%@", @"CLose");
    // -- Close --
    [self dismissSemiModalView];
}

- (IBAction)btnDone_Click:(id)sender
{
    NSLog(@"%@", @"Done");
    // -- Close --
    [self dismissSemiModalView];

    if (_selectionType == ASCalendarSelectionTypeSingle) {
        if (self.singleChooseAction) {
            self.singleChooseAction(self.fsCalendar.selectedDate);
        }
    } else {
        if (self.multiChooseAction) {
            self.multiChooseAction(self.fsCalendar.selectedDates);
        }
    }
}

- (IBAction)btnToday_Click:(id)sender
{
    NSLog(@"%@", @"Today");
    [self.fsCalendar setCurrentPage:[NSDate date] animated:YES];
}

- (void)setSelectionType:(ASCalendarSelectionType)type
{
    _selectionType = type;
}

- (void)setAutoCloseOnSelectDate:(BOOL)autoClose
{
    _autoCloseOnSelectDate = autoClose;
    if (_autoCloseOnSelectDate && _selectionType != ASCalendarSelectionTypeSingle){
        _selectionType = ASCalendarSelectionTypeSingle;
    }
}

- (void)setLocale:(NSLocale *)locale
{
    _locale = locale;
}

#pragma mark - FSCalendarDataSource

- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar
{
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    dateFormatter.dateFormat = @"yyyy-MM-dd";
//    return [dateFormatter dateFromString:@"2017-07-08"];
    return self.minimumDate;
}

- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar
{
//    NSCalendar *gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
//     return [gregorian dateByAddingUnit:NSCalendarUnitMonth value:5 toDate:[NSDate date] options:0];
    return self.maximumDate;
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
//    NSLog(@"did select date %@",[self.dateFormatter stringFromDate:date]);
    if (_autoCloseOnSelectDate && _selectionType == ASCalendarSelectionTypeSingle) {
        // -- Close --
        [self dismissSemiModalView];
        if (self.singleChooseAction) {
            self.singleChooseAction(date);
        }
    }
}

@end

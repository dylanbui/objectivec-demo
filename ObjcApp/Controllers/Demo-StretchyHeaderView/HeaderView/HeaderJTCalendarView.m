//
//  HeaderJTCalendarView.m
//  ObjcApp
//
//  Created by Dylan Bui on 10/20/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "HeaderJTCalendarView.h"
#import <JTCalendar/JTCalendar.h>
#import "Constant.h"
#import "DbConstant.h"
#import <Masonry/Masonry.h>
#import "UIView+GSKLayoutHelper.h"

@interface HeaderJTCalendarView() <JTCalendarDelegate> {
    
    NSDate *_dateSelected;
}

@property (nonatomic) JTCalendarManager *calMonthManager;
@property (nonatomic) JTHorizontalCalendarView *calMonthContentView;

@property (nonatomic) JTCalendarManager *calWeekManager;
@property (nonatomic) JTHorizontalCalendarView *calWeekContentView;

@end


@implementation HeaderJTCalendarView

- (instancetype)initWithFrame:(CGRect)frame withController:(id)viewController
{
    self = [super initWithFrame:frame];
    if (self) {
        self.viewController = (STCalendarHeaderViewController *) viewController;
        
//        self.minimumContentHeight = 64 + 64 + 50 - 15;
        //self.minimumContentHeight = 64 + 50 + 30; // nav + menuview + weekday
        self.minimumContentHeight = 64 + 55 + 50; // nav + menuview + weekday
        // -- Phai set background color --
        self.backgroundColor = [UIColor whiteColor];
        [self setupImageView];
    }
    return self;
}

//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        self.minimumContentHeight = 64 + 64 + 55 + 15;
////        self.minimumContentHeight = 64 + 64 + 55;
////        self.minimumContentHeight = 64;
//        // -- Phai set background color --
//        self.backgroundColor = [UIColor whiteColor];
//        [self setupImageView];
////        [self setupViewConstraints];
//    }
//    return self;
//}

- (void)setupImageView
{
    // -- Week --
    self.calWeekContentView = [[JTHorizontalCalendarView alloc] init];
//    [self.calWeekContentView setFrame:CGRectMake(0, 64 + 55, SCREEN_WIDTH, 85)];
    [self.calWeekContentView setFrame:CGRectMake(0, 64 + 55, SCREEN_WIDTH, 50)];
    self.calWeekContentView.alpha = 0;
    // [self.contentView addSubview:self.calWeekContentView];
    self.calWeekContentView.backgroundColor = [UIColor yellowColor];
//    [self.viewController.view addSubview:self.calWeekContentView];
    [self.viewController.view insertSubview:self.calWeekContentView
                               belowSubview:self.viewController.calMenuView];

    self.calWeekManager = [JTCalendarManager new];
    self.calWeekManager.delegate = self;
    self.calWeekManager.settings.weekModeEnabled = YES;
    
    self.calWeekManager.settings.weekDayFormat = JTCalendarWeekDayFormatSingle;
    self.calWeekManager.settings.pageViewHaveWeekDaysView = NO;
    
    [self.calWeekManager setContentView:self.calWeekContentView];
    [self.calWeekManager setDate:[NSDate date]];
    
    // -- Month --
    self.calMonthContentView = [[JTHorizontalCalendarView alloc] init];
    [self.calMonthContentView setFrame:CGRectMake(0, 64 + 55, SCREEN_WIDTH, 270)];
    self.calMonthContentView.backgroundColor = [UIColor magentaColor];
    [self.contentView addSubview:self.calMonthContentView];
    
    self.calMonthManager = [JTCalendarManager new];
    self.calMonthManager.delegate = self;
    self.calMonthManager.settings.weekDayFormat = JTCalendarWeekDayFormatSingle;
    self.calMonthManager.settings.pageViewHaveWeekDaysView = NO;
    
    
    [self.calMonthManager setContentView:self.calMonthContentView];

    // --  --
    
    self.viewController.calMenuView.contentRatio = .75;
    
    [self.calMonthManager setMenuView:self.viewController.calMenuView];
    [self.calMonthManager setDate:[NSDate date]];
    
    [self.calWeekManager setMenuView:self.viewController.calMenuView];
    [self.calWeekManager setDate:[NSDate date]];

}

//- (void)setupViewConstraints
//{
//    [self.calendarContentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(@64);
//        make.left.equalTo(@0);
//        make.width.equalTo(self.contentView.mas_width);
//        make.height.equalTo(self.contentView.mas_height);
//    }];
//
//}

- (void)didChangeStretchFactor:(CGFloat)stretchFactor
{
    [super didChangeStretchFactor:stretchFactor];
    CGFloat limitedStretchFactor = MIN(1, stretchFactor);

    self.calMonthContentView.alpha = limitedStretchFactor;
    self.calWeekContentView.alpha = 1 - limitedStretchFactor;
    
    CGPoint startCalWeekOrigin = CGPointMake(0, 64 + 55 - 50);
    CGPoint endCalWeekOrigin = CGPointMake(0, 64 + 55);
    
    self.calWeekContentView.left = CGFloatInterpolate(limitedStretchFactor, endCalWeekOrigin.x, startCalWeekOrigin.x);
    self.calWeekContentView.top = CGFloatInterpolate(stretchFactor, endCalWeekOrigin.y, startCalWeekOrigin.y);
    
    CGPoint minCalMonthOrigin = CGPointMake(0, 64 + 55 - 270 + 55);
    CGPoint maxCalMonthOrigin = CGPointMake(0, 64 + 55);
    
    self.calMonthContentView.left = CGFloatInterpolate(limitedStretchFactor, minCalMonthOrigin.x, maxCalMonthOrigin.x);
    self.calMonthContentView.top = CGFloatInterpolate(stretchFactor, minCalMonthOrigin.y, maxCalMonthOrigin.y);
    
    // NSLog(@"limitedStretchFactor = %f", limitedStretchFactor);
//
//    CGSize minImageSize = CGSizeMake(32, 32);
//    CGSize maxImageSize = CGSizeMake(96, 96);
//    //    CGPoint minImageOrigin = CGPointMake(96, 24);
//    CGPoint minImageOrigin = CGPointMake(35, 24);
//    CGPoint maxImageOrigin = CGPointMake((self.contentView.width - maxImageSize.width) / 2, 32);
//
//    self.imageView.size = CGSizeInterpolate(limitedStretchFactor, minImageSize, maxImageSize);
//    self.imageView.left = CGFloatInterpolate(limitedStretchFactor, minImageOrigin.x, maxImageOrigin.x);
//    self.imageView.top = CGFloatInterpolate(stretchFactor, minImageOrigin.y, maxImageOrigin.y);
//
//    if (stretchFactor < 1) {
//        self.button.top = CGFloatInterpolate(stretchFactor,
//                                             self.imageView.centerY - self.button.height / 2,
//                                             self.imageView.bottom + 4);
//    } else {
//        self.button.top = self.imageView.bottom + 4;
//    }
//
//    self.button.left = CGFloatInterpolate(limitedStretchFactor,
//                                          minImageOrigin.x + minImageSize.width + 8,
//                                          self.contentView.width / 2 - self.button.width / 2);
}

#pragma mark - CalendarManager delegate

// Exemple of implementation of prepareDayView method
// Used to customize the appearance of dayView
- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(JTCalendarDayView *)dayView
{
//    if (calendar == self.calWeekManager) {
//        // Today
//        if([self.calWeekManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]){
//            dayView.circleView.hidden = NO;
//            dayView.circleView.backgroundColor = [UIColor blueColor];
//            dayView.dotView.backgroundColor = [UIColor whiteColor];
//            dayView.textLabel.textColor = [UIColor whiteColor];
//        }
//        // Selected date
//        else if(_dateSelected && [self.calWeekManager.dateHelper date:_dateSelected isTheSameDayThan:dayView.date]){
//            dayView.circleView.hidden = NO;
//            dayView.circleView.backgroundColor = [UIColor redColor];
//            dayView.dotView.backgroundColor = [UIColor whiteColor];
//            dayView.textLabel.textColor = [UIColor whiteColor];
//        }
//        // Other month
//        else if(![self.calWeekManager.dateHelper date:self.calWeekContentView.date isTheSameMonthThan:dayView.date]){
//            dayView.circleView.hidden = YES;
//            dayView.dotView.backgroundColor = [UIColor redColor];
//            dayView.textLabel.textColor = [UIColor lightGrayColor];
//        }
//
//        return;
//    }
    
    // Today
    if([calendar.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor blueColor];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Selected date
    else if(_dateSelected && [calendar.dateHelper date:_dateSelected isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor redColor];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Other month
    else if(![calendar.dateHelper date:calendar.date isTheSameMonthThan:dayView.date]){
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor lightGrayColor];
    }
    // Another day of the current month
    else{
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor blackColor];
    }
    
    dayView.dotView.hidden = YES;
//    if([self haveEventForDay:dayView.date]){
//        dayView.dotView.hidden = NO;
//    }
//    else{
//        dayView.dotView.hidden = YES;
//    }
}

- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView
{
    _dateSelected = dayView.date;
    
    [self.calMonthManager setDate:_dateSelected];
    [self.calWeekManager setDate:_dateSelected];
    
    // Animation for the circleView
    dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
    [UIView transitionWithView:dayView
                      duration:.3
                       options:0
                    animations:^{
                        dayView.circleView.transform = CGAffineTransformIdentity;
                        [self.calMonthManager reload];
                        [self.calWeekManager reload];
                    } completion:nil];
    
    
    // Don't change page in week mode because block the selection of days in first and last weeks of the month
//    if(self.calMonthManager.settings.weekModeEnabled){
//        return;
//    }
    
    // Load the previous or next page if touch a day from another month
    
//    if(![self.calMonthManager.dateHelper date:self.calMonthContentView.date isTheSameMonthThan:dayView.date]){
//        if([self.calMonthContentView.date compare:dayView.date] == NSOrderedAscending){
//            [self.calMonthContentView loadNextPageWithAnimation];
//        }
//        else{
//            [self.calMonthContentView loadPreviousPageWithAnimation];
//        }
//    }
}

#pragma mark - CalendarManager delegate - Page mangement

//// Used to limit the date for the calendar, optional
//- (BOOL)calendar:(JTCalendarManager *)calendar canDisplayPageWithDate:(NSDate *)date
//{
//    return NO; //[_calendarManager.dateHelper date:date isEqualOrAfter:_minDate andEqualOrBefore:_maxDate];
//}
//
//- (void)calendarDidLoadNextPage:(JTCalendarManager *)calendar
//{
//    //    NSLog(@"Next page loaded");
//}
//
//- (void)calendarDidLoadPreviousPage:(JTCalendarManager *)calendar
//{
//    //    NSLog(@"Previous page loaded");
//}

#pragma mark - Views customization

- (void)calendar:(JTCalendarManager *)calendar prepareMenuItemView:(UILabel *)menuItemView date:(NSDate *)date
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"dd,MMMM yyyy";
        
        dateFormatter.locale = calendar.dateHelper.calendar.locale;
        dateFormatter.timeZone = calendar.dateHelper.calendar.timeZone;
    }
    
    menuItemView.text = [dateFormatter stringFromDate:date];
}


@end

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

@interface HeaderJTCalendarView() <JTCalendarDelegate> {
    
    NSDate *_dateSelected;
}

@property (nonatomic) JTCalendarManager *calendarManager;
@property (nonatomic) JTHorizontalCalendarView *calendarContentView;

@property (nonatomic) JTCalendarManager *calendarDayManager;
@property (nonatomic) JTHorizontalCalendarView *calendarDayContentView;

@end


@implementation HeaderJTCalendarView

- (instancetype)initWithFrame:(CGRect)frame withController:(id)viewController
{
    self = [super initWithFrame:frame];
    if (self) {
        self.viewController = (STCalendarHeaderViewController *) viewController;
        
        self.minimumContentHeight = 64 + 64 + 55 + 15;
        // -- Phai set background color --
        self.backgroundColor = [UIColor whiteColor];
        [self setupImageView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.minimumContentHeight = 64 + 64 + 55 + 15;
//        self.minimumContentHeight = 64;
        // -- Phai set background color --
        self.backgroundColor = [UIColor whiteColor];
        [self setupImageView];
//        [self setupViewConstraints];
    }
    return self;
}

- (void)setupImageView
{
    // -- Dayyyyy --
    self.calendarDayContentView = [[JTHorizontalCalendarView alloc] init];
    [self.calendarDayContentView setFrame:CGRectMake(0, 64 + 55, SCREEN_WIDTH, 85)];
    self.calendarDayContentView.alpha = 0;
    // [self.contentView addSubview:self.calendarDayContentView];
    self.calendarDayContentView.backgroundColor = [UIColor whiteColor];
    [self.viewController.view addSubview:self.calendarDayContentView];

    self.calendarDayManager = [JTCalendarManager new];
    self.calendarDayManager.delegate = self;
    self.calendarDayManager.settings.weekModeEnabled = YES;
    [self.calendarDayManager setContentView:self.calendarDayContentView];
    [self.calendarDayManager setDate:[NSDate date]];
    
    // -- -------------------------- --
    
    self.calendarContentView = [[JTHorizontalCalendarView alloc] init];
    [self.calendarContentView setFrame:CGRectMake(0, 64 + 55, SCREEN_WIDTH, 300)];
    [self.contentView addSubview:self.calendarContentView];
    
    self.calendarManager = [JTCalendarManager new];
    self.calendarManager.delegate = self;
    [self.calendarManager setContentView:self.calendarContentView];
    [self.calendarManager setDate:[NSDate date]];
    
    [self.calendarManager setMenuView:self.viewController.cldMenuView];
    [self.calendarDayManager setMenuView:self.viewController.cldMenuView];
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
    
    self.calendarContentView.alpha = limitedStretchFactor;
    self.calendarDayContentView.alpha = 1 - limitedStretchFactor;
    
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
    if (calendar == self.calendarDayManager) {
        // Today
        if([self.calendarDayManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]){
            dayView.circleView.hidden = NO;
            dayView.circleView.backgroundColor = [UIColor blueColor];
            dayView.dotView.backgroundColor = [UIColor whiteColor];
            dayView.textLabel.textColor = [UIColor whiteColor];
        }
        // Selected date
        else if(_dateSelected && [self.calendarDayManager.dateHelper date:_dateSelected isTheSameDayThan:dayView.date]){
            dayView.circleView.hidden = NO;
            dayView.circleView.backgroundColor = [UIColor redColor];
            dayView.dotView.backgroundColor = [UIColor whiteColor];
            dayView.textLabel.textColor = [UIColor whiteColor];
        }
        // Other month
        else if(![self.calendarDayManager.dateHelper date:self.calendarDayContentView.date isTheSameMonthThan:dayView.date]){
            dayView.circleView.hidden = YES;
            dayView.dotView.backgroundColor = [UIColor redColor];
            dayView.textLabel.textColor = [UIColor lightGrayColor];
        }

        return;
    }
    
    // Today
    if([_calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor blueColor];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Selected date
    else if(_dateSelected && [_calendarManager.dateHelper date:_dateSelected isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor redColor];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Other month
    else if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
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
    
    // Animation for the circleView
    dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
    [UIView transitionWithView:dayView
                      duration:.3
                       options:0
                    animations:^{
                        dayView.circleView.transform = CGAffineTransformIdentity;
                        [self.calendarManager reload];
                        [self.calendarDayManager reload];                        
                    } completion:nil];
    
    
    // Don't change page in week mode because block the selection of days in first and last weeks of the month
    if(self.calendarManager.settings.weekModeEnabled){
        return;
    }
    
    // Load the previous or next page if touch a day from another month
    
    if(![self.calendarManager.dateHelper date:self.calendarContentView.date isTheSameMonthThan:dayView.date]){
        if([self.calendarContentView.date compare:dayView.date] == NSOrderedAscending){
            [self.calendarContentView loadNextPageWithAnimation];
        }
        else{
            [self.calendarContentView loadPreviousPageWithAnimation];
        }
    }
}

#pragma mark - CalendarManager delegate - Page mangement

// Used to limit the date for the calendar, optional
- (BOOL)calendar:(JTCalendarManager *)calendar canDisplayPageWithDate:(NSDate *)date
{
    return NO; //[_calendarManager.dateHelper date:date isEqualOrAfter:_minDate andEqualOrBefore:_maxDate];
}

- (void)calendarDidLoadNextPage:(JTCalendarManager *)calendar
{
    //    NSLog(@"Next page loaded");
}

- (void)calendarDidLoadPreviousPage:(JTCalendarManager *)calendar
{
    //    NSLog(@"Previous page loaded");
}

@end

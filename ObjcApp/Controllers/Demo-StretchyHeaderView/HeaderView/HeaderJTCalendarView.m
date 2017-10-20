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

@interface HeaderJTCalendarView()

@property (nonatomic) JTCalendarManager *calendarManager;
@property (nonatomic) JTHorizontalCalendarView *calendarContentView;

@property (nonatomic) JTCalendarManager *calendarDayManager;
@property (nonatomic) JTHorizontalCalendarView *calendarDayContentView;

@end


@implementation HeaderJTCalendarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.minimumContentHeight = 128 + 15;
        // -- Phai set background color --
        self.backgroundColor = [UIColor whiteColor];
        [self setupImageView];
    }
    return self;
}

- (void)setupImageView
{
    // -- Dayyyyy --
    self.calendarDayContentView = [[JTHorizontalCalendarView alloc] init];
    [self.calendarDayContentView setFrame:CGRectMake(0, 64, SCREEN_WIDTH, 85)];
    self.calendarDayContentView.alpha = 0;
    [self.contentView addSubview:self.calendarDayContentView];

    self.calendarDayManager = [JTCalendarManager new];
    // self.calendarManager.delegate = self;
    self.calendarDayManager.settings.weekModeEnabled = YES;
    [self.calendarDayManager setContentView:self.calendarDayContentView];
    [self.calendarDayManager setDate:[NSDate date]];
    
    // -- -------------------------- --
    
    self.calendarContentView = [[JTHorizontalCalendarView alloc] init];
    [self.calendarContentView setFrame:CGRectMake(0, 64, SCREEN_WIDTH, 300)];
    [self.contentView addSubview:self.calendarContentView];
    
    self.calendarManager = [JTCalendarManager new];
    // self.calendarManager.delegate = self;
    [self.calendarManager setContentView:self.calendarContentView];
    [self.calendarManager setDate:[NSDate date]];
}

- (void)didChangeStretchFactor:(CGFloat)stretchFactor
{
    [super didChangeStretchFactor:stretchFactor];
    CGFloat limitedStretchFactor = MIN(1, stretchFactor);
    
    self.calendarContentView.alpha = limitedStretchFactor;
    self.calendarDayContentView.alpha = 1 - limitedStretchFactor;
    
    NSLog(@"limitedStretchFactor = %f", limitedStretchFactor);
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

- (void)didTapButton:(id)sender
{
    NSLog(@"tap!");
}


@end

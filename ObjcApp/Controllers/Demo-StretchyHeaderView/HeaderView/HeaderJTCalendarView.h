//
//  HeaderJTCalendarView.h
//  ObjcApp
//
//  Created by Dylan Bui on 10/20/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STCalendarHeaderViewController.h"
@import GSKStretchyHeaderView;

@interface HeaderJTCalendarView : GSKStretchyHeaderView

@property (nonatomic, weak) STCalendarHeaderViewController *viewController;

- (instancetype)initWithFrame:(CGRect)frame withController:(id)viewController;

@end

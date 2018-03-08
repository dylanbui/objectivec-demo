//
//  CalendarView.h
//  ObjcApp
//
//  Created by Dylan Bui on 3/8/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import "DbViewFromXib.h"
#import "FSCalendar.h"

@interface CalendarView : DbViewFromXib

@property (nonatomic, weak) IBOutlet FSCalendar *fsCalendar;

@end

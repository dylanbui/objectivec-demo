//
//  STCalendarHeaderViewController.h
//  ObjcApp
//
//  Created by Dylan Bui on 10/20/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DbViewController.h"
#import "GSKStretchyHeaderView.h"
#import <JTCalendar/JTCalendar.h>

@interface STCalendarHeaderViewController : DbViewController

@property (weak, nonatomic) IBOutlet JTCalendarMenuView *cldMenuView;

@property (nonatomic, readonly) GSKStretchyHeaderView *stretchyHeaderView;

- (GSKStretchyHeaderView *)loadStretchyHeaderView;

@end

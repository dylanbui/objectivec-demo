//
//  STMapHeaderViewController.h
//  ObjcApp
//
//  Created by Dylan Bui on 12/12/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "DbViewController.h"
#import "GSKStretchyHeaderView.h"

@interface STMapHeaderViewController : DbViewController

@property (nonatomic, readonly) GSKStretchyHeaderView *stretchyHeaderView;

@property (nonatomic, strong) UIRefreshControl *refreshControl;


- (GSKStretchyHeaderView *)loadStretchyHeaderView;


@end

//
//  STHeaderViewController.h
//  ObjcApp
//
//  Created by Dylan Bui on 10/2/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DbViewController.h"
#import "GSKStretchyHeaderView.h"

@interface STHeaderViewController : DbViewController

@property (nonatomic, readonly) GSKStretchyHeaderView *stretchyHeaderView;

- (GSKStretchyHeaderView *)loadStretchyHeaderView;

@end

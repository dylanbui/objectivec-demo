//
//  TaskTableViewHeader.h
//  PropzyPama
//
//  Created by Dylan Bui on 8/28/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "DbViewFromXib.h"
#import "Constant.h"
#import "DbUtils.h"

@interface TaskTableViewHeader : DbViewFromXib

@property (weak, nonatomic) IBOutlet UIView *vwSegment;
@property (weak, nonatomic) IBOutlet UIButton *btnToday;
@property (weak, nonatomic) IBOutlet UIButton *btnFuture;

@end

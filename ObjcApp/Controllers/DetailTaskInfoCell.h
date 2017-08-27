//
//  DetailTaskInfoCell.h
//  ObjcApp
//
//  Created by Dylan Bui on 8/27/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "DbTableViewCell.h"

@interface DetailTaskInfoCell : DbTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblTaskName;
@property (weak, nonatomic) IBOutlet UILabel *lblLocation;
@property (weak, nonatomic) IBOutlet UILabel *lblStartTime;
@property (weak, nonatomic) IBOutlet UILabel *lblEndTime;

@end

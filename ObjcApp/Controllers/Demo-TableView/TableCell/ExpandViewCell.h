//
//  ExpandViewCell.h
//  ObjcApp
//
//  Created by Dylan Bui on 8/26/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "DbTableViewCell.h"

@interface ExpandViewCell : DbTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *txtTitle;
@property (weak, nonatomic) IBOutlet UILabel *txtName;
@property (weak, nonatomic) IBOutlet UILabel *txtStatus;


@end

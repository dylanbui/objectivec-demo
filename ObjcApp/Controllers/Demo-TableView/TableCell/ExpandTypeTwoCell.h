//
//  ExpandTypeTwoCell.h
//  ObjcApp
//
//  Created by Dylan Bui on 8/27/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "DbTableViewCell.h"

@interface ExpandTypeTwoCell : DbTableViewCell

@property (weak, nonatomic) IBOutlet UIView *vwContent;
@property (weak, nonatomic) IBOutlet UIView *vwGroup;


@property (weak, nonatomic) IBOutlet UILabel *txtTitle;
@property (weak, nonatomic) IBOutlet UILabel *txtName;
@property (weak, nonatomic) IBOutlet UILabel *txtStatus;

@end

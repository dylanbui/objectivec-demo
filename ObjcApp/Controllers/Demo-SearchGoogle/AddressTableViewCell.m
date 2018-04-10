//
//  AddressTableViewCell.m
//  ObjcApp
//
//  Created by Dylan Bui on 4/9/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import "AddressTableViewCell.h"

@implementation AddressTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
    NSLog(@"%@", @"Tao AddressTableViewCell");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

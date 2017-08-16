//
//  BaseTableViewCell.m
//  PropzyTenant
//
//  Created by Dylan Bui on 6/9/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "DbTableViewCell.h"

@implementation DbTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)reloadCellData:(NSDictionary *)cellData
{
    self.dictCellData = cellData;
}

@end

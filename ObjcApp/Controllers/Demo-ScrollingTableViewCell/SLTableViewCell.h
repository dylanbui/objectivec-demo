//
//  SLTableViewCell.h
//  ObjcApp
//
//  Created by Dylan Bui on 10/10/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "DbTableViewCell.h"

@interface SLTableViewCell : DbTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *parallaxImage;

- (void)cellOnTableView:(UITableView *)tableView didScrollOnView:(UIView *)view;

- (void)cellOnTableView:(UITableView *)tableView didScrollOnView:(UIView *)view withOffset:(double)offset;


@end

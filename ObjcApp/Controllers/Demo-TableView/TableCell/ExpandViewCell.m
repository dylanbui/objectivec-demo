//
//  ExpandViewCell.m
//  ObjcApp
//
//  Created by Dylan Bui on 8/26/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "ExpandViewCell.h"

@implementation ExpandViewCell


- (void)reloadCellData:(NSDictionary *)cellData
{
    [super reloadCellData:cellData];

    self.txtTitle.text = [cellData objectForKey:@"name"];
    self.txtName.text = [cellData objectForKey:@"bio"];
    
    int count = [[cellData objectForKey:@"image"] intValue];
    if (count % 2 == 0) {
        self.txtStatus.text = @"";
    } else {
        self.txtStatus.text = [NSString stringWithFormat:@"So hinh anh = %d", count];
    }

    [self.contentView layoutIfNeeded];
    NSLog(@"self.contentView.frame = %@", NSStringFromCGRect(self.contentView.frame));
}


@end

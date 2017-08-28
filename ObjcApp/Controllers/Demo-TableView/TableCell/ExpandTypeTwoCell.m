//
//  ExpandTypeTwoCell.m
//  ObjcApp
//
//  Created by Dylan Bui on 8/27/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "ExpandTypeTwoCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation ExpandTypeTwoCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // Initialization code
    
    
    
    
}



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
    
    //[self.contentView layoutIfNeeded];
    // NSLog(@"self.contentView.frame = %@", NSStringFromCGRect(self.contentView.frame));
    
    // border radius
    [self.vwContent.layer setCornerRadius:5.0f];
    
    // border
    [self.vwContent.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.vwContent.layer setBorderWidth:0.5f];
    
    // drop shadow
    [self.vwContent.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.vwContent.layer setShadowOpacity:0.2];
    [self.vwContent.layer setShadowRadius:2.0];
    [self.vwContent.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    [self.vwContent.layer setShadowOffset:CGSizeMake(0, 0)];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    self.vwContent.layer.shadowColor = [UIColor.blackColor CGColor]; //color.CGColor;
//    self.vwContent.layer.shadowOffset = CGSizeMake(0, 2);
//    self.vwContent.layer.shadowRadius = 1.0;
//    self.vwContent.layer.shadowOpacity = 0.8;
    
    
    

}


@end

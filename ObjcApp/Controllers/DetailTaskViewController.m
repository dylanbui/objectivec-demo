//
//  DetailTaskViewController.m
//  ObjcApp
//
//  Created by Dylan Bui on 8/27/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "DetailTaskViewController.h"
#import "ExpandTypeTwoCell.h"

#import "DetailTaskInfoCell.h"
#import "DetailTaskContactInfoCell.h"
#import "DetailTaskFeeCell.h"

@interface DetailTaskViewController ()

@end

@implementation DetailTaskViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"Detail Task";
    
//    self.tblContent.rowHeight = UITableViewAutomaticDimension;    
//    self.tblContent.estimatedRowHeight = 90; // TypeOne
    //self.tblContent.estimatedRowHeight = 85; // TypeTwo
    //    self.tblContent.rowHeight = 44;

}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // So dong trong moi section
    return 3;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        DetailTaskInfoCell *cell = (DetailTaskInfoCell *)[tableView dequeueReusableCellWithIdentifier:@"detailTaskInfoCell"];
        if (cell == nil)
            cell = [[[NSBundle mainBundle] loadNibNamed:@"DetailTaskInfoCell" owner:self options:nil] lastObject];
        
        return cell;
    }
    
    if (indexPath.row == 1) {
        DetailTaskContactInfoCell *cell = (DetailTaskContactInfoCell *)[tableView dequeueReusableCellWithIdentifier:@"detailTaskContactInfoCell"];
        if (cell == nil)
            cell = [[[NSBundle mainBundle] loadNibNamed:@"DetailTaskContactInfoCell" owner:self options:nil] lastObject];
        
        return cell;
    }

    if (indexPath.row == 2) {
        // -- Cho nay se chen them cell danh gia --
        DetailTaskFeeCell *cell = (DetailTaskFeeCell *)[tableView dequeueReusableCellWithIdentifier:@"detailTaskFeeCell"];
        if (cell == nil)
            cell = [[[NSBundle mainBundle] loadNibNamed:@"DetailTaskFeeCell" owner:self options:nil] lastObject];
        
        return cell;
    }
    
    return nil;
    
//    DetailTaskFeeCell *cell = (DetailTaskFeeCell *)[tableView dequeueReusableCellWithIdentifier:@"detailTaskFeeCell"];
//    if (cell == nil)
//        cell = [[[NSBundle mainBundle] loadNibNamed:@"DetailTaskFeeCell" owner:self options:nil] lastObject];
//    
//    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 530;
    }
    
    if (indexPath.row == 1) {
        return 165;
    }

    if (indexPath.row == 2) {
        return 110;
    }

    
    // default size
    return 44;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Animation for select row
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    
//    //	NSString *indexWord = [indexArray objectAtIndex:indexPath.section];
//    //
//    //	NSLog(@"Ban da chon : %@",[array objectAtIndex:indexPath.row]);
//}




@end

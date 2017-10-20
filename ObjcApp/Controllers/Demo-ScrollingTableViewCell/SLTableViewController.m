//
//  SLTableViewController.m
//  ObjcApp
//
//  Created by Dylan Bui on 10/10/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "SLTableViewController.h"
#import "SLTableViewCell.h"

@interface SLTableViewController ()

@end

@implementation SLTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // So dong trong moi section
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLTableViewCell *cell = (SLTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"sLTableViewCell"];
    if (cell == nil)
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SLTableViewCell" owner:self options:nil] lastObject];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.indexPath = indexPath;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // default size
    return 200;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Animation for select row
    [tableView deselectRowAtIndexPath:indexPath animated:YES];    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSArray *visibleCells = [self.tblContent visibleCells];
    if (visibleCells.count > 0) {
        SLTableViewCell *cell = (SLTableViewCell *) [visibleCells objectAtIndex:0];
        
        [cell cellOnTableView:self.tblContent
              didScrollOnView:self.view withOffset:(cell.frame.origin.y - scrollView.contentOffset.y)];
        
//        [cell cellOnTableView:self.tblContent
//              didScrollOnView:self.view];
    }
}


@end

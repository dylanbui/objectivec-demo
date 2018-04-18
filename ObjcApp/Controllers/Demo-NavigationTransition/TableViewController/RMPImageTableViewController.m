//
//  RMPImageTableViewController.m
//  ObjcApp
//
//  Created by Dylan Bui on 4/18/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import "RMPImageTableViewController.h"

#import "RMPImageTableViewCell.h"
#import "RMPDetailViewController.h"

@interface RMPImageTableViewController () <UITableViewDataSource, UITableViewDelegate, DbZoomTransitionAnimating>

@property (nonatomic, copy) NSArray *images;

@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@property (nonatomic, strong) DbZoomDismissAnimatedTransitioning *transitioningDelegate;

@end

@implementation RMPImageTableViewController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupData];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupData];
    
    // Uncomment the following line to preserve selection between presentations.
//    /self.clearsSelectionOnViewWillAppear = NO;
    
    self.transitioningDelegate = [[DbZoomDismissAnimatedTransitioning alloc] initWithSourceController:self];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"RMPImageTableViewCell" bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:reuseIdentifier];
    
    self.navigationItem.title = @"Table View";
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"TableViewController %@", @"viewWillAppear");
    [super viewWillAppear:animated];
    // -- KHong duoc goi reload cell tro lai, vi no se lam mat selected cell khi Backward --
    //    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"TableViewController %@", @"viewDidAppear");
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"TableViewController %@", @"viewWillDisappear");
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    NSLog(@"TableViewController %@", @"viewDidDisappear");
    [super viewDidDisappear:animated];
}

#pragma mark -

- (void)setupData
{
    NSMutableArray *images = [NSMutableArray array];
    // we prepared 16 images for example
    for (int i = 1; i <= 16 ; i++) {
        NSString *filename = [NSString stringWithFormat:@"%02d_S.jpeg", i];
        NSDictionary *info = @{
                               @"filename": filename,
                               @"image"   : [UIImage imageNamed:filename]
                               };
        
        [images addObject:info];
    }
    self.images = [images copy];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.images count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RMPImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSDictionary *info = self.images[indexPath.row];
    cell.thumbImageView.image = info[@"image"];
    cell.titleLabel.text = info[@"filename"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndexPath = indexPath;
    // Animation for select row
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    RMPDetailViewController *vc = [[RMPDetailViewController alloc] init];
    // NSIndexPath *selectedIndexPath = [[self.tableView indexPathsForSelectedRows] firstObject];
    vc.index = self.selectedIndexPath.row;
    vc.transitioningDelegate = self.transitioningDelegate;
    
    [self presentViewController:vc animated:YES completion:nil];

}

#pragma mark <RMPZoomTransitionAnimating>

- (UIView *)transitionSourceView
{
    // NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
    RMPImageTableViewCell *cell = (RMPImageTableViewCell *)[self.tableView cellForRowAtIndexPath:self.selectedIndexPath];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:cell.thumbImageView.image];
    imageView.contentMode = cell.thumbImageView.contentMode;
    imageView.clipsToBounds = YES;
    imageView.userInteractionEnabled = NO;
    CGRect frameInSuperview = [cell.thumbImageView convertRect:cell.thumbImageView.frame toView:self.tableView.superview];
    frameInSuperview.origin.x -= cell.layoutMargins.left;
    frameInSuperview.origin.y -= cell.layoutMargins.top;
    imageView.frame = frameInSuperview;
    return imageView;
}

- (UIColor *)transitionSourceBackgroundColor
{
    return self.tableView.backgroundColor;
}

- (CGRect)transitionDestinationViewFrame
{
    // NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
    RMPImageTableViewCell *cell = (RMPImageTableViewCell *)[self.tableView cellForRowAtIndexPath:self.selectedIndexPath];
    CGRect frameInSuperview = [cell.thumbImageView convertRect:cell.thumbImageView.frame toView:self.tableView.superview];
    frameInSuperview.origin.x -= cell.layoutMargins.left;
    frameInSuperview.origin.y -= cell.layoutMargins.top;
    return frameInSuperview;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//    DetailViewController *vc = segue.destinationViewController;
//    NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
//    vc.index = selectedIndexPath.row;
//}

@end


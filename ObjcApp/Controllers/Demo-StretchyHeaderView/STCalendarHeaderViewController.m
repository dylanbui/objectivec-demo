//
//  STCalendarHeaderViewController.m
//  ObjcApp
//
//  Created by Dylan Bui on 10/20/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "STCalendarHeaderViewController.h"
#import "UINavigationController+Transparency.h"
#import "HeaderJTCalendarView.h"
#import "UIView+GSKLayoutHelper.h"

@interface STCalendarHeaderViewController ()

@property (nonatomic, strong) UITableView *tblControl;

@end

@implementation STCalendarHeaderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    
    // Allow UITableView under UINavigationBar
//    [self.navigationController gsk_setNavigationBarTransparent:YES animated:NO];
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
//    self.tblContent = UITableViewStyleGrouped;
    
    self.tblControl = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
                                                   style:UITableViewStyleGrouped];

    self.tblControl.dataSource = self;
    self.tblControl.delegate = self;
    
    [self.view addSubview:self.tblControl];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIEdgeInsets contentInset = self.tblContent.contentInset;
    if (self.navigationController) {
        contentInset.top = 64;
    }
    if (self.tabBarController) {
        contentInset.bottom = 44;
    }
    self.tblControl.contentInset = contentInset;
    

    _stretchyHeaderView = [self loadStretchyHeaderView];
    [self.tblControl addSubview:self.stretchyHeaderView];
    
    // by setting contentInset.top, we set where the section headers will be fixed
    UIEdgeInsets _contentInset = self.tblContent.contentInset;
    _contentInset.top = self.stretchyHeaderView.minimumContentHeight;
    self.tblControl.contentInset = _contentInset;
    
    // we add an empty header view at the top of the table view to increase the initial offset before the first section header
    // otherwise the header view would cover the first cells
    self.tblControl.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                              0,
                                                                              self.tblControl.width,
                                                                              self.stretchyHeaderView.maximumContentHeight - self.stretchyHeaderView.minimumContentHeight)];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    [self.navigationController gsk_setNavigationBarTransparent:YES animated:NO];
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (GSKStretchyHeaderView *)loadStretchyHeaderView
{
//    HeaderJTCalendarView *headerView = [[HeaderJTCalendarView alloc] initWithFrame:CGRectMake(0, 64, self.tblContent.frame.size.width, 364)];
    //HeaderJTCalendarView *headerView = [[HeaderJTCalendarView alloc] initWithFrame:CGRectMake(0, 0, self.tblContent.frame.size.width, 364)];
    HeaderJTCalendarView *headerView = [[HeaderJTCalendarView alloc] initWithFrame:CGRectMake(0, 0, self.tblContent.frame.size.width, 364)
                                        withController:self];
    //    headerView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
    // we have to set this flag before we add the header to the table view, otherwise it will change its insets immediately
    headerView.manageScrollViewInsets = NO;
    
    return headerView;
}

- (NSString *)defaultTitle
{
    NSString *className = NSStringFromClass(self.class);
    NSString *lastComponent = [className componentsSeparatedByString:@"."].lastObject;
    NSString *title = [lastComponent stringByReplacingOccurrencesOfString:@"ViewController" withString:@""];
    title = [title stringByReplacingOccurrencesOfString:@"Example" withString:@""];
    title = [title stringByReplacingOccurrencesOfString:@"GSK" withString:@""];
    return title;
}

#pragma mark -
#pragma mark UITableViewDataSource methods
#pragma mark -

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat sectionHeaderHeight = 50;
//    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
//        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
//        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//    }
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 50)];
    [view setBackgroundColor:[UIColor blueColor]];
    
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:view.frame];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor colorWithRed:148.0f/255.0f green:148.0f/255.0f blue:148.0f/255.0f alpha:1.0]];
    [label setText:[NSString stringWithFormat:@"Section %ld", section]];
    [view addSubview:label];
    
    return view;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)heightForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    if (indexPath.row % 2) {
        cell.contentView.backgroundColor = [UIColor grayColor];
    } else {
        cell.contentView.backgroundColor = [UIColor lightGrayColor];
    }
    
    return cell;
}


@end


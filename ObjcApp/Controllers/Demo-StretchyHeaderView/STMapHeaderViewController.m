//
//  STMapHeaderViewController.m
//  ObjcApp
//
//  Created by Dylan Bui on 12/12/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "STMapHeaderViewController.h"
#import "UINavigationController+Transparency.h"
#import "HeaderViewOne.h"
#import "HeaderMapView.h"

@interface STMapHeaderViewController ()

@property (nonatomic)           BOOL                    displayMap;

@end

@implementation STMapHeaderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Allow UITableView under UINavigationBar
    // [self.navigationController gsk_setNavigationBarTransparent:YES animated:NO];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    //self.automaticallyAdjustsScrollViewInsets = NO;
    UIEdgeInsets contentInset = self.tblContent.contentInset;
    if (self.navigationController) {
        contentInset.top = 64;
    }
    self.tblContent.contentInset = contentInset;
    
    _stretchyHeaderView = [self loadStretchyHeaderView];
    [self.tblContent addSubview:self.stretchyHeaderView];
}

- (GSKStretchyHeaderView *)loadStretchyHeaderView
{
    HeaderMapView *headerView = [[HeaderMapView alloc] initWithFrame:CGRectMake(0, 64, self.tblContent.frame.size.width, 200)];
    //    headerView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
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

#pragma mark - Table view Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scrollOffset        = scrollView.contentOffset.y;
    
    NSLog(@"scrollOffset = %f", scrollOffset);
    
//    CGRect headerMapViewFrame   = self.mapView.frame;
//    
//    if (scrollOffset < 0) {
//        // Adjust map
//        headerMapViewFrame.origin.y = self.headerYOffSet - ((scrollOffset / 2));
//    } else {
//        // Scrolling Up -> normal behavior
//        headerMapViewFrame.origin.y = self.headerYOffSet - scrollOffset;
//    }
//    self.mapView.frame = headerMapViewFrame;
//    
    // check if the Y offset is under the minus Y to reach
    if (self.tblContent.contentOffset.y < -364) {
        if(!self.displayMap)
            self.displayMap = YES;
    } else {
        if(self.displayMap)
            self.displayMap = NO;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(self.displayMap) {
        NSLog(@"%@", @"Dang rong ra");
        [_stretchyHeaderView setMaximumContentHeight:600 resetAnimated:YES];
    }

}


#pragma mark -
#pragma mark UITableViewDataSource methods
#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 60;
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

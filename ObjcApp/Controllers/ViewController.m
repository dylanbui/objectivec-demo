//
//  ViewController.m
//  ObjcApp
//
//  Created by Dylan Bui on 8/16/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "ViewController.h"

#import "PathsViewController.h"
#import "UserSessionViewController.h"
#import "ExpandLayoutViewController.h"
#import "ScrollViewFormViewController.h"
#import "DemoButtonViewController.h"
#import "TableExpandCellViewController.h"
#import "KeyboardViewController.h"
#import "TBTabbarViewController.h"
#import "STHeaderViewController.h"
#import "PTPhotoViewController.h"
#import "SLTableViewController.h"


@interface ViewController ()

@property (nonatomic, strong) NSArray *arrApps;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"Danh sách Demo";
    self.navigationItem.hidesBackButton = YES;
    
    self.arrApps = @[ @"Demo-ScrollingTableViewCell",
                      @"Demo-PhotoController",
                      @"Demo-StretchyHeaderView",
                      @"Demo-TabbarController",
                      @"Demo-Keyboard",
                      @"Demo-Button",
                      @"Demo-ScrollView",
                      @"Demo-TableView",
                      @"Demo-User-Session",
                      @"Demo-Expand-Layout",
                      @"Demo-Navigation-Bar" ];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrApps count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    cell.textLabel.text = [self.arrApps objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushOrReplaceToFirstViewController:[self getViewControllers:indexPath] animated:YES];
}

- (UIViewController *)getViewControllers:(NSIndexPath *)indexPath
{
    UIViewController *vcFirst;
    
    if (indexPath.row == 0) {
        vcFirst = [[SLTableViewController alloc] init];
    } else if (indexPath.row == 1) {
        vcFirst = [[PTPhotoViewController alloc] init];
    } else if (indexPath.row == 2) {
        vcFirst = [[STHeaderViewController alloc] init];
    } else if (indexPath.row == 3) {
        vcFirst = [[TBTabbarViewController alloc] init];
    } else if (indexPath.row == 4) {
        vcFirst = [[KeyboardViewController alloc] init];
    } else if (indexPath.row == 5) {
        vcFirst = [[DemoButtonViewController alloc] init];
    } else if (indexPath.row == 6) {
        vcFirst = [[ScrollViewFormViewController alloc] init];
    } else if (indexPath.row == 7) {
        vcFirst = [[TableExpandCellViewController alloc] init];
    } else if (indexPath.row == 8) {
        vcFirst = [[UserSessionViewController alloc] init];
    } else if (indexPath.row == 9) {
        vcFirst = [[ExpandLayoutViewController alloc] init];
    } else if (indexPath.row == 10) {
        vcFirst = [[PathsViewController alloc] init];
    }
    
    return vcFirst;
}

@end

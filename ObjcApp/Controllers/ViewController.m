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
#import "ScrollViewType1ViewController.h"
#import "DemoButtonViewController.h"
#import "TableExpandCellViewController.h"
#import "KeyboardViewController.h"
#import "TBTabbarViewController.h"
#import "STHeaderViewController.h"
#import "PTPhotoViewController.h"
#import "SLTableViewController.h"
#import "DemoMyCameraViewController.h"
#import "DemoTextSearchGGViewController.h"
#import "RMPExampleViewController.h"

#import "DemoCropCollectionViewController.h"
#import "ExampleMyCropViewController.h"
#import "DemoAttributedStringViewController.h"
#import "DemoLocationViewController.h"
#import "DemoBBLocationViewController.h"


@interface ViewController ()

@property (nonatomic, strong) NSArray *arrApps;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    if (DEBUG_MODE) {
        self.title = @"Danh sách DEBUG";
    } else {
        self.title = @"Danh sách RELEASE";
    }
    
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
                      @"Demo-MyCameraViewController",
                      @"Demo-Navigation-Bar",
                      @"Demo-SearchGoogle",
                      @"Demo-NavigationTransition",
                      @"Demo-TOCropViewControllerFromCollectionView",
                      @"Demo-MyCropViewController",
                      @"Demo-NSAttributedString",
                      @"Demo-LocationManager",
                      @"Demo-BBLocationManager"
                      ];
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
    NSString* path = [[NSBundle mainBundle] pathForResource:@"DbLibraries" ofType:@"bundle"];
    NSBundle *DbLibraries = [NSBundle bundleWithPath:path];
    
    NSString* name = [DbLibraries localizedStringForKey:@"Name" value:@"Name Default" table:@"DbLibraries"];
    NSString* group = [DbLibraries localizedStringForKey:@"Group" value:@"Group Default" table:@"DbLibraries"];
    NSString* group_name = [DbLibraries localizedStringForKey:@"Group_Name" value:@"Khong co du lieu" table:@"DbLibraries"];
    
    NSLog(@"%@ - %@ - %@", name, group, group_name);
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    [self.navigationController pushOrReplaceToFirstViewController:[self getViewControllers:indexPath] animated:YES];
    [self.navigationController pushViewController:[self getViewControllers:indexPath] animated:YES];
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
//        vcFirst = [[ScrollViewFormViewController alloc] init];
        vcFirst = [[ScrollViewType1ViewController alloc] init];
    } else if (indexPath.row == 7) {
        vcFirst = [[TableExpandCellViewController alloc] init];
    } else if (indexPath.row == 8) {
        vcFirst = [[UserSessionViewController alloc] init];
    } else if (indexPath.row == 9) {
        vcFirst = [[ExpandLayoutViewController alloc] init];
    } else if (indexPath.row == 10) {
        vcFirst = [[DemoMyCameraViewController alloc] init];
    } else if (indexPath.row == 11) {
        vcFirst = [[PathsViewController alloc] init];
    } else if (indexPath.row == 12) {
        vcFirst = [[DemoTextSearchGGViewController alloc] init];
    } else if (indexPath.row == 13) {
        vcFirst = [[RMPExampleViewController alloc] init];
    } else if (indexPath.row == 14) {
        vcFirst = [[DemoCropCollectionViewController alloc] init];
    } else if (indexPath.row == 15) {
        vcFirst = [[ExampleMyCropViewController alloc] init];
    } else if (indexPath.row == 16) {
        vcFirst = [[DemoAttributedStringViewController alloc] init];
    } else if (indexPath.row == 17) {
        vcFirst = [[DemoLocationViewController alloc] init];
    } else if (indexPath.row == 18) {
        vcFirst = [[DemoBBLocationViewController alloc] init];
    }
    
    return vcFirst;
}

@end

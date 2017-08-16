//
//  DetailCoursesViewController.m
//  TestApp
//
//  Created by Dylan Bui on 8/7/17.
//  Copyright © 2017 Dylan Bui. All rights reserved.
//

#import "DetailCoursesViewController.h"
//#import "Constant.h"

//#import "NavigationBarViewForDetail.h"
#import "HeightNavigationBar.h"

@interface DetailCoursesViewController ()

@property (nonatomic, strong) HeightNavigationBar *navBaseView;

@end

@implementation DetailCoursesViewController

- (id)init
{
    if (self = [super init]) {
        
        self.navBaseView = [[HeightNavigationBar alloc] initWithViewController:self];

        
//        NSLog(@"%@", @"newBackButton");
//        UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@" "
//                                                                          style:UIBarButtonItemStylePlain
//                                                                         target:nil
//                                                                         action:nil];
//        [[self navigationItem] setBackBarButtonItem:newBackButton];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"viewDidLoad = %@", @"DetailCoursesViewController");
    
    // Do any additional setup after loading the view from its nib.
    
//    self.navigationItem.backBarButtonItem = nil;
    
    // -- Config NavigationBar Back button (Change icon) --
//    UIImage *backBtn = [UIImage imageNamed:@"icoBack48.png"];
//    backBtn = [backBtn imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //     self.navigationItem.backBarButtonItem.title = @"";
    //    self.navigationController.navigationBar.topItem.title = @"";
    //icoBack48
    
//    NSLog(@"%@", @"icoBack48");
//    self.navigationItem.backBarButtonItem.title = @" ";
    
    //self.navigationItem.backBarButtonItem.title=@"Test string";
//    self.title = @"kiem tra hang";
//    self.navigationController.navigationBar.topItem.title = @"";
    
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
//                                                                             style:UIBarButtonItemStylePlain
//                                                                            target:nil
//                                                                            action:nil];
//    
//    self.navigationController.navigationBar.tintColor = [UIColor redColor];
//    self.navigationController.navigationBar.backIndicatorImage = backBtn;
//    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = backBtn;
    
    
    
//    NavigationBarViewForDetail *navView = [[NavigationBarViewForDetail alloc] initWithViewController:self];
//    [navView.lblMain setText:@"CoursesViewController"];
//    self.navBaseView = navView;    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    UIBarButtonItem *newBackButton =
//    [[UIBarButtonItem alloc] initWithTitle:@""
//                                     style:UIBarButtonItemStylePlain
//                                    target:nil
//                                    action:nil];
//    [[self navigationItem] setBackBarButtonItem:newBackButton];    
}
//
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell.textLabel setText:[NSString stringWithFormat:@"Dong thu %d", (int) indexPath.row]];
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"Dong sub thu %d", (int) indexPath.row]];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Animation for select row
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)btnBack_Click:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end

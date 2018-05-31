//
//  HeightBarViewController.m
//  ObjcApp
//
//  Created by Dylan Bui on 6/1/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import "HeightBarViewController.h"
#import "HeightNavigationBar.h"

@interface HeightBarViewController ()

@property (nonatomic, strong) HeightNavigationBar *navBaseView;

@end

@implementation HeightBarViewController

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
    
    NSLog(@"viewDidLoad = %@", @"HeightBarViewController");
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnBack_Click:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end

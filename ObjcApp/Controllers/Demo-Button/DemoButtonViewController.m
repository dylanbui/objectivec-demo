//
//  DemoButtonViewController.m
//  ObjcApp
//
//  Created by Dylan Bui on 9/2/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "DemoButtonViewController.h"
#import "BTLabel.h"
#import "BALabel.h"

@interface DemoButtonViewController ()
@property (weak, nonatomic) IBOutlet BTLabel *lblTopTitle;

@end

@implementation DemoButtonViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    BALabel *lbl = [[BALabel alloc] initWithFrame:CGRectMake(10, 370, 200, 60)];
    [lbl setBackgroundColor:[UIColor lightGrayColor]];
//    [lbl setNumberOfLines:0];
    [lbl setVerticalAlignment:BAVerticalAlignmentTop];
    //[lbl setTextAlignment:NSTextAlignmentRight];
    [lbl setText:@"Redistributions in binary form must reproduce the above copyright notice"];
    [self.view addSubview:lbl];
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


- (IBAction)btnPhiaTren:(id)sender
{
    NSLog(@"%@", @"View Click ----|||----");
}

@end

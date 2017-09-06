//
//  DemoButtonViewController.m
//  ObjcApp
//
//  Created by Dylan Bui on 9/2/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "DemoButtonViewController.h"
#import "BTLabel.h"

@interface DemoButtonViewController ()
@property (weak, nonatomic) IBOutlet BTLabel *lblTopTitle;

@end

@implementation DemoButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

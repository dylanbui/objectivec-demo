//
//  KeyboardViewController.m
//  ObjcApp
//
//  Created by Dylan Bui on 9/14/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "KeyboardViewController.h"
#import "IQKeyboardManager.h"
#import "IQKeyboardReturnKeyHandler.h"
#import "IQPreviousNextView.h"

@interface KeyboardViewController ()

@end

@implementation KeyboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    ([[[IQKeyboardManager sharedManager] toolbarPreviousNextAllowedClasses] containsObject:[IQPreviousNextView class]]);
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

@end

//
//  SecondViewController.m
//  AppTest
//
//  Created by Dylan Bui on 5/29/17.
//  Copyright © 2017 Dylan Bui. All rights reserved.
//

#import "ExpandLayoutViewController.h"
//#import "ThridViewController.h"
//#import "OPCustomNavigationController.h"

@interface ExpandLayoutViewController ()

@property (weak, nonatomic) IBOutlet UIView *viewContainer;
@property (weak, nonatomic) IBOutlet UILabel *lbl_1;
@property (weak, nonatomic) IBOutlet UILabel *lbl_2;

@end

@implementation ExpandLayoutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"ExpandLayoutViewController";
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSLog(@"1- viewContainer.frame = %@", NSStringFromCGRect(_viewContainer.frame));
    NSLog(@"1- lbl_1.frame = %@", NSStringFromCGRect(_lbl_1.frame));
    
//    [_lbl_1 setText:@"Whenever possible, use Interface Builder to set your constraints. Interface Builder provides a wide range of tools to visualize, edit, manage, and debug your constraints."];
//    
//    // Phai cap nhat lai layout chua no
//    [self.view layoutIfNeeded];
//    
//    // Neu khong phai set 2 lan => ket qua ra khong chinh xac
////    [_lbl_1 setNeedsLayout];
////    [_lbl_1 layoutIfNeeded];
//    
//    NSLog(@"2- lbl_1.frame = %@", NSStringFromCGRect(_lbl_1.frame));
//    
////    NSArray *constraintArr = _lbl_1.constraints;
////    NSLog(@"cons : %@",constraintArr);
//    
//    [_lbl_2 setText:@"Bat ngo xuat hien."];
}


- (IBAction)button_click:(UIButton *)sender
{
    if (sender.tag == 0) {
        [_lbl_1 setText:@"Whenever possible, use Interface Builder to set your constraints. Interface Builder provides a wide range of tools to visualize, edit, manage, and debug your constraints."];
        
        // Neu khong phai set 2 lan => ket qua ra khong chinh xac
        //    [_lbl_1 setNeedsLayout];
        //    [_lbl_1 layoutIfNeeded];
        
        [_lbl_2 setText:@"Bat ngo xuat hien."];
        
        [UIView animateWithDuration:0.5 animations:^{
            // Phai cap nhat lai layout chua no
            [self.view layoutIfNeeded];
        }];
        sender.tag = 1;
    } else {
        [_lbl_1 setText:@"Whenever possible, use Interface."];
        
        // Neu khong phai set 2 lan => ket qua ra khong chinh xac
        //    [_lbl_1 setNeedsLayout];
        //    [_lbl_1 layoutIfNeeded];
        
        // -- cho no an luon --
        [_lbl_2 setText:@""];

        // Phai cap nhat lai layout chua no
        [UIView animateWithDuration:0.5 animations:^{
            // Phai cap nhat lai layout chua no
            [self.view layoutIfNeeded];
        }];
        sender.tag = 0;
    }
    
    NSLog(@"2- lbl_1.frame = %@", NSStringFromCGRect(_lbl_1.frame));
    NSLog(@"2- viewContainer.frame = %@", NSStringFromCGRect(_viewContainer.frame));
}

@end

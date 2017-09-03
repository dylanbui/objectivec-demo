//
//  SecondViewController.m
//  AppTest
//
//  Created by Dylan Bui on 5/29/17.
//  Copyright © 2017 Dylan Bui. All rights reserved.
//

#import "ExpandLayoutViewController.h"
#import "MaterialDesignSymbol.h"
#import "DLRadioButton.h"

//#import "ThridViewController.h"
//#import "OPCustomNavigationController.h"

#import "TaskTableViewHeader.h"

@interface ExpandLayoutViewController ()
    

@property (weak, nonatomic) IBOutlet UIView *viewContainer;

@property (weak, nonatomic) IBOutlet UILabel *lbl_1;

@property (weak, nonatomic) IBOutlet UILabel *lbl_2;

@property (weak, nonatomic) IBOutlet UIImageView *imgIcon;

@property (weak, nonatomic) IBOutlet UIButton *btnIcon;

@property (weak, nonatomic) IBOutlet UIView *vwShadow;

@property (weak, nonatomic) IBOutlet UIView *vwSegment;

@property (weak, nonatomic) IBOutlet UIView *vwGroupButton;

@property (weak, nonatomic) IBOutlet DLRadioButton *btnCheckbox;

@end

@implementation ExpandLayoutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"ExpandLayoutViewController";
    
    MaterialDesignSymbol *symbol = [MaterialDesignSymbol iconWithCode:MaterialDesignIconCode.accountBox24px fontSize:40.f];
    [symbol addAttribute:NSForegroundColorAttributeName value:[UIColor redColor]];
    [_imgIcon setImage:[symbol image]];
//    [_imgIcon setImage:[symbol imageWithSize:CGSizeMake(30, 30)]];
    
    //UIImage *image = [symbol image];
    // UIImage *image = [symbol imageWithSize:CGSizeMake(30, 30)];
    
    
    // UIButton *button = [[UIButton alloc] init];
    // UIImage *closeImage = [[UIImage imageNamed:@"ic_card_giftcard.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    //button.tintColor = [UIColor colorWithWhite:0 alpha:0.54f];
    // _btnIcon.tintColor = [UIColor blueColor];
    [_btnIcon setImage:[symbol image] forState:UIControlStateNormal];
    

    TaskTableViewHeader *header = [[TaskTableViewHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.vwSegment.frame.size.height)];
//    TaskTableViewHeader *header = [[TaskTableViewHeader alloc] init];
    header.handleViewAction = ^(id _self, int _id, NSDictionary* _params, NSError* error){
        
    };
    
    
    [self.vwSegment addSubview:header];
    
    NSLog(@"%@", NSStringFromCGRect(header.frame));
    
    
    [self.btnCheckbox setSelected:YES];
    self.btnCheckbox.multipleSelectionEnabled = YES;
//    self.btnCheckbox.animationDuration = 0.0;
    
    if([self.btnCheckbox isSelected]) {
        NSLog(@"%@", @"Da chon vao checkbox");
    }
    
    // -- Define group button --
    // border radius
    [self.vwGroupButton.layer setCornerRadius:10.0f];
    self.vwGroupButton.layer.masksToBounds = YES;

    
    // border
    [self.vwGroupButton.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.vwGroupButton.layer setBorderWidth:0.5f];
    
    // drop shadow
    [self.vwGroupButton.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.vwGroupButton.layer setShadowOpacity:0.2];
    [self.vwGroupButton.layer setShadowRadius:2.0];
    [self.vwGroupButton.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    [self.vwGroupButton.layer setShadowOffset:CGSizeMake(0, 0)];
    
    
    
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
- (IBAction)btnPhiaTren:(id)sender
{
    NSLog(@"%@", @"btnPhiaTren ----|||----");
}

- (IBAction)btnCheckbox_Click:(DLRadioButton *)sender
{
    if([sender isSelected]) {
        NSLog(@"%@", @"Da chon vao checkbox");
    } else {
        NSLog(@"%@", @"NONE");
    }
}
- (IBAction)vwAction:(id)sender
{
    NSLog(@"%@", @"vwAction: CLICKKKKKKKKKKK");
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

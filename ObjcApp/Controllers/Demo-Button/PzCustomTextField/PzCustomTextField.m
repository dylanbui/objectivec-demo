//
//  HeaderView.m
//  PropzyDiy
//
//  Created by Le Thi Ngoc Thuy on 5/29/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "PzCustomTextField.h"

@interface PzCustomTextField()

@property (weak, nonatomic) IBOutlet UILabel *lblIcon;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@property (nonatomic, copy) void (^touchHandler)(PzCustomTextField *) ;

@end

@implementation PzCustomTextField



- (instancetype)init
{
    self = [super init];
    [self setupViews];
    return self;
}

- (void)setupViews
{
//    [self.vwEvaluateFromCustomer setHidden:YES];
//    [self.vwChartFilter setHidden:YES];
    
    [self.lblIcon setHidden:YES];
    [self.btn setHidden:YES];
    
    
    // add targets and actions
    [self.btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    self.layer.cornerRadius = 5.0;
//    self.layer.borderWidth = 2.0;
//    self.layer.borderColor = [UIColor grayColor].CGColor;
}

- (void)touchInside:(void (^)(PzCustomTextField *))touchHandler
{
    [self.lblIcon setHidden:NO];
    [self.btn setHidden:NO];
    self.touchHandler = touchHandler;
}

- (IBAction)buttonClicked:(id)sender
{
    if (self.touchHandler != nil) {
        self.touchHandler(self);
    }
}

//- (void)setTitle:(NSString *)title iconImage:(NSString *)iconName setTextColor:(UIColor *)textColor isHidenBtnDetail:(BOOL)isHiden
//{
//    [self.lblTitle setText:title];
//    [self.lblTitle setTextColor:textColor];
//    [self.imgIcon setImage:[UIImage imageNamed:iconName]];
//    [self.btnViewDetail setHidden:isHiden];
//
//    [self.vwEvaluateFromCustomer setHidden:YES];
//    [self.vwChartFilter setHidden:YES];
//}
//
//- (void)setTitleForEvaluateFromCustomer:(NSString *)title iconImage:(NSString *)iconName setTextColor:(UIColor *)textColor evaluateVal:(float)val
//{
//    [self setTitle:title iconImage:iconName setTextColor:textColor isHidenBtnDetail:NO];
//
//    [self.vwEvaluateFromCustomer setHidden:NO];
//    UILabel *lbl = (UILabel *) [self.vwEvaluateFromCustomer viewWithTag:111];
//    //val = 3.930000;
//    //NSLog(@"%@", [NSString stringWithFormat:@"%f", val]);
//    // lbl.text = [NSString stringWithFormat:@"%.1f", roundf(val)];
//    lbl.text = [NSString stringWithFormat:@"%.1f", val];
//}
//
//- (void)setTitleForChartFilter:(NSString *)title iconImage:(NSString *)iconName
//                  setTextColor:(UIColor *)textColor chooseTitleVal:(NSString *)chooseTitle
//{
//    [self setTitle:title iconImage:iconName setTextColor:textColor isHidenBtnDetail:NO];
//
//    [self.vwChartFilter setHidden:NO];
//    UIButton *btn = (UIButton *) [self.vwChartFilter viewWithTag:222];
//    [btn setTitle:chooseTitle forState:UIControlStateNormal];
//}
//
//- (void)hideView
//{
//    [self removeFromSuperview];
//}
//
//- (IBAction)btnViewDetail_Click:(id)sender
//{
//    if (self.handleViewAction)
//        self.handleViewAction(self, 0, nil, nil);
//}
//
//- (IBAction)btnChartFilter_Click:(id)sender
//{
//    if (self.handleViewAction) {
//        self.handleViewAction(self, 1, nil, nil);
//    }
//
//}

@end

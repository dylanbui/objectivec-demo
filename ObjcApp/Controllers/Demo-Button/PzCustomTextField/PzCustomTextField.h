//
//  HeaderView.h
//  PropzyDiy
//
//  Created by Le Thi Ngoc Thuy on 5/29/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "DbXibView.h"
//#import "DbViewFromXib.h"

@interface PzCustomTextField : DbXibView

@property (weak, nonatomic) IBOutlet UITextField *txtContent;

- (void)touchInside:(void (^)(PzCustomTextField *))touchHandler;



//@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
//@property (weak, nonatomic) IBOutlet UIImageView *imgIcon;
//@property (weak, nonatomic) IBOutlet UIButton *btnViewDetail;
//
//@property (weak, nonatomic) IBOutlet UIView *vwEvaluateFromCustomer;
//@property (weak, nonatomic) IBOutlet UIView *vwChartFilter;
//
//- (IBAction)btnViewDetail_Click:(id)sender;
//- (IBAction)btnChartFilter_Click:(id)sender;

//- (void)setTitle:(NSString *)title iconImage:(NSString *)iconName setTextColor:(UIColor *)textColor isHidenBtnDetail:(BOOL)isHiden;
//
//- (void)setTitleForEvaluateFromCustomer:(NSString *)title iconImage:(NSString *)iconName setTextColor:(UIColor *)textColor evaluateVal:(float)val;
//
//- (void)setTitleForChartFilter:(NSString *)title iconImage:(NSString *)iconName
//                  setTextColor:(UIColor *)textColor chooseTitleVal:(NSString *)chooseTitle;


@end

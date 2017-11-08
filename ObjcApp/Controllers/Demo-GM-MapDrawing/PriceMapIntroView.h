//
//  PriceMapIntroView.h
//  ObjcApp
//
//  Created by Dylan Bui on 11/7/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DbViewFromXib.h"
#import "DbUtils.h"

#import "RippleEffectView.h"

@interface PriceMapIntroView : DbViewFromXib

@property (weak, nonatomic) IBOutlet UIImageView *imgBg;
@property (weak, nonatomic) IBOutlet UIImageView *imgIntroPopup;
@property (weak, nonatomic) IBOutlet UIButton *btnRippleEffectFront;

- (void)startAnimation;

@end

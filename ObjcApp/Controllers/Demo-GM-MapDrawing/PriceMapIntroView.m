//
//  PriceMapIntroView.m
//  ObjcApp
//
//  Created by Dylan Bui on 11/7/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "PriceMapIntroView.h"
#import "UIView+LayoutHelper.h"

@interface PriceMapIntroView ()


@property (nonatomic, strong) RippleEffectView *btnRippleEffect;

@end


@implementation PriceMapIntroView

- (void)startAnimation
{
    UITapGestureRecognizer *tapGestureBg = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                action:@selector(buttonTapped:)];
    self.imgBg.userInteractionEnabled = YES;
    [self.imgBg addGestureRecognizer:tapGestureBg];

    UITapGestureRecognizer *tapGesturePopup = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                  action:@selector(buttonTapped:)];
    self.imgIntroPopup.userInteractionEnabled = YES;
    [self.imgIntroPopup addGestureRecognizer:tapGesturePopup];
    
    [self startRippleButton];
    
    [DbUtils delayCallback:^{
        [self startPopupIntro];
    } forSeconds:0.7];
}

- (void)buttonTapped:(id)sender
{
    self.handleViewAction(self, 0, nil, nil);
}

- (void)startRippleButton
{
    self.btnRippleEffect = [[RippleEffectView alloc] initWithImage:[UIImage imageNamed:@"icon_fingue.png"]
                                                             Frame:self.vwRippleRippleEffect.frame didEnd:^(BOOL success) {
                                                                 self.handleViewAction(self, 1, nil, nil);
                                                             }];
    
    [self.btnRippleEffect setRippleColor:[UIColor orangeColor]];
    [self.btnRippleEffect setRippleTrailColor:[UIColor orangeColor]];
    
    [self addSubview:self.btnRippleEffect];
    //[self insertSubview:self.btnRippleEffect belowSubview:self.imgIntroPopup];
}

- (void)startPopupIntro
{
    CGSize oldSize = self.imgIntroPopup.size;
    CGPoint oldCenter = self.imgIntroPopup.center;
    CGPoint newCenter = CGPointMake(oldCenter.x + self.imgIntroPopup.width/2 , oldCenter.y + self.imgIntroPopup.height/2);
    
    self.imgIntroPopup.size = CGSizeMake(1, 1);
    self.imgIntroPopup.center = newCenter;
    self.imgIntroPopup.alpha = 0;
    [self.imgIntroPopup setHidden:NO];
    [UIView animateWithDuration:1.5 animations:^{
        self.imgIntroPopup.alpha = 1.0;
        self.imgIntroPopup.size = oldSize;
        self.imgIntroPopup.center = oldCenter;
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}


@end

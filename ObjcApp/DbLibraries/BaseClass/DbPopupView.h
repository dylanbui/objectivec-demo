//
//  BasePopupView.h
//  PropzyDiy
//
//  Created by Dylan Bui on 7/18/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DbViewFromXib.h"

/*
 
 EndView *vw_1 = [[EndView alloc] initWithHandleViewAction:^(id _self, NSDictionary *_params, int _id) { }];
 [vw_1 showPopup];
 
 */

@interface DbPopupView : DbViewFromXib

@property (nonatomic, weak) UIViewController *containerViewController;

@property (weak, nonatomic) IBOutlet UIView *vwContent;
@property (nonatomic, strong) UIView *vwBg;

- (id)init;
- (id)initWithHandleViewAction:(HandleViewAction)handle;

- (void)showPopup;
- (void)dismissPopup;

- (void)showPopupWithCompletion:(void (^)(BOOL finished))completion;
- (void)dismissPopupWithCompletion:(void (^)(BOOL finished))completion;

@end

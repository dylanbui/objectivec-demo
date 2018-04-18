//
//  RMPDetailViewController.h
//  ObjcApp
//
//  Created by Dylan Bui on 4/17/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMPZoomTransitionAnimator.h"

@interface RMPDetailViewController : UIViewController<RMPZoomTransitionAnimating, RMPZoomTransitionDelegate>

@property (nonatomic) NSUInteger index;

@property (nonatomic, weak) IBOutlet UIImageView *mainImageView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

@end

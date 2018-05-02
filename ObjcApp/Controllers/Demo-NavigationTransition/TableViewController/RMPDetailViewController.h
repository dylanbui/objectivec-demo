//
//  RMPDetailViewController.h
//  ObjcApp
//
//  Created by Dylan Bui on 4/17/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DbZoomTransitionAnimator.h"
//#import "DbZoomDismissAnimatedTransitioning.h"
//#import "DbAnimatedTransitioning.h"

@interface RMPDetailViewController : UIViewController <DbZoomTransitionAnimating, DbZoomTransitionDelegate>

@property (nonatomic) NSUInteger index;

@property (nonatomic, weak) IBOutlet UIImageView *mainImageView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

@end

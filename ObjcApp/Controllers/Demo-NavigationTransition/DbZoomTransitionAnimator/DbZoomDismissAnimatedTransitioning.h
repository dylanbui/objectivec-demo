//
//  DbZoomDismissAnimatedTransitioning.h
//  ObjcApp
//
//  Created by Dylan Bui on 4/18/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DbZoomTransitionAnimator.h"

@interface DbZoomDismissAnimatedTransitioning : NSObject <UIViewControllerTransitioningDelegate>

- (instancetype)initWithSourceController:(UIViewController *)vcl;

@end

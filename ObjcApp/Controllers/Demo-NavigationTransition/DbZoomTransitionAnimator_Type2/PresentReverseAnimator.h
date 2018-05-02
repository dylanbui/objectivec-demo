//
//  PresentReverseAnimator.h
//  ObjcApp
//
//  Created by Dylan Bui on 5/2/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PresentReverseAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic) float duration;
@property (nonatomic) BOOL isPresenting;


- (instancetype)init;


@end

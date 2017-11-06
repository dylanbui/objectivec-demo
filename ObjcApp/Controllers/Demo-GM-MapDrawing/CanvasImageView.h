//
//  CanvasImageView.h
//  ObjcApp
//
//  Created by Dylan Bui on 11/6/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapDrawingViewController.h"

@interface CanvasImageView : UIImageView

@property (nonatomic, weak) MapDrawingViewController *delegate;

@end



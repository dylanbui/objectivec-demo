//
//  CanvasView.h
//  ObjcApp
//
//  Created by Dylan Bui on 11/3/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapDrawingViewController.h"

@interface CanvasView : UIImageView

@property (nonatomic, weak) MapDrawingViewController *delegate;

@end



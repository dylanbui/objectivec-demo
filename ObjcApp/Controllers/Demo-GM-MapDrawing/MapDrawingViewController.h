//
//  MapDrawingViewController.h
//  ObjcApp
//
//  Created by Dylan Bui on 11/3/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "BaseViewController.h"

@interface MapDrawingViewController : BaseViewController

- (void)touchesBegan:(UITouch*)touch;
- (void)touchesMoved:(UITouch*)touch;
- (void)touchesEnded:(UITouch*)touch;

@end

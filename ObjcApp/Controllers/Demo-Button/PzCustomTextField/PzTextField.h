//
//  PzTextField.h
//  ObjcApp
//
//  Created by Dylan Bui on 5/22/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import "DbTextField.h"
#import "DbUtils.h"

typedef void (^PzTextFieldTouch)(id sender);

@interface PzTextField : DbTextField

- (void)touchInside:(PzTextFieldTouch)touchHandler;

@end

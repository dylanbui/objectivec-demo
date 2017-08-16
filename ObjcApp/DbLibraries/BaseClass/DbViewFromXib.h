//
//  UIViewFromXib.h
//  PropzyTouring
//
//  Created by Dylan Bui on 1/19/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//  https://github.com/PaulSolt/CustomUIView

#import <UIKit/UIKit.h>

// -- Xu ly tra ve cua cac UIView action --
typedef void (^HandleViewAction)(id _self, int _id, NSDictionary* _params, NSError* error);

@interface DbViewFromXib : UIView

@property (nonatomic, strong) DbViewFromXib *customView;
@property (nonatomic, strong) HandleViewAction handleViewAction;

- (id)init;
- (id)initWithHandleViewAction:(HandleViewAction)handle;
- (id)initWithFrame:(CGRect)frame;
- (id)initWithFrame:(CGRect)frame andHandleViewAction:(HandleViewAction)handle;


@end

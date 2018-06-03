//
//  DbXibView.h
//  ObjcApp
//
//  Created by Dylan Bui on 5/21/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

// chu y : "owner:self options:nil"

#define loadView() \
NSBundle *mainBundle = [NSBundle mainBundle]; \
NSArray *views = [mainBundle loadNibNamed:NSStringFromClass([self class]) owner:self options:nil]; \
[self addSubview:views[0]];


// -- Xu ly tra ve cua cac UIView action --
typedef void (^PzHandleViewAction)(id _self, int _id, NSDictionary* _params, NSError* error);

@interface DbXibView : UIView

//@property (nonatomic, strong) DbViewFromXib *customView;
@property (nonatomic, strong) PzHandleViewAction handleViewAction;

- (instancetype)init;
//- (instancetype)initWithFrame:(CGRect)frame;
- (instancetype)initWithCoder:(NSCoder *)aDecoder;

//- (instancetype)initWithHandleViewAction:(HandleViewAction)handle;
//- (instancetype)initWithFrame:(CGRect)frame andHandleViewAction:(HandleViewAction)handle;


@end

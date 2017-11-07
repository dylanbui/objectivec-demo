//
//  UIViewFromXib.m
//  PropzyTouring
//
//  Created by Dylan Bui on 1/19/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "DbViewFromXib.h"

@implementation DbViewFromXib

@synthesize handleViewAction;

- (id)init
{
    // 1. Load the .xib file .xib file must match classname
    NSString *className = NSStringFromClass([self class]);
    // 2. Load xib from main bundle and assign it to self
    self = [[[NSBundle mainBundle]loadNibNamed:className owner:self options:nil] objectAtIndex:0];
    return self;
}

- (id)initWithHandleViewAction:(HandleViewAction)handle
{
    // 1. Load the .xib file .xib file must match classname
    NSString *className = NSStringFromClass([self class]);
    // 2. Load xib from main bundle and assign it to self
    self = [[[NSBundle mainBundle]loadNibNamed:className owner:self options:nil] objectAtIndex:0];
    self.handleViewAction = handle;
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSString *className = NSStringFromClass([self class]);
        // 2. Load xib from main bundle and assign it to self
        self = [[[NSBundle mainBundle]loadNibNamed:className owner:self options:nil] objectAtIndex:0];
        if(CGRectIsEmpty(frame)) {
//            self.bounds = _customView.bounds;
            self.frame = frame;
        }
    }
    return self;
    
//    self = [super initWithFrame:frame];
//    if (self) {
//        // 1. Load the .xib file .xib file must match classname
//        NSString *className = NSStringFromClass([self class]);
//        _customView = [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] firstObject];
//        _customView.frame = self.bounds;
//        // 2. Set the bounds if not set by programmer (i.e. init called)
//        if(CGRectIsEmpty(frame)) {
//            self.bounds = _customView.bounds;
//        }
//        
//        // 3. Add as a subview
//        [self addSubview:_customView];
//        
//    }
//    return self;
}

- (id)initWithFrame:(CGRect)frame andHandleViewAction:(HandleViewAction)handle
{
    self = [self initWithFrame:frame];
    if (self) {
        self.handleViewAction = handle;
    }
    return self;
}

//- (id)initWithCoder:(NSCoder *)aDecoder
//{
//    self = [super initWithCoder:aDecoder];
//    if(self) {
//        NSString *className = NSStringFromClass([self class]);
//        // 2. Load xib from main bundle and assign it to self
//        self = [[[NSBundle mainBundle]loadNibNamed:className owner:self options:nil] objectAtIndex:0];
//        
////        // 1. Load .xib file
////        NSString *className = NSStringFromClass([self class]);
////        _customView = [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] firstObject];
////        _customView.frame = self.bounds;
////        // 2. Add as a subview
////        [self addSubview:_customView];
//        
//    }
//    return self;
//}

@end

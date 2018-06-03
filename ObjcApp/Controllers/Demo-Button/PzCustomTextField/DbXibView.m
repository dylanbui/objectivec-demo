//
//  DbXibView.m
//  ObjcApp
//
//  Created by Dylan Bui on 5/21/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import "DbXibView.h"

@interface DbXibView()

//@property (nonatomic, strong) UIView* masterView;

@end

@implementation DbXibView

- (instancetype)init
{
    self = [super init];
    if(!self){
        return nil;
    }
    
    loadView()
    
    //    self.label.text = [NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__];
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(!self){
        return nil;
    }
    
    loadView()
    
//    self.label.text = [NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__];
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(!self){
        return nil;
    }
    
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSArray *views = [mainBundle loadNibNamed:NSStringFromClass([self class])
                                        owner:nil
                                      options:nil];
    [self addSubview:views[0]];
    
    return self;
}


//- (id)init
//{
//    // 1. Load the .xib file .xib file must match classname
//    NSString *className = NSStringFromClass([self class]);
//    // 2. Load xib from main bundle and assign it to self
//    self = [[[NSBundle mainBundle]loadNibNamed:className owner:self options:nil] objectAtIndex:0];
//    return self;
//}
//
//- (id)initWithHandleViewAction:(PzHandleViewAction)handle
//{
//    // 1. Load the .xib file .xib file must match classname
//    NSString *className = NSStringFromClass([self class]);
//    // 2. Load xib from main bundle and assign it to self
//    self = [[[NSBundle mainBundle]loadNibNamed:className owner:self options:nil] objectAtIndex:0];
//    self.handleViewAction = handle;
//    return self;
//}
//
//- (instancetype)initWithCoder:(NSCoder *)aDecoder
//{
//    self = [super initWithCoder:aDecoder];
//    // 1. Load the .xib file .xib file must match classname
//    NSString *className = NSStringFromClass([self class]);
//    // 2. Load xib from main bundle and assign it to self
//    self = [[[NSBundle mainBundle]loadNibNamed:className owner:self options:nil] objectAtIndex:0];
//    return self;
//}

//- (instancetype)init
//{
//    // 1. setup any properties here
//
//    // 2. call super.init(frame:)
//    //super.init(frame: frame)
//    self = [super init];
//
//    // 3. Setup view from .xib file
//    [self xibSetup];
//
//    return self;
//}
//
//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    // 3. Setup view from .xib file
//    [self xibSetup];
//
//    return self;
//}
//
//- (instancetype)initWithCoder:(NSCoder *)aDecoder
//{
//    self = [super initWithCoder:aDecoder];
//    [self xibSetup];
//    return self;
//}
//
//- (void)xibSetup
//{
//    self.masterView = [self loadViewFromNib];
//    // use bounds not frame or it'll be offset
//    self.masterView.frame = self.bounds;
//    // Make the view stretch with containing view
//    self.masterView.autoresizingMask = UIViewAutoresizingFlexibleWidth |  UIViewAutoresizingFlexibleHeight;
//    // [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
//    // Adding custom subview on top of our view (over any custom drawing > see note below)
//    [self addSubview:self.masterView];
//}
//
//- (UIView *)loadViewFromNib
//{
//    // 1. Load the .xib file .xib file must match classname
//    NSString *className = NSStringFromClass([self class]);
//    // 2. Load xib from main bundle and assign it to self
//    UIView *view = [[[NSBundle mainBundle]loadNibNamed:className owner:self options:nil] objectAtIndex:0];
//    return view;
//}

@end

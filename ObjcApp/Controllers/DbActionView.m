//
//  DbActionView.m
//  ObjcApp
//
//  Created by Dylan Bui on 9/1/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "DbActionView.h"

@interface DbActionView () <UIGestureRecognizerDelegate> {
    
    NSMutableDictionary *dictOldProperty;

}

@end

@implementation DbActionView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
//    UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] init];
    
    UITapGestureRecognizer *singleFingerTap =    
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(btnTabbar_Click:)];
    singleFingerTap.delegate = self;
    [self addGestureRecognizer:singleFingerTap];
    
    dictOldProperty = [[NSMutableDictionary alloc] init];
    [dictOldProperty setObject:self.backgroundColor forKey:@"backgroundColor"];
    
}

- (instancetype)init
{
    if (self = [super init]) {
        UITapGestureRecognizer *singleFingerTap = 
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(btnTabbar_Click:)];
        
        singleFingerTap.delegate = self;
        [self addGestureRecognizer:singleFingerTap];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@", @" ----- touchesBegan");
    // [self setBackgroundColor:[UIColor redColor]];
    
    [self setBackgroundColor:_touchUpInsideColor];    
}

- (IBAction)btnTabbar_Click:(UIGestureRecognizer *)gestureRecognizer
{
    [UIView animateWithDuration:0.5 animations:^{
        [self setBackgroundColor:[dictOldProperty objectForKey:@"backgroundColor"]];
    }];
    
//    switch (gestureRecognizer.state) {
//        case UIGestureRecognizerStatePossible:
//            NSLog(@"%@", @"UIGestureRecognizerStatePossible");
//            break;
//            
//        case UIGestureRecognizerStateBegan:
//            NSLog(@"%@", @"UIGestureRecognizerStateBegan");
//            break;
//            
//        case UIGestureRecognizerStateChanged:
//            NSLog(@"%@", @"UIGestureRecognizerStateChanged");
//            break;
//            
//        case UIGestureRecognizerStateEnded:
//            NSLog(@"%@", @"UIGestureRecognizerStateEnded");
//            break;
//            
//        case UIGestureRecognizerStateCancelled:
//            NSLog(@"%@", @"UIGestureRecognizerStateCancelled");
//            break;
//            
//        case UIGestureRecognizerStateFailed:
//            NSLog(@"%@", @"UIGestureRecognizerStateFailed");
//            break;
//            
//        default:
//            NSLog(@"%@", @"NONEEEE");
//            break;
//    }
//    
//    NSLog(@"%@", @"click");

    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
}



@end

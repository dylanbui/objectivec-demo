//
//  DbBarButtonItem.m
//  PropzyDiy
//
//  Created by Dylan Bui on 11/2/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "DbBarButtonItem.h"

@interface DbBarButtonItem() {
    id customTarget;
    UIButton* customButton;
}

@end

@implementation DbBarButtonItem

- (id)initWithImage:(UIImage *)image
      selectedImage:(UIImage *)selectedImage
             target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0.0f, 0.0f, 30.0f, 30.0f)];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selectedImage forState:UIControlStateHighlighted];
    
    /* Init method inherited from UIBarButtonItem */
    self = [[DbBarButtonItem alloc] initWithCustomView:btn];
    
    if (self) {
        /* Assign ivars */
        customButton = btn;
        customImage = image;
        customSelectedImage = selectedImage;
        
        if (target == nil || action == nil) {
            target = self;
            action = @selector(selfClickAction:);
        }
        [customButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        
        customTarget = target;
        customAction = action;
    }
    
    return self;
}

+ (DbBarButtonItem *)barItemWithImage:(UIImage *)image
                        selectedImage:(UIImage *)selectedImage
                               target:(id)target
                               action:(SEL)action
{
    return [[DbBarButtonItem alloc] initWithImage:image
                                    selectedImage:selectedImage
                                           target:target
                                           action:action];
}

- (void)setTitleButton:(NSString *)title
{
    [customButton setTitle:title forState:UIControlStateNormal];
}

- (void)setCustomImage:(UIImage *)image
{
    customImage = image;
    [customButton setImage:image forState:UIControlStateNormal];
}

- (void)setCustomSelectedImage:(UIImage *)image
{
    customSelectedImage = image;
    [customButton setImage:image forState:UIControlStateHighlighted];
}

#pragma mark - Text

- (id)initWithTitle:(NSString *)title
         themeColor:(UIColor *)themeColor
             target:(id)target
             action:(SEL)action
{
    
    CGSize maxButtonSize = CGSizeMake(MAXFLOAT, 30);
    
    NSDictionary *stringAttributes = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:16]
                                                                     forKey: NSFontAttributeName];
    CGFloat width = [title boundingRectWithSize:maxButtonSize
                                        options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin
                                     attributes:stringAttributes context:nil].size.width;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0.0f, 0.0f, width + 20, 30.0f)];
    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:themeColor forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    //    [btn.titleLabel setFont:[UIFont fontWithName:@"AvenirNext-Regular" size:16]];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
    [btn setImage:nil forState:UIControlStateNormal];
    [btn setImage:nil forState:UIControlStateHighlighted];
    
    /* Init method inherited from UIBarButtonItem */
    self = [[DbBarButtonItem alloc] initWithCustomView:btn];
    
    if (self) {
        /* Assign ivars */
        customButton = btn;
        customImage = nil;
        customSelectedImage = nil;
        
        if (target == nil || action == nil) {
            target = self;
            action = @selector(selfClickAction:);
        }
        [customButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        
        customTarget = target;
        customAction = action;
    }
    
    return self;
}

+ (DbBarButtonItem *)barItemWithTitle:(NSString *)title
                           themeColor:(UIColor *)themeColor
                               target:(id)target
                               action:(SEL)action
{
    return [[DbBarButtonItem alloc] initWithTitle:title
                                       themeColor:themeColor
                                           target:target
                                           action:action];
}


+ (DbBarButtonItem *)barItemWithImage:(UIImage *)image
                        selectedImage:(UIImage *)selectedImage
                           clickBlock:(DbBarButtonItemBlock)clickBlock
{
    DbBarButtonItem *barButton = [[DbBarButtonItem alloc] initWithImage:image
                                                           selectedImage:selectedImage
                                                                  target:nil
                                                                  action:nil];
    [barButton setBarButtonItemBlock:clickBlock];
    return barButton;
}


+ (DbBarButtonItem *)barItemWithTitle:(NSString *)title
                           themeColor:(UIColor *)themeColor
                           clickBlock:(DbBarButtonItemBlock)clickBlock
{
    DbBarButtonItem *barButton = [[DbBarButtonItem alloc] initWithTitle:title
                                                             themeColor:themeColor
                                                                 target:nil
                                                                 action:nil];    
    [barButton setBarButtonItemBlock:clickBlock];
    return barButton;
}

#pragma mark - Actions

- (void)setCustomAction:(SEL)action
{
    customAction = action;
    
    [customButton removeTarget:nil
                        action:NULL
              forControlEvents:UIControlEventAllEvents];
    
    [customButton addTarget:customTarget
                     action:action
           forControlEvents:UIControlEventTouchUpInside];
}

- (void)setBarButtonItemBlock:(DbBarButtonItemBlock)clickBlock
{
    barButtonItemBlock = clickBlock;
}

- (IBAction)selfClickAction:(id)sender
{
    if (barButtonItemBlock)
        barButtonItemBlock(sender);
}


@end


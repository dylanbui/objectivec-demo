//
//  DbRangeSlider.m
//  ObjcApp
//
//  Created by Dylan Bui on 11/15/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "DbRangeSlider.h"
#import "UIView+LayoutHelper.h"

@interface DbRangeSlider ()

@property (strong, nonatomic) UIImageView *imgBgLowerLabel;
@property (strong, nonatomic) UIImageView *imgBgUpperLabel;

@property(assign, nonatomic) float stepValue;

@end



@implementation DbRangeSlider

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self configureView];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        [self configureView];
    }
    
    return self;
}


- (void)configureView
{
    // -- Update regular frame -- 
    CGRect frame = (CGRect){self.origin, self.width, 65};
    self.frame = frame;
    self.backgroundColor = [UIColor blueColor];
    
    self.lowerLabel = [[UILabel alloc] init];
    self.lowerLabel.frame = (CGRect){0, 0, 30, 30};
    //self.lowerLabel.backgroundColor = [UIColor yellowColor];
    self.lowerLabel.font = [UIFont systemFontOfSize:14.5f];
    self.lowerLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.lowerLabel];
    
    self.upperLabel = [[UILabel alloc] init];
    self.upperLabel.frame = (CGRect){0, 0, 30, 30};
    //self.upperLabel.backgroundColor = [UIColor blueColor];
    self.upperLabel.font = [UIFont systemFontOfSize:14.5f];
    self.upperLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.upperLabel];
    
    UIImage *imgBg = [UIImage imageNamed:@"db_slider_text_bg"];
    self.imgBgLowerLabel = [[UIImageView alloc] initWithImage:imgBg];
    self.imgBgLowerLabel.frame = (CGRect){0, 0, imgBg.size};
    [self addSubview:self.imgBgLowerLabel];
    [self sendSubviewToBack:self.imgBgLowerLabel];
    
    self.imgBgUpperLabel = [[UIImageView alloc] initWithImage:imgBg];
    self.imgBgUpperLabel.frame = (CGRect){0, 0, imgBg.size};
    [self addSubview:self.imgBgUpperLabel];
    [self sendSubviewToBack:self.imgBgUpperLabel];
    
    // chieu cao toan bo 65
    self.labelSlider = [[NMRangeSlider alloc] initWithFrame:(CGRect){0, 30, self.width, 35}];
    self.labelSlider.minimumValue = 1.0;
    self.labelSlider.maximumValue = 100.0;
    self.labelSlider.lowerValue = 1.0;
    self.labelSlider.upperValue = 100.0;
    self.labelSlider.minimumRange = 5.0;
    [self.labelSlider removeTarget:self action:@selector(labelSliderChanged:) forControlEvents:UIControlEventValueChanged];
    [self.labelSlider addTarget:self action:@selector(labelSliderChanged:) forControlEvents:UIControlEventValueChanged];
    
    UIImage* image = nil;
    image = [UIImage imageNamed:@"db_slider_handle"];
    image = [image imageWithAlignmentRectInsets:UIEdgeInsetsMake(-1, 2, 1, 2)];
    self.labelSlider.lowerHandleImageNormal = image;
    self.labelSlider.lowerHandleImageHighlighted = image;
    self.labelSlider.upperHandleImageNormal = image;
    self.labelSlider.upperHandleImageHighlighted = image;
    
    [self addSubview:self.labelSlider];
    
    [self.labelSlider layoutIfNeeded];
    
    [self updateSliderLabels];
    
    [self layoutIfNeeded];
}

- (void)updateSliderLabels
{
    // You get get the center point of the slider handles and use this to arrange other subviews
    
    CGPoint lowerCenter;
    lowerCenter.x = (self.labelSlider.lowerCenter.x + self.labelSlider.frame.origin.x);
    lowerCenter.y = (self.labelSlider.center.y - 27.0f);
    self.lowerLabel.center = lowerCenter;
    self.lowerLabel.text = [NSString stringWithFormat:@"%d", (int)self.labelSlider.lowerValue];
    if (self.delegate && [self.delegate respondsToSelector:@selector(updateTextForLowerLabel:lowerValue:)])
        [self.delegate updateTextForLowerLabel:self lowerValue:self.labelSlider.lowerValue];
    
    self.imgBgLowerLabel.center = CGPointMake(lowerCenter.x, self.labelSlider.center.y - 24.0f);
    
    CGPoint upperCenter;
    upperCenter.x = (self.labelSlider.upperCenter.x + self.labelSlider.frame.origin.x);
    upperCenter.y = (self.labelSlider.center.y - 27.0f);
    self.upperLabel.center = upperCenter;
    self.upperLabel.text = [NSString stringWithFormat:@"%d", (int)self.labelSlider.upperValue];
    if (self.delegate && [self.delegate respondsToSelector:@selector(updateTextForUpperLabel:upperLabel:)])
        [self.delegate updateTextForUpperLabel:self upperLabel:self.labelSlider.upperValue];
    
    self.imgBgUpperLabel.center = CGPointMake(upperCenter.x, self.labelSlider.center.y - 24.0f);
}

- (IBAction)labelSliderChanged:(NMRangeSlider*)sender
{
    [self updateSliderLabels];
}

- (void)updateSliderValue
{
    _stepValue = (self.maximumValue - self.minimumValue) / 100;
    
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

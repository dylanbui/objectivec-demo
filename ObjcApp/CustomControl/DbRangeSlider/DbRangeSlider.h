//
//  DbRangeSlider.h
//  ObjcApp
//
//  Created by Dylan Bui on 11/15/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NMRangeSlider.h"

@protocol DbRangeSliderDelegate;

@interface DbRangeSlider : UIView

@property (weak) id <DbRangeSliderDelegate> delegate;

@property (strong, nonatomic) NMRangeSlider *labelSlider;
@property (strong, nonatomic) UILabel *lowerLabel;
@property (strong, nonatomic) UILabel *upperLabel;

//- (IBAction)labelSliderChanged:(NMRangeSlider*)sender;

// default 0.0
@property(assign, nonatomic) float minimumValue;

// default 1.0
@property(assign, nonatomic) float maximumValue;

// default 0.0. This is the minimum distance between between the upper and lower values
//@property(assign, nonatomic) float minimumRange;

// default 0.0 (disabled)
//@property(assign, nonatomic) float stepValue;

- (void)updateSliderValue;

- (void)updateSliderLabels;

@end


@protocol DbRangeSliderDelegate <NSObject>

@required

- (NSString *)updateTextForLowerLabel:(DbRangeSlider *)rangeSlider lowerValue:(float)value;
- (NSString *)updateTextForUpperLabel:(DbRangeSlider *)rangeSlider upperLabel:(float)value;

@end

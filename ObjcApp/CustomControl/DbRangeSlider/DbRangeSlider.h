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

- (void)updateSliderLabels;

@end


@protocol DbRangeSliderDelegate <NSObject>

@required

- (NSString *)updateTextForLowerLabel:(DbRangeSlider *)rangeSlider lowerValue:(float)value;
- (NSString *)updateTextForUpperLabel:(DbRangeSlider *)rangeSlider upperLabel:(float)value;

@end

//
//  DbRangeSlider.h
//  ObjcApp
//
//  Created by Dylan Bui on 11/15/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NMRangeSlider.h"

@interface DbRangeSlider : UIView

@property (strong, nonatomic) NMRangeSlider *labelSlider;
@property (strong, nonatomic) UILabel *lowerLabel;
@property (strong, nonatomic) UILabel *upperLabel;

//- (IBAction)labelSliderChanged:(NMRangeSlider*)sender;

@end

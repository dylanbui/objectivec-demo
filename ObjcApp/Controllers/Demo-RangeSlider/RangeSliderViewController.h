//
//  RangeSliderViewController.h
//  ObjcApp
//
//  Created by Dylan Bui on 11/15/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "BaseViewController.h"
#import "NMRangeSlider.h"
#import "DbRangeSlider.h"

@interface RangeSliderViewController : BaseViewController

@property (weak, nonatomic) IBOutlet NMRangeSlider *labelSlider;
@property (weak, nonatomic) IBOutlet UILabel *lowerLabel;
@property (weak, nonatomic) IBOutlet UILabel *upperLabel;

- (IBAction)labelSliderChanged:(NMRangeSlider*)sender;


@property (weak, nonatomic) IBOutlet DbRangeSlider *dbSlider;


@end

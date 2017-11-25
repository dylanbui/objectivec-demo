//
//  DbErrorView.h
//  PropzyDiy
//
//  Created by Dylan Bui on 11/15/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface DbErrorView : UIView

@property (nonatomic, strong) UIImageView *imgError;
@property (nonatomic, strong) UILabel *lblTitle;


- (void)errorEmptyData;
- (void)errorNetworkConnection;


@end

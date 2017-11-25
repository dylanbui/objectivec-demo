//
//  DbErrorView.m
//  PropzyDiy
//
//  Created by Dylan Bui on 11/15/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "DbErrorView.h"
#import "DbConstant.h"
#import "Masonry.h"

@interface DbErrorView ()

@end

@implementation DbErrorView

- (id)init
{
    self = [self initWithFrame:(CGRect){0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/2}];
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createLayout];
    }
    return self;
}

- (void)createLayout
{
    self.imgError = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"db_ic_empty_data.png"]];
    [self addSubview:self.imgError];
    // -- Make constraints after addSubview --
    [self.imgError mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.centerX.equalTo(self.mas_centerX);
//        make.width.equalTo(@48);
//        make.height.equalTo(@48);
    }];
    
    self.lblTitle = [[UILabel alloc] init];
    [self.lblTitle setTextAlignment:NSTextAlignmentCenter];
    [self.lblTitle setTextColor:[[UIColor grayColor] colorWithAlphaComponent:0.6]];
    [self.lblTitle setNumberOfLines:0];
    [self addSubview:self.lblTitle];
    // -- Make constraints after addSubview --
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgError.mas_bottom).with.offset(12.0);
        //        make.leading.equalTo(@15);
        //        make.trailing.equalTo(@-15);
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.height.greaterThanOrEqualTo(@21);
    }];
}

// tell UIKit that you are using AutoLayout
+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}

// this is Apple's recommended place for adding/updating constraints
- (void)updateConstraints
{
    // --- remake/update constraints here
//    [self.imgError mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(@0);
//        make.centerX.equalTo(self.mas_centerX);
////        make.width.equalTo(@48);
////        make.height.equalTo(@48);
//    }];
//    
//    [self.lblTitle mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.imgError.mas_bottom).with.offset(12.0);
////        make.leading.equalTo(@15);
////        make.trailing.equalTo(@-15);
//        make.left.equalTo(self).offset(15);
//        make.right.equalTo(self).offset(-15);
//        make.height.greaterThanOrEqualTo(@21);
//    }];
    
    //according to apple super should be called at end of method
    [super updateConstraints];
}

- (void)errorEmptyData
{
    self.imgError.image = [UIImage imageNamed:@"db_ic_empty_data.png"];
    self.lblTitle.text = @"Chưa có dữ liệu";
    //[self needsUpdateConstraints];
}

- (void)errorNetworkConnection
{
    self.imgError.image = [UIImage imageNamed:@"db_ic_error_wifi.png"];
    self.lblTitle.text = @"Kiểm tra lại kết nối mạng của thiết bị";
    //[self needsUpdateConstraints];
}

@end

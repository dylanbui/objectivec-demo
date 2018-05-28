//
//  PzTextField.m
//  ObjcApp
//
//  Created by Dylan Bui on 5/22/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import "PzTextField.h"
#import "DbFontAwesomeKit.h"

@interface PzTextField()

@property (nonatomic, copy) PzTextFieldTouch touchHandler;

@property (nonatomic, strong) UIImage *iconAngleDown;

@end

@implementation PzTextField

- (instancetype)init
{
    if (self = [super init]) {
        [self initView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self initView];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)initView
{
    [self drawBorderWithColor:[UIColor grayColor] borderWidth:1.0 cornerRadius:5.0];
    self.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    DbFontAwesome *icon = [DbFontAwesome angleDownIconWithSize:25];
//    Setting Attributes for An Icon
    [icon addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor]];
//    Drawing The Icon on Image
    self.iconAngleDown = [icon imageWithSize:CGSizeMake(25, 25)];
    
}

- (void)touchInside:(PzTextFieldTouch)touchHandler
{
    self.touchHandler = touchHandler;
    
    [self addRightViewWithImage:[[UIImageView alloc] initWithImage:self.iconAngleDown]
                     andPadding:10.0];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = (CGRect){0, 0, self.frame.size};
    btn.backgroundColor = [UIColor clearColor];
    btn.titleLabel.text = @"";
    [btn setBackgroundImage:[DbUtils colorImageWithColor:[DbUtils colorWithHexString:@"#f5f5f5"]]
                   forState:UIControlStateHighlighted];
    // add targets and actions
    [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
}

- (IBAction)buttonClicked:(id)sender
{
    if (self.touchHandler != nil) {
        self.touchHandler(self);
    }
}



@end

//
//  UITextField+PasswordField.m
//  R to L
//
//  Created by ndot on 26/08/15.
//  Copyright (c) 2015 Ktr. All rights reserved.
//

#import "UITextField+PasswordField.h"


@implementation UITextField (PasswordField)

- (void)addPasswordField
{
    self.rightViewMode = UITextFieldViewModeWhileEditing;
    self.secureTextEntry = YES;
    
    UIButton *showTextBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    showTextBtn.frame = CGRectMake(0, 0, 30, 30);
    [showTextBtn setImage:[UIImage imageNamed:@"ic_hide_password.png"] forState:UIControlStateNormal];
    [showTextBtn addTarget:self action:@selector(touchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [showTextBtn setTitleColor:[UIColor colorWithWhite:0 alpha:0.54] forState:UIControlStateNormal];
    [showTextBtn setTintColor:[UIColor colorWithWhite:1 alpha:0.54]];
    [self setRightView:showTextBtn];
}

- (IBAction)touchUpInside:(id)sender
{
    UIButton *hideShow = (UIButton *)self.rightView;
    if (!self.secureTextEntry)
    {
        self.secureTextEntry = YES;
        [hideShow setImage:[UIImage imageNamed:@"ic_hide_password.png"] forState:UIControlStateNormal];
    }
    else
    {
        self.secureTextEntry = NO;
        [hideShow setImage:[UIImage imageNamed:@"ic_show_password.png"] forState:UIControlStateNormal];
    }
    [self becomeFirstResponder];
}

@end

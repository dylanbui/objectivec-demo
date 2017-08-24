//
//  UserSessionViewController.m
//  ObjcApp
//
//  Created by Dylan Bui on 8/24/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "UserSessionViewController.h"

@interface UserSessionViewController ()

@end

@implementation UserSessionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"Session";
    
    NSString *strJson = [self.userSession om_mapToJSONString];
    
    NSLog(@"1 = %@", strJson);
    
    NSLog(@"%@", [self.userSession getExtendDataForKey:@"key_1"]);

    
    self.userSession.name = @"Bui Van Tien Duc";
    self.userSession.email = @"tienduc@yahoo.com";
    self.userSession.phone = @"123456789";
    
    [self.userSession saveDataFromLastSession];
    
    
}


- (IBAction)btnClick:(UIButton *)sender
{
    NSString *strJson = [self.userSession om_mapToJSONString];
    
    NSLog(@"2 = %@", strJson);
    
    
    [self.userSession setExtendData:@"Gia tri moi" forKey:@"key_1"];
    
    
    strJson = [self.userSession om_mapToJSONString];
    
    NSLog(@"3 = %@", strJson);
    
    [self.userSession saveDataFromLastSession];
    
}


@end

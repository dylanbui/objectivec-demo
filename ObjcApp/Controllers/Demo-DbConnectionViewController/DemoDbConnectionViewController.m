//
//  DemoDbConnectionViewController.m
//  ObjcApp
//
//  Created by Dylan Bui on 12/28/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "DemoDbConnectionViewController.h"

@interface DemoDbConnectionViewController ()

@end

@implementation DemoDbConnectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
   
}

- (IBAction)btnTest_Click:(id)sender
{
    DbConnection *conn = [DbConnection instance];
    
    DbRequest *request = [[DbRequest alloc] init];
    request.requestUrl = @"http://124.158.14.32:8080/diy/api/user/signIn";
    request.method = DBRQ_POST;
    request.dictParams  = @{@"email": @"ninhtrang@gmail.com",
                            @"password": @"chunha2017",
                            @"type": @"normal",
                            @"osName": @"iOS",
                            @"deviceToken": @"notuser659ef7634ff919e6a866aab41b7bc60039339ac8cd85b90c888fb"};
    
    DbResponse *response = [[DbResponse alloc] init];
    response.responseType = DBRP_JSON;
    
    [conn dispatchRequest:request onResponse:response withDelegate:self];
}

- (void)onRequest:(DbRequest *)request completeWithResponse:(DbResponse *)response
{
    if (!response.result) {
        NSLog(@"%@", @"Co loi xay ra ne");
    }
    
    NSLog(@"[response description] = %@", [response description]);
    
}

- (void)onRequest:(DbRequest *)request withError:(NSError*)error
{
    NSLog(@"[error description] = %@", [error description]);
}



@end

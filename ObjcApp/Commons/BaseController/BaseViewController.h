//
//  BaseViewController.h
//  PhotoManager
//
//  Created by Dylan Bui on 12/16/16.
//  Copyright © 2016 Dylan Bui. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Constant.h"
#import "DbViewController.h"
#import "UserSession.h"

@class RootViewController;

@interface BaseViewController : DbViewController {
}

- (void)initLoadDataForController:(id)params;

@property (nonatomic, strong) UserSession * userSession;

@end


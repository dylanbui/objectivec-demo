//
//  TBTabbarViewController.h
//  ObjcApp
//
//  Created by Dylan Bui on 9/28/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DbViewController.h"


@interface TBTabbarViewController : DbViewController <UITabBarControllerDelegate> {
    int lastIndex;
    UITabBarController *tabBarController;
}


@end

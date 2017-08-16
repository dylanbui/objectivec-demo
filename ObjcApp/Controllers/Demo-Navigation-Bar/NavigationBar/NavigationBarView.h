//
//  NavigationBarView.h
//  TestApp
//
//  Created by Dylan Bui on 8/7/17.
//  Copyright © 2017 Dylan Bui. All rights reserved.
//

#import "DbNavigationBarView.h"

@interface NavigationBarView : DbNavigationBarView

@property (weak, nonatomic) IBOutlet UILabel *lblSecondTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblMainTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnCustom;

@end

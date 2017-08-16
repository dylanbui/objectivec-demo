//
//  BaseTableViewCell.h
//  PropzyTenant
//
//  Created by Dylan Bui on 6/9/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DbConstant.h"

@interface DbTableViewCell : UITableViewCell

@property (nonatomic, assign) float rowHeight;
@property (nonatomic, strong) NSDictionary *dictCellData;
@property (nonatomic, strong) HandleControlAction handleControlAction;

@property (weak) id <ICallbackParentDelegate> callbackParentDelegate;

- (void)reloadCellData:(NSDictionary *)cellData;

@end

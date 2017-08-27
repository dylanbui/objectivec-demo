//
//  TableExpandCellViewController.h
//  ObjcApp
//
//  Created by Dylan Bui on 8/26/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "BaseViewController.h"

@interface TableExpandCellViewController : BaseViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tblContent;

@end

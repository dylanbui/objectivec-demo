//
//  TableViewCell.h
//  SomoDemo
//
//  Created by 向小辉 on 2017/11/25.
//  Copyright © 2017年 KINX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Somo.h"

@interface TableViewCell : UITableViewCell<SomoSkeletonLayoutProtocol>

@property (assign, nonatomic) BOOL shouldLoading;

@end

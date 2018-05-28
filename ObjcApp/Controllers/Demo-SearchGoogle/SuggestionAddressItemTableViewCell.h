//
//  AddressTableViewCell.h
//  ObjcApp
//
//  Created by Dylan Bui on 4/9/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuggestionAddressItemTableViewCell: UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblMainAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblSubAddress;
@property (weak, nonatomic) IBOutlet UIImageView *imgIcon;
@property (weak, nonatomic) IBOutlet UILabel *lblLineBottom;

@end

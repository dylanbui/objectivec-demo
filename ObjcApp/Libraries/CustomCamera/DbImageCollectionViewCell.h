//
//  ImageCollectionViewCell.h
//  CustomCamera
//
//  Created by Thuý on 5/10/17.
//  Copyright © 2017 Propzy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DbImageCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgContent;
@property (weak, nonatomic) IBOutlet UIImageView *imgSelected;

@end

//
//  DemoTextSearchGGViewController.h
//  ObjcApp
//
//  Created by Dylan Bui on 4/9/18.
//  Copyright © 2018 Propzy Viet Nam. All rights reserved.
//

#import "BaseViewController.h"
#import "MVPlaceSearchTextField.h"

@interface DemoTextSearchGGViewController : BaseViewController <PlaceSearchTextFieldDelegate>

@property (weak, nonatomic) IBOutlet MVPlaceSearchTextField *txtAutoCompletePlace;

@end

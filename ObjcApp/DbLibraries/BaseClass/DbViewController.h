//
//  BaseViewController.h
//  PhotoManager
//
//  Created by Dylan Bui on 12/16/16.
//  Copyright © 2016 Dylan Bui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "DbHeader.h"


@interface DbViewController : UIViewController <ICallbackParentDelegate, IDbWebConnectionDelegate, UITableViewDelegate, UITableViewDataSource,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate> {
    
}


@property (nonatomic, strong) NSMutableDictionary* stranferParams;
@property (strong) AppDelegate *appDelegate;
@property (weak) id <ICallbackParentDelegate> callbackParentDelegate;


@property (nonatomic) BOOL isLoadingDataSource;

@property (weak, nonatomic) IBOutlet UITableView *tblContent;

@property (nonatomic) float verticalOffsetForEmptyDataSet;
@property (nonatomic, strong) NSString  *titleForEmptyDataSet;
@property (nonatomic, strong) UIImage *defaultImageForEmptyDataSet;


- (void)initLoadDataForController:(id)params;

// Hold => error
- (void)navigationBarHiddenForThisController;




@end


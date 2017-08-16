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


//#import "AppDelegate.h"
//#import "Utils.h"
//#import "UserSession.h"
//#import "ResponseObject.h"
//#import "WebConnection.h"

//@class RootViewController;

@interface DbViewController : UIViewController <ICallbackParentDelegate, IDbWebConnectionDelegate> {
    UIBarButtonItem *backButton;
@protected
    NSMutableDictionary *stranferParams;
    AppDelegate *appDelegate;    
}



- (void)initLoadDataForController:(id)params;

//@property (nonatomic, strong) UserSession * userSession;
@property (nonatomic, strong) NSMutableDictionary* stranferParams;
@property (strong) AppDelegate *appDelegate;
@property (weak) id <ICallbackParentDelegate> callbackParentDelegate;

@end


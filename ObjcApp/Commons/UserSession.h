//
//  UserSession.h
//  PropzySam
//
//  Created by Dylan Bui on 1/6/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "DbAppSession.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SearchSession.h"

@interface UserSession : DbAppSession

@property (strong, nonatomic) NSString      *objectType;

@property (strong, nonatomic) NSString      *accountId;
@property (strong, nonatomic) NSString      *socialUid;
@property (strong, nonatomic) NSString      *userTypeId;
@property (strong, nonatomic) NSString      *userTypeName;
@property (assign, nonatomic) int           userType;

@property (nonatomic, strong) UIImage      *imgAvatar;

@property (nonatomic, strong) SearchSession      *searchSession;


+ (id)instance;

- (void)sessionStart;

- (bool)isLogin;

- (void)doLogout;

- (void)setLoginUserData:(NSDictionary *)dataUser;

- (void)synchronizeUserData;



@end

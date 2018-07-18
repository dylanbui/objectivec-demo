//
//  Constant.h
//  SAM_Demo
//
//  Created by Dylan Bui on 12/28/16.
//  Copyright © 2016 Dylan Bui. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

#ifdef DEBUG
// debug only code
#define DEBUG_MODE          1
#else
// release only code
#define DEBUG_MODE          0
#endif

#pragma mark - Facebook

#define FACEBOOK_GRAPH_PICTURE_FORMAT   @"https://graph.facebook.com/%@/picture?type=large"

#define FB_SIGNIN_RESULT_KEY            @"FB_SIGNIN_RESULT_KEY"


#define LOS_ANGELES_POINT CLLocationCoordinate2DMake(34.0204989, -118.4117325)
#define ORANGE_COUNTY_POINT CLLocationCoordinate2DMake(33.6670191,-117.7646825)

/***************** Base Color *****************/
#define ORANGE_COLOR [UIColor colorWithRed:0.97f green:0.46f blue:0.06f alpha:1]
#define BLUE_COLOR [UIColor colorWithRed:0.007f green:0.24f blue:0.764f alpha:1]
#define GREY_COLOR [UIColor colorWithRed:0.474f green:0.474f blue:0.474f alpha:1]

#define CHECK_VERSION_RESULT                         @"versionAppStore"




// -- New define --

// Define font

#define fOpenSans(font_size)                    [UIFont fontWithName:@"OpenSans" size:[font_size doubleValue]]
#define fOpenSansSemibold(font_size)            [UIFont fontWithName:@"OpenSans-Semibold" size:[font_size doubleValue]]
#define fFontAwesome(font_size)                 [UIFont fontWithName:@"FontAwesome" size:[font_size float]]

#define MAX_RIGHT_VIEWCONTROLLER SCREEN_WIDTH - 60
#define MIN_RIGHT_VIEWCONTROLLER SCREEN_WIDTH - 60
#define MAX_LEFT_VIEWCONTROLLER SCREEN_WIDTH - 60
#define MIN_LEFT_VIEWCONTROLLER SCREEN_WIDTH - 60

// -- Define font --
#define FONT_NAVIGATION_TITLE_BAR [UIFont fontWithName:@"OpenSans-Semibold" size:14.5f]

#define LIB_DIR @"image_libs"
//#define DATA_FILE @"photo_ice.plist"
#define FORMAT_IMG_NAME @"yyyy_MM_dd_HH_mm_ss"

//#define APP_FORMAT_DATE @"yyyy-MM-dd HH:mm:ss"
//#define SQLITE_FORMAT_DATE @"%Y-%m-%d %H:%M:%S"

#define AVATAR_SIZE  CGSizeMake(500, 500)

#define UPLOAD_PHOTO_WIDTH  1798
#define UPLOAD_PHOTO_HEIGHT 1011

// Chinh xac nhat
#define PROPZY_LOCATION CLLocationCoordinate2DMake(10.764261, 106.656312)
#define PROPZY_LAT 10.764261
#define PROPZY_LONG 106.656312

#define DEMO_AREA_northEast CLLocationCoordinate2DMake(10.814090, 106.684093)
#define DEMO_AREA_southWest CLLocationCoordinate2DMake(10.707662, 106.622097)
#define DEMO_AREA_southEast CLLocationCoordinate2DMake(10.707662, 106.684093)
#define DEMO_AREA_northWest CLLocationCoordinate2DMake(10.814090, 106.622097)


#define DEBUG_WEB_SERVICE 1 // 0 = NO ; 1 = YES
//#define DEBUG_WEB_SERVICE 0 // 0 = NO ; 1 = YES

//#define ENVIRONMENT_APP 1 // Develop model
#define ENVIRONMENT_APP 2 // Test model
//#define ENVIRONMENT_APP 3 // Production model

#if ENVIRONMENT_APP == 1 // Develop model

    #define FACEBOOK_ID             @"498695030305903"
    #define GOOGLE_SERVICE_API_KEY  @"AIzaSyDiMjnPpWQWVXndV-E1WnfEuW1g593BLhg"
    #define GOOGLE_PLACES_API_KEY   @"AIzaSyD4thxU1wx7wEJT0G7twiBvlFae2XEUK6M"

    #define API_BASE_URL            @"http://124.158.14.30:8080/diy/api" // Develop Server
    #define UPLOAD_PHOTO_BASE_URL   @"http://124.158.14.30:8080/file/api" // Develop Server

    #define PRODUCT_URL             @"http://develop.agents.propzy.vn/"
    #define SHARE_PRODUCT_URL       @"http://develop.propzy.vn/"

    #define MEDIA_URL               @"http://develop.cdn.propzy.vn/media_test/%@"

#elif ENVIRONMENT_APP == 2 // Test model

    #define FACEBOOK_ID             @"437726473074188"
    #define GOOGLE_SERVICE_API_KEY  @"AIzaSyDiMjnPpWQWVXndV-E1WnfEuW1g593BLhg"
    #define GOOGLE_PLACES_API_KEY   @"AIzaSyD4thxU1wx7wEJT0G7twiBvlFae2XEUK6M"

    #define API_BASE_URL            @"http://124.158.14.32:8080/diy/api" // Test Server
    #define UPLOAD_PHOTO_BASE_URL   @"http://124.158.14.32:8080/file/api" // Test Server

    #define PRODUCT_URL             @"http://agents.propzy.vn/"
    #define SHARE_PRODUCT_URL       @"http://propzy.vn/"

    #define MEDIA_URL               @"http://cdn.propzy.vn/media/%@"

#elif ENVIRONMENT_APP == 3 // Production model

    #define FACEBOOK_ID             @"437726473074188"
    #define GOOGLE_SERVICE_API_KEY  @"AIzaSyDiMjnPpWQWVXndV-E1WnfEuW1g593BLhg"
    #define GOOGLE_PLACES_API_KEY   @"AIzaSyD4thxU1wx7wEJT0G7twiBvlFae2XEUK6M"

    // Thong tin server moi
    #define API_BASE_URL            @"http://124.158.14.22:9090/diy/api" // Production Server
    // #define UPLOAD_PHOTO_BASE_URL   @"http://124.158.14.26:9090/file/api" // Production Server =>  dang bi loi, chet server
    #define UPLOAD_PHOTO_BASE_URL   @"http://124.158.14.61:9090/file/api" // Production Server


    // van con xai server production cu
//    #define API_BASE_URL            @"http://112.213.94.242:8080/diy/api" // Production Server
//    #define UPLOAD_PHOTO_BASE_URL   @"http://112.213.94.242:8080/file/api" // Production Server

    #define PRODUCT_URL             @"http://agents.propzy.vn/"
    #define SHARE_PRODUCT_URL       @"http://propzy.vn/"

    #define MEDIA_URL               @"http://cdn.propzy.vn/media/%@"

#endif

#define DEFAULT_LS_PHONE            @"0873066099"
#define DEFAULT_TM_PHONE            @"0873066099"

#define FORMAT_DATE_SECOND @"dd/MM/YYYY"
#define FORMAT_DATE @"d/M/Y"
#define FORMAT_DATETIME @"d/M/Y HH:mm:ss"

#define DEFAULT_AVATAR              @"images/prep.jpg"

//// -- Define Fee --
//#define MANAGEMENT_FEE_ID           1
//#define CLEANING_FEE_ID             5
//#define MOTOR_FEE_ID                2
//#define OTO_FEE_ID                  3

// -- Ban => listingTypeID = 1 --
// -- Ban , khong match toa nha => listingTypeID = 3 --
// -- Thue => listingTypeID = 2 --
// -- Thue , khong match toa nha => listingTypeID = 4 --
#define DEFAULT_CURRENCY            @"VND"
#define FOR_SELL                    1
#define FOR_RENT                    2
#define FOR_SELL_DONT_MATCH         3
#define FOR_RENT_DONT_MATCH         4
//
//// -- For SELL --
//#define CHUNG_CU_SELL               8
//#define BIET_THU_SELL               9
//#define NHA_RIENG_SELL              11
//#define PROJECT_SELL                12
//#define GROUND_SELL                 13
//
//// -- For RENT --
//#define CHUNG_CU                    1
//#define NHA_RIENG_LIVE              2
//#define BIET_THU_LIVE               3
//
//#define VAN_PHONG                   4
//#define NHA_RIENG_BUSS              5
//#define BIET_THU_BUSS               6
//#define MAT_BANG                    7
//#define PHONG_CHO_THUE              10
//
//
//// -- User type --
//#define CHU_NHA              1
//#define MOI_GIOI             2

//#define MAX_RIGHT_VIEWCONTROLLER 320.0f
//#define MIN_RIGHT_VIEWCONTROLLER 265.0f
////#define MIN_LEFT_VIEWCONTROLLER 265.0f
//#define MIN_LEFT_VIEWCONTROLLER 320.0f

#define NOTIFY_REACHABLE_NETWORK @"NOTIFY_REACHABLE_NETWORK"

#define NOTIFY_FROM_DIY @"NOTIFY_FROM_DIY"
#define UPDATE_BADGE_NOTIFICATION @"UPDATE_BADGE_NOTIFICATION"

#define NOTIFY_RELOAD_LISTING @"NOTIFY_RELOAD_LISTING"
#define NOTIFY_RELOAD_SCHEDULE @"NOTIFY_RELOAD_SCHEDULE"
#define NOTIFY_RELOAD_NOTIFICATION @"NOTIFY_RELOAD_NOTIFICATION"


//typedef enum _NAV {
//    NAV_DASHBOARD = 99,
//    NAV_LOGOUT = 100,
//    NAV_CONTACT = 1,
//    NAV_TASK = 2,
//    NAV_MEETING_SCHEDULE = 3,
//    NAV_COLLECTION = 4,
//    NAV_NOTE = 5,
//    NAV_TRANSACTION = 6,
//    NAV_ORDER = 7,
//    NAV_LISTING = 8,
//    NAV_LISTING_SEARCH = 9,
//    NAV_CHAT = 10
//} NAV;

typedef enum LISTING_STATUS {
    CHO_XET_DUYET = 1,
    CAN_BO_SUNG = 2,
    DANG_RAO = 3,
    DA_GIAO_DICH = 4, // Da ban hoac cho thue
    NGUNG = 5,
    TU_CHOI = 6,
    TRANG_THAI_KHAC = 0
} LISTING_STATUS;



#endif /* Constant_h */

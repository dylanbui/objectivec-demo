#ifndef DbFontIconKit

#define DbFontIconKit

#import "DbKitIcon.h"
#import "DbFontAwesome.h"
//#import "FAKFoundationIcons.h"
//#import "FAKZocial.h"
//#import "FAKIonIcons.h"
//#import "FAKOcticons.h"
//#import "FAKMaterialIcons.h"

/*
 
 Base on : https://github.com/PrideChung/FontAwesomeKit
 
 Creating Icons
    DbFontAwesome *starIcon = [DbFontAwesome starIconWithSize:15];
 
 Creating icons using identifiers
 
    NSError *error;
    DbFontAwesome *starIcon = [DbFontAwesome  iconWithIdentifier:@"fa-star" size:15 error:error];
 
 Setting Attributes for An Icon
 
     [starIcon addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]];
 
 Drawing The Icon on Image
 
     Basic Drawing
     UIImage *iconImage = [starIcon imageWithSize:CGSizeMake(15, 15)];
 
     Drawing Offset
     starIcon.drawingPositionAdjustment = UIOffsetMake(2, 2);
 
     Background Color
     starIcon.drawingBackgroundColor = [UIColor blackColor];
     starIcon.drawingBackgroundColor = UIColor.black
 
 */

#endif

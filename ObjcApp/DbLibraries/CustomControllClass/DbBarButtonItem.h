//
//  DbBarButtonItem.h
//  PropzyDiy
//
//  Created by Dylan Bui on 11/2/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//  Base on : https://github.com/isaaclimdc/ILBarButtonItem

#import <UIKit/UIKit.h>

typedef void (^ DbBarButtonItemBlock)(id sender);

@interface DbBarButtonItem : UIBarButtonItem {
    UIImage *customImage;
    UIImage *customSelectedImage;
    SEL customAction;
    
    DbBarButtonItemBlock barButtonItemBlock;
}

+ (DbBarButtonItem *)barItemWithImage:(UIImage *)image
                        selectedImage:(UIImage *)selectedImage
                           clickBlock:(DbBarButtonItemBlock)clickBlock;

+ (DbBarButtonItem *)barItemWithTitle:(NSString *)title
                           themeColor:(UIColor *)themeColor
                           clickBlock:(DbBarButtonItemBlock)clickBlock;


/**
 * Create and return a new image-based bar button item.
 * @param image The image of the button to show when unselected. Works best with images under 44x44.
 * @param selectedImage The image of the button to show when the button is tapped. Works best with images under 44x44.
 * @param target The target of the selector
 * @param action The selector to perform when the button is tapped
 *
 * @return An instance of the new button to be used like a normal UIBarButtonItem
 */
+ (DbBarButtonItem *)barItemWithImage:(UIImage *)image
                        selectedImage:(UIImage *)selectedImage
                               target:(id)target
                               action:(SEL)action;

/**
 * Create and return a new text-based bar button item (like iOS 7).
 * @param title The title string of the button. These have no length limit,
 * but use wisely.
 * @param themeColor The color of the text, much like an app's "theme" color
 in iOS 7. Note: a gray tint is automatically applied for the "down" state.
 * @param target The target of the selector
 * @param action The selector to perform when the button is tapped
 *
 * @return An instance of the new button to be used like a normal UIBarButtonItem
 */
+ (DbBarButtonItem *)barItemWithTitle:(NSString *)title
                           themeColor:(UIColor *)themeColor
                               target:(id)target
                               action:(SEL)action;

- (void)setTitleButton:(NSString *)title;
- (void)setCustomImage:(UIImage *)image;
- (void)setCustomSelectedImage:(UIImage *)image;

- (void)setCustomAction:(SEL)action;

- (void)setBarButtonItemBlock:(DbBarButtonItemBlock)clickBlock;

@end

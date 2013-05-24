//
//  UIImage+ImageWithUIView.h
//


//////////////////////////////////////// OBJECTIVE ///////////////////////////////////////////////////////
/**
 * ECSlidingViewController is a view controller container for iOS that presents its child view controllers
 * in two layers. It provides functionality for sliding the top view to reveal the views underneath it
 *
 * Using in InitialSlidingViewController for setting a ResultEntryViewController as a top view and a
 * ClassListViewcontroller as a child view
 */
/////////////////////////////////////////////////////////////////////////////////////////////////////////

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface UIImage (ImageWithUIView)
+ (UIImage *)imageWithUIView:(UIView *)view;
@end
//
//  UIThemeManager.h
//  myMARTiPad
//

#import <Foundation/Foundation.h>

@interface UIThemeManager : NSObject {
    
    UIColor *defaultTextColor;
    UIColor *cellBGColor;
    UIColor *cellSelectedBGColor;
    UIColor *cellTextColor;
    UIColor *labelBGColor;
    UIColor *headerSectionBGColor;
    UIColor *headerSectionTextColor;
    UIColor *shadowColor;
    
    UIFont *cellTextFontSize;
}

@property (nonatomic, retain)UIColor *defaultTextColor;
@property (nonatomic, retain)UIColor *cellBGColor;
@property (nonatomic, retain)UIColor *cellSelectedBGColor;
@property (nonatomic, retain)UIColor *cellTextColor;
@property (nonatomic, retain)UIColor *headerSectionBGColor;
@property (nonatomic, retain)UIColor *headerSectionTextColor;
@property (nonatomic, retain)UIColor *labelBGColor;
@property (nonatomic, retain)UIColor *shadowColor;
@property (nonatomic, retain)UIFont *cellTextFontSize;

@end

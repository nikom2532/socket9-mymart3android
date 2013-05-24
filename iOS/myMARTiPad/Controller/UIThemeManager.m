//
//  UIThemeManager.m
//  myMARTiPad
//


#import "UIThemeManager.h"

@implementation UIThemeManager
@synthesize defaultTextColor;
@synthesize cellBGColor;
@synthesize cellSelectedBGColor;
@synthesize cellTextColor;
@synthesize labelBGColor;
@synthesize headerSectionBGColor;
@synthesize headerSectionTextColor;
@synthesize shadowColor;
@synthesize cellTextFontSize;

- (id)init
{
    self = [super init];
    if (self) {
        
        self.defaultTextColor = [UIColor blackColor];
        self.cellBGColor = [UIColor colorWithRed:48.0/255.0 green:53.0/255.0 blue:58.0/255.0 alpha:1.0];
        self.cellSelectedBGColor = [UIColor colorWithRed:106.0/255.0 green:35.0/255.0 blue:45.0/255.0 alpha:1.0];
        self.cellTextColor = [UIColor whiteColor];
        self.labelBGColor = [UIColor clearColor];
        self.headerSectionBGColor = [UIColor colorWithRed:242.0/255.0 green:241.0/255.0 blue:241.0/255.0 alpha:1.0];
        self.headerSectionTextColor = [UIColor colorWithRed:93.0/255.0 green:30.0/255.0 blue:39.0/255.0 alpha:1.0];
        self.shadowColor = [UIColor blackColor];
        
        self.cellTextFontSize = [UIFont boldSystemFontOfSize:15];
    }
    return self;
}

@end

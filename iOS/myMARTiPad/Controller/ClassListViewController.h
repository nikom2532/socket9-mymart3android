//
//  ClassListViewController.h
//  MyMart
//


#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ECSlidingViewController.h"
#import "ResultEntryViewController.h"
#import "CocoaSecurity.h"
#import "ClassList.h"
#import "UnitList.h"
#import "Login.h"
#import "UIThemeManager.h"


@interface ClassListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, ClassListDelegate, UnitListDelegate> {
    
    NSString *classTitle;
    NSIndexPath *selectedIndexPath;
    NSArray *classListArray;
    NSArray *unitListArray;
    BOOL selectedUnit;
    BOOL isAlreadyGetClassList;
    BOOL isUserHasOnlyOneClass;
    
    
    IBOutlet UITableView *classTableView;
    
    IBOutlet UIView *unitTableViewBG;
    IBOutlet UITableView *unitTableView;
    
}

@property (nonatomic, assign) BOOL selectedUnit;

- (IBAction)handleSwipe;


@end

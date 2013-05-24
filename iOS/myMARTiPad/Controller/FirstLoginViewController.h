//
//  FirstLoginViewController.h
//  MyMart
//


#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "MBProgressHUD.h"
#import "DeviceManager.h"
#import "Login.h"
#import "RegisterDevice.h"
#import "UIThemeManager.h"

@interface FirstLoginViewController : UIViewController <UIAlertViewDelegate,UITextFieldDelegate,MBProgressHUDDelegate, LoginDelegate, RegisterDeviceDelegate> {
   
    NSString        *quickpinString;
    NSString        *quickpinStringForCompare;
    NSMutableArray  *quickpinArray;
    
    IBOutlet UIView      *registerQPinView;
    IBOutlet UITextField *usernameTextField;
    IBOutlet UITextField *passwordTextField;
    
    IBOutlet UILabel    *passcodeLabel1;
    IBOutlet UILabel    *passcodeLabel2;
    IBOutlet UILabel    *passcodeLabel3;
    IBOutlet UILabel    *passcodeLabel4;

    IBOutlet UIButton *b0;
    IBOutlet UIButton *b1;
    IBOutlet UIButton *b2;
    IBOutlet UIButton *b3;
    IBOutlet UIButton *b4;
    IBOutlet UIButton *b5;
    IBOutlet UIButton *b6;
    IBOutlet UIButton *b7;
    IBOutlet UIButton *b8;
    IBOutlet UIButton *b9;
    IBOutlet UIButton *bClear;
    
    IBOutlet UILabel *qpinViewStatus;
    IBOutlet UIView  *bgQuickPinAlertView;
    IBOutlet UIActivityIndicatorView *registerActivity;
    
    int count;
    int round;
    
    MBProgressHUD *HUD;
    
}


@end

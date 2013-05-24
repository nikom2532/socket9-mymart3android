//
//  LoginViewController.h
//  MyMart
//


#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "Login.h"
#import "QuickPinLogin.h"

@interface LoginViewController : UIViewController <UIAlertViewDelegate,UITextFieldDelegate, NSURLConnectionDelegate, LoginDelegate, QuickPinLoginDelegate> {
    
    IBOutlet UILabel *passcodeLabel1;
    IBOutlet UILabel *passcodeLabel2;
    IBOutlet UILabel *passcodeLabel3;
    IBOutlet UILabel *passcodeLabel4;
    
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
    
    IBOutlet UIView *quickPinView;
    IBOutlet UIView *UPLoginView;
    IBOutlet UIView *loginView;
    
    IBOutlet UIButton *UPLoginButton;
    IBOutlet UIButton *QPLoginButton;
    
    IBOutlet UITextField *usernameTextField;
    IBOutlet UITextField *passwordTextField;
    
    NSMutableArray *quickpinArray;
    int count;
    
    
    
}

@end

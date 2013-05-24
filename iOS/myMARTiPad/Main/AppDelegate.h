//
//  AppDelegate.h
//  MyMart
//

#import <UIKit/UIKit.h>
#import <CoreFoundation/CoreFoundation.h>
#import "FirstLoginViewController.h"
#import "LoginViewController.h"
#import "InitialSlidingViewController.h"
#import "QuickPinLogin.h"
#import "RegisterDevice.h"
#import "AuthenticateDeviceQuickPinAPI.h"
#import "Login.h"
#import "NSString+HexToByteConverter.h"
#import "StringToHexConvertor.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    
    
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ECSlidingViewController *viewController;
@property (strong, nonatomic) UINavigationController *navigationController;

@end

//
//  AppDelegate.h
//  MyMart
//
//  Created by Komsan Noipitak on 3/15/56 BE.
//  Copyright (c) 2556 Komsan Noipitak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreFoundation/CoreFoundation.h>
#import "FirstLoginViewController.h"
#import "LoginViewController.h"
#import "InitialSlidingViewController.h"
#import "QuickPinLogin.h"
#import "RegisterDevice.h"
#import "AuthenticateDeviceQuickPinAPI.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    
    
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ECSlidingViewController *viewController;
@property (strong, nonatomic) UINavigationController *navigationController;

@end

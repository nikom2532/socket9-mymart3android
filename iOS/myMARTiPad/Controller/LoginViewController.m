//
//  LoginViewController.m
//  MyMart
//
//  Created by Komsan Noipitak on 4/6/56 BE.
//  Copyright (c) 2556 Komsan Noipitak. All rights reserved.
//

#import "LoginViewController.h"


QuickPinLogin *quickPinLogin;
Login *login;

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Initial parameter
    quickpinArray = [[NSMutableArray alloc]init];
    
    // Add UPLoginView to loginview
    [loginView addSubview:UPLoginView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark -
#pragma mark === Calling API ===
#pragma mark -

////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Method name: tapLoginButton
 * Description: This method will be called once tap login button
 * Parameters: -
 */

- (IBAction)tapLoginButton
{
    // Hide keyboard
    [usernameTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
    
    //// Create url to make the request Authenticate API
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginFinished:)
                                                 name:@"login"
                                               object:nil ];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginDidFailWithError:)
                                                 name:@"loginError"
                                               object:nil ];
    //Create model for calling API
    login = [[Login alloc]init];
    [Login sharedInstance];
    [login loginWithUsernameAndPassword:usernameTextField.text :passwordTextField.text];
}

/**
 * Method name: registerDeviceQuickpin:
 * Description: Create model for calling AuthenticateDeviceQuickPinAPI
 * Parameters: quickPin
 */

- (void)registerDeviceQuickpin:(NSString *)quickPin
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(quickPinLoginFinished:)
                                                 name:@"quickPinLogin"
                                               object:nil ];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(quickPinLoginDidFailWithError:)
                                                 name:@"quickPinLoginError"
                                               object:nil ];
    
    // Create model for calling API
    quickPinLogin = [[QuickPinLogin alloc]init];
    [QuickPinLogin sharedInstance];
    [quickPinLogin loginByDeviceQuickPin:quickPin];
    
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark -
#pragma mark === Handler Function ===
#pragma mark -

////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Method name: loginFinished:
 * Description: Sent from model when authenticateAPI has finished loading successfully.
 * Parameters: notification
 */

- (void)loginFinished:(NSNotification *)notification
{
    if (!login.authenticated) {
        // Show alert view and exception message
        
        NSString *message = login.exceptionMessage;
        
        UIAlertView *loginAlertView = [[UIAlertView alloc]initWithTitle:@"Authentication Failed"
                                                                message:message
                                                               delegate:self
                                                      cancelButtonTitle:@"Done"
                                                      otherButtonTitles:nil];
        [loginAlertView show];
        
    }else{
        
        [self dismissModalViewControllerAnimated:YES];
    }
}

/**
 * Method name: quickPinLoginFinished:
 * Description: Sent from model when authenticateDeviceQuickPinAPI has finished loading successfully.
 * Parameters: notification
 */

- (void)quickPinLoginFinished:(NSNotification *)notification
{
    // Authenticated = NO
    if (!quickPinLogin.authenticated) {
        
        NSString *message = quickPinLogin.exceptionMessage;
        
        // Show alertView with message
        UIAlertView *loginAlertView = [[UIAlertView alloc]initWithTitle:@"Authentication Failed"
                                                                message:message
                                                               delegate:self
                                                      cancelButtonTitle:@"Done"
                                                      otherButtonTitles:nil];
        loginAlertView.tag = 1;
        [loginAlertView show];
     
    // Authenticated = YES   
    }else {
        
        [self dismissModalViewControllerAnimated:YES];
    }
    
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark -
#pragma mark === Handle Error Function ===
#pragma mark -

////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Method name: loginDidFailWithError:
 * Description: Sent from model when authenticateAPI fails to load successfully.
 * Parameters: notification
 */

- (void)loginDidFailWithError:(NSNotification *)notification {
    
    NSString *messgage = login.errorMessage;
    
    // Show alertView with error message
    UIAlertView *loginErrorAlertView = [[UIAlertView alloc]initWithTitle:@"No Internet Connection"
                                                                 message:messgage
                                                                delegate:self
                                                       cancelButtonTitle:@"Done"
                                                       otherButtonTitles:nil];
    [loginErrorAlertView show];
}

/**
 * Method name: quickPinLoginDidFailWithError:
 * Description: Sent from model when authenticateDeviceQuickPinAPI fails to load successfully.
 * Parameters: notification
 */

- (void)quickPinLoginDidFailWithError:(NSNotification *)notification {
    
    NSString *messgage = quickPinLogin.errorMessage;
    UIAlertView *loginErrorAlertView = [[UIAlertView alloc]initWithTitle:@"No Internet Connection"
                                                                          message:messgage
                                                                         delegate:self
                                                                cancelButtonTitle:@"Done"
                                                                otherButtonTitles:nil];
    [loginErrorAlertView show];
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark -
#pragma mark === Choose Log in method ===
#pragma mark -

////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Method name: chooseLogin:
 * Description: Check login method (Username/Password od Quick-Pin)
 * Parameters: button
 */

- (IBAction)chooseLogin:(UIButton*)button{
    
    // Tap Login using Username & Password
    if (button.tag == 1) {
        
        [loginView addSubview:UPLoginView];
        [quickpinArray removeAllObjects];
        count = 0;
     
    // Tap Login using Quickpin    
    }else if (button.tag == 2){
        
        [quickpinArray removeAllObjects];
        passcodeLabel1.text = @"";
        passcodeLabel2.text = @"";
        passcodeLabel3.text = @"";
        passcodeLabel4.text = @"";
        
        // Remove UPLoginView from loginView
        [UPLoginView removeFromSuperview];
        
        // And add quickPinView in loginView
        [loginView addSubview:quickPinView];
    }
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark -
#pragma mark === RegisterQPinView Action ===
#pragma mark -

////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Method name: tapPassCodeButton:
 * Description: This method for collecting quickPin and display quickPin view
 * Parameters: button
 */

- (IBAction)tapPassCodeButton:(UIButton *)button
{
        // Tap 0-9 button
        if (button.tag!=10 && count <= 3) {
            
            count++;
            [quickpinArray addObject:[NSString stringWithFormat:@"%i",button.tag]];
        
        // Tap Clear button    
        }else if(button.tag == 10){
            
            if (count >= 0) {
                  count--;
            }
          
            [quickpinArray removeLastObject];
        }
    
        // Check quickpinArray for display passodeLabel
        switch ([quickpinArray count]) {
                
            case 0:
                passcodeLabel1.text = @"";
                passcodeLabel2.text = @"";
                passcodeLabel3.text = @"";
                passcodeLabel4.text = @"";
                break;
            case 1:
                passcodeLabel1.text = @".";
                passcodeLabel2.text = @"";
                passcodeLabel3.text = @"";
                passcodeLabel4.text = @"";
                break;
            case 2:
                passcodeLabel1.text = @".";
                passcodeLabel2.text = @".";
                passcodeLabel3.text = @"";
                passcodeLabel4.text = @"";
                break;
            case 3:
                passcodeLabel1.text = @".";
                passcodeLabel2.text = @".";
                passcodeLabel3.text = @".";
                passcodeLabel4.text = @"";
                break;
            case 4:
                passcodeLabel1.text = @".";
                passcodeLabel2.text = @".";
                passcodeLabel3.text = @".";
                passcodeLabel4.text = @".";
            
                // Run registerDeviceQuickpin() with quick pin
                [self performSelector:@selector(registerDeviceQuickpin:)
                           withObject:[quickpinArray componentsJoinedByString:@""]
                           afterDelay:0.1];
                break;
            default:
                break;
        }
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark -
#pragma mark === Check Touching View ===
#pragma mark -

////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Method name: touchesBegan:withEvent:
 * Description: <#description#>
 * Parameters: touches, event
 */

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch * touch = [touches anyObject];
    
    // Hide keyboard
    if(touch.phase == UITouchPhaseBegan) {
        
        [usernameTextField resignFirstResponder];
        [passwordTextField resignFirstResponder];

    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark -
#pragma mark === UIAlertView Delegate ===
#pragma mark -

////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Method name: alertView:clickedButtonAtIndex:
 * Description: Sent to the delegate when the user clicks a button on an alert view.
 * Parameters: alertView, buttonIndex
 */

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // Tag of alert view == 1
    if (alertView.tag == 1) {
        
        passcodeLabel1.text = @"";
        passcodeLabel2.text = @"";
        passcodeLabel3.text = @"";
        passcodeLabel4.text = @"";
        [quickpinArray removeAllObjects];
    }
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark -
#pragma mark === UITextField Delegate ===
#pragma mark -

////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Method name: textFieldShouldReturn:
 * Description: Asks the delegate if the text field should process the pressing of the return button.
 * Parameters: theTextField
 */

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    
    if (theTextField == usernameTextField) {
        
        [usernameTextField resignFirstResponder];
        [passwordTextField becomeFirstResponder];
        
    } else if (theTextField == passwordTextField) {
        
        [self tapLoginButton];
    }
    return YES;
}


@end

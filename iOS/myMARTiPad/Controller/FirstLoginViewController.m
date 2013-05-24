//
//  FirstLoginViewController.m
//  MyMart
//


#import "FirstLoginViewController.h"

Login *login;
RegisterDevice *registerDevice;
ConfigManager *configManager;
UIThemeManager *uiThemeManager;

@interface FirstLoginViewController ()

@end

@implementation FirstLoginViewController


/**
 * Method name: initWithNibName: bundle:
 * Description: Returns a newly initialized view controller with the nib file in the specified bundle.
 * Parameters: nibNameOrNil, nibBundleOrNil
 */

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    return self;
}


/**
 * Method name: viewDidLoad
 * Description: Called after the controller’s view is loaded into memory.
 * Parameters: -
 */

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    // Initial parameter
    quickpinArray = [[NSMutableArray alloc]init];
    
    // Hide registerActivity in view
    registerActivity.hidden = YES;
    
    configManager = [[ConfigManager alloc]init];
    
}


/**
 * Method name: shouldAutorotateToInterfaceOrientation:
 * Description: Returns a Boolean value indicating whether the view controller supports the specified orientation.
 * Parameters: toInterfaceOrientation
 */

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    // Set landscape orientation
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}


/**
 * Method name: didReceiveMemoryWarning
 * Description: Sent to the view controller when the app receives a memory warning.
 * Parameters: -
 */

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark -
#pragma mark === Calling API ===
#pragma mark -

////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Method name: tapLoginButton
 * Description: This method will be called once tap login button for calling AuthenticateAPI
 * Parameters: -
 */

- (IBAction)tapLoginButton
{
    if ([usernameTextField.text length] > 0 && [passwordTextField.text length] > 0) {
        
        // Hide keyboard
        [usernameTextField resignFirstResponder];
        [passwordTextField resignFirstResponder];
        
        // Add MBProgressHUD to view and show it once tap Log in button
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        HUD.delegate = self;
        [self.view addSubview:HUD];
        [HUD setLabelText:@"Loging in ..."];
        [HUD show:YES];
        
        // Create model for calling Authenticate API
        login = [[Login alloc]init];
        login = [Login sharedInstance];
        login.delegate = self;
        [login loginWithUsernameAndPassword:usernameTextField.text :passwordTextField.text];
        
    }else if ([usernameTextField.text length] == 0 && [passwordTextField.text length] == 0){
        
        NSString *message = configManager.emptyUsernamePassword;
        UIAlertView *loginAlertView = [[UIAlertView alloc]initWithTitle:configManager.authenticationFailed
                                                                message:[NSString stringWithFormat:@"%@",message]
                                                               delegate:self
                                                      cancelButtonTitle:@"Done"
                                                      otherButtonTitles:nil];
        [loginAlertView show];
    }
  
}

/**
 * Method name: registerDeviceQuickpin
 * Description: This method for creating model to call RegisterDeviceQuickPin API
 * Parameters: -
 */

- (void)registerDeviceQuickpin {

    // Get device ID
    NSString *deviceID = [DeviceManager getDeviceID];
    
    // Create model for calling registerDeviceQuickPin API
    registerDevice = [[RegisterDevice alloc]init];
    [RegisterDevice sharedInstance];
    registerDevice.delegate = self;
    [registerDevice registerUserDevice:login.userID :deviceID :quickpinString :registerDevice.alreadyRegistered];

}


////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark -
#pragma mark === Login Delegate ===
#pragma mark -

////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Method name: loginFinished
 * Description: Sent from Login when NetConnection has finished loading successfully.
 * Parameters: -
 */

- (void)loginFinished{
    
    [HUD hide:YES];
    
    if (!login.authenticated) {
        
        // Show alert view login failed
        NSString *message = login.exceptionMessage;
        
        UIAlertView *loginAlertView = [[UIAlertView alloc]initWithTitle:configManager.authenticationFailed
                                                                 message:[NSString stringWithFormat:@"\n%@",message]
                                                                delegate:self
                                                       cancelButtonTitle:@"Done"
                                                       otherButtonTitles:nil];

        //Set tag of alert view = 1
        loginAlertView.tag = 1;
        [loginAlertView show];
        
    }else if (login.authenticated){
        
        ConfigManager *config = [[ConfigManager alloc]init];
        
        // Show alert view for registering device and quickpin
        NSString *message = config.registerDeviceQuickPinMessage;
        
        UIAlertView *registerDeviceAlertView = [[UIAlertView alloc]initWithTitle:@"Register Device ?"
                                                                         message:message
                                                                        delegate:self
                                                               cancelButtonTitle:@"NO"
                                                               otherButtonTitles:@"YES",nil];
        // Set tag of alert view = 2
        registerDeviceAlertView.tag = 2;
        [registerDeviceAlertView show];
        
    }
}


/**
 * Method name: loginDidFailWithError:
 * Description: Sent from Login when a NetConnection fails to load its request successfully.
 * Parameters: notification
 */

- (void)loginDidFailWithError {
    
    [HUD hide:YES];
    NSString *messgage = login.errorMessage;
    UIAlertView *loginErrorAlertView = [[UIAlertView alloc]initWithTitle:configManager.errorMessage
                                                                 message:messgage
                                                                delegate:self
                                                       cancelButtonTitle:@"Done"
                                                       otherButtonTitles:nil];
    [loginErrorAlertView show];
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark -
#pragma mark === RegisterDevice Delegate ===
#pragma mark -

////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Method name: registerDeviceFinished
 * Description: Sent from RegisterDevice when NetConnection has finished loading successfully.
 * Parameters: -
 */

- (void)registerDeviceFinished {
    
    if (registerDevice.registerSuccess) {
        
        [self dismissModalViewControllerAnimated:YES];
        
    }else{
        
        NSString *messgage = registerDevice.exceptionMessage;
        UIAlertView *loginAlertView = [[UIAlertView alloc]initWithTitle:configManager.registerDeviceQuickPinFailed
                                                                message:messgage
                                                               delegate:self
                                                      cancelButtonTitle:@"Done"
                                                      otherButtonTitles:nil];
        loginAlertView.tag = 3;
        [loginAlertView show];
    }
}



/**
 * Method name: registerDeviceDidFailWithError
 * Description: Sent from RegisterDevice when a NetConnection fails to load its request successfully.
 * Parameters: -
 */

- (void)registerDeviceDidFailWithError{
    
    [HUD hide:YES];
    NSString *messgage = registerDevice.errorMessage;
    UIAlertView *registerDeviceErrorAlertView = [[UIAlertView alloc]initWithTitle:configManager.errorMessage
                                                                          message:messgage
                                                                         delegate:self
                                                                cancelButtonTitle:@"Done"
                                                                otherButtonTitles:nil];
    [registerDeviceErrorAlertView show];
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
    
    // Tag of alert view == 2
    if (alertView.tag == 2) {
        
        // Tap on "NO" button
        if(buttonIndex == 0){
            [self dismissModalViewControllerAnimated:YES];
        
        // Tap on "YES" button
        }else{
            
            
            // Use image instead of generate gradientView with code (waiting integrate design)//
            
            // Create gradient view and add to view
            UIView *viewGradient = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 748)];
            CAGradientLayer *gradient = [CAGradientLayer layer];
            gradient.frame = viewGradient.bounds;
            gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor blackColor] CGColor],
                               (id)[[UIColor whiteColor] CGColor], nil]; 
            [viewGradient.layer insertSublayer:gradient atIndex:0];
            viewGradient.alpha = 0.5;
            [self.view addSubview:viewGradient];
            
            ////////////////////////////////////////////////////////////////////////////////////
            
            // Set origin frame of registerQPinView and animated
            registerQPinView.frame = CGRectMake(330, 750, 360, 430);
            registerQPinView.layer.shadowOpacity = 0.75f;
            registerQPinView.layer.shadowRadius = 10.0f;
            registerQPinView.layer.shadowColor = uiThemeManager.shadowColor.CGColor;
            [self.view addSubview:registerQPinView];
            registerQPinView.hidden = NO;
            [UIView animateWithDuration:0.3
                             animations:^{
                                 registerQPinView.frame = CGRectMake(330, 160, 360, 430);}];
            
        }
        
    }else if (alertView.tag == 3){
        
        round = 0;
        qpinViewStatus.text = configManager.insertQuickPin;
        registerActivity.hidden = YES;
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



////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark -
#pragma mark === RegisterQPinView Action ===
#pragma mark -

////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Method name: tapPassCodeButton:
 * Description: For display quickPinView and store quickpin in array of string
 * Parameters: button
 */

- (IBAction)tapPassCodeButton:(UIButton *)button
{
    // Tap 0-9 button
    if (button.tag!=10) {
        count++;
        [quickpinArray addObject:[NSString stringWithFormat:@"%i",button.tag]];
        
    // Tap Clear button
    }else{
        count--;
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
            
            if (round == 0) {
                [self performSelector:@selector(clearTextField) withObject:nil afterDelay:0.5];
         
            }else{
                [self performSelector:@selector(checkQuickPin) withObject:nil afterDelay:0.5];
            }
            break; 
            
        default:
            break;
    }
}

/**
 * Method name: clearTextField
 * Description: Clear text in UITextField
 * Parameters: -
 */

- (void)clearTextField{
    
    // Convert quickpinArray (NSMutableArray) to NSString and remove all objects in quickpinArray
    quickpinStringForCompare = [quickpinArray componentsJoinedByString:@""];
    [quickpinArray removeAllObjects];
    qpinViewStatus.text = @"Please confirm Quick-Pin";
    
    // Clear all passcodeLabel and increase "round"
    passcodeLabel1.text = @"";
    passcodeLabel2.text = @"";
    passcodeLabel3.text = @"";
    passcodeLabel4.text = @"";
    count = 0;
    round++;
}

/**
 * Method name: checkQuickPin
 * Description: Check quickPin that 2 times is match
 * Parameters: -
 */

- (void)checkQuickPin{
    
    round = 0;
    
    //// Check quickpin that input 2 times does match
    
    // Quickpin does match
    if ([[quickpinArray componentsJoinedByString:@""]isEqualToString:quickpinStringForCompare]) {
        
        quickpinString = [quickpinArray componentsJoinedByString:@""];
        qpinViewStatus.text = configManager.registeringQuickPin;
        registerActivity.hidden = NO;
        [registerActivity startAnimating];
        
        // Run registerDeviceQuickpin()
        [self registerDeviceQuickpin];
        
    // Quickpin doesn't match    
    }else{
    
        qpinViewStatus.text = configManager.quickPinNotMatch;
        passcodeLabel1.text = @"";
        passcodeLabel2.text = @"";
        passcodeLabel3.text = @"";
        passcodeLabel4.text = @"";
        [quickpinArray removeAllObjects];
    }
}


/**
 * Method name: cancelRegisterDeviceQuickPin
 * Description: For cancel regiseter device and quickpin
 * Parameters: -
 */

- (IBAction)cancelRegisterDeviceQuickPin{
    
    // Hide RegisterQPinView 
    [self dismissModalViewControllerAnimated:YES];
}





@end

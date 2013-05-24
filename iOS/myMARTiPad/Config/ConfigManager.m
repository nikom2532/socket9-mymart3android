//
//  ConfigManager.m
//  MyMart
//


#import "ConfigManager.h"

@implementation ConfigManager

@synthesize isLogAllowed;
@synthesize logFileName;
@synthesize logFilePath;
@synthesize privateAES256Key;
@synthesize privateSignatureKey;
@synthesize APIServerURL;
@synthesize registerDeviceQuickPinMessage;
@synthesize forceRegisterDeviceQuickPinMessage;
@synthesize errorMessage;
@synthesize authenticationFailed;
@synthesize registerDeviceQuickPinFailed;
@synthesize askToRegisterDeviceQuickPin;
@synthesize quickPinNotMatch;
@synthesize registeringQuickPin;
@synthesize insertQuickPin;
@synthesize emptyUsernamePassword;
@synthesize parameterIsEmpty;


/**
 * Method name: init
 * Description: Implemented by subclasses to initialize a new object (the receiver) immediately after memory 
 * for it has been allocated.
 * Parameters: -
 */

- (id)init
{
    if ( self = [super init] ) {
        
        // Store data for using in application
        privateAES256Key    = @"0DB03F0B8D734F339A22E1FCC31D85BC";
        privateSignatureKey = @"C48BC385-25F5-4CAD-BD2C-7EEA72546FF7";
        APIServerURL        = @"http://mymart3demo.cloudapp.net/MobileService.svc/json/";
        registerDeviceQuickPinMessage = @"\nThis is a first time you have logged into myMART using this device.\nIf this your personal (trusted) device,\nyou may setup a 'Quick-Pin' for esier future access.\n\nIf this is a shared (public) device, please select 'NO'\n\nThankyou";
        
        errorMessage         = @"No Internet Connection";
        authenticationFailed = @"Authentication Failed";
        registerDeviceQuickPinFailed = @"Register Device Quick-Pin Failed";
        
        quickPinNotMatch     = @"Quick-Pin does not match";
        registeringQuickPin  = @"Registering Device and Quick-Pin";
        insertQuickPin       = @"Please insert Quick-Pin";
        emptyUsernamePassword = @"Please fill Username and Password";
        
        parameterIsEmpty = @"Parameter is empty";

    }
    
    return self;
}



@end

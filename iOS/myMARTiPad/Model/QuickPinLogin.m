//
//  QuickPinLogin.m
//  MyMart
//


#import "QuickPinLogin.h"

@implementation QuickPinLogin
@synthesize authenticated;
@synthesize exceptionMessage;
@synthesize userID;
@synthesize errorMessage;
@synthesize delegate;


static QuickPinLogin *sharedInstance = nil;


// For UI
- (id)init
{
    self = [super init];
    
    if (self) {
        
        authenticateDeviceQuickPinAPI = [[AuthenticateDeviceQuickPinAPI alloc]init];
        [authenticateDeviceQuickPinAPI setAPICallBackDelegate:self];
        
    }
    return self;
}

// For unit testing
-(id)init:(id<InterfaceAuthenticateDeviceQuickPinAPI>)api
{
    self = [super init];
    
    if (self) {
        
        authenticateDeviceQuickPinAPI = api;
        [authenticateDeviceQuickPinAPI setAPICallBackDelegate:self];
    }
    return self;
}

+ (QuickPinLogin *)sharedInstance
{
    if (sharedInstance == nil) {
        
        sharedInstance =[[super allocWithZone:NULL]init];
        
    }
    return sharedInstance;
}


/**
 * Method name: allocWithZone:
 * Description: Returns a new instance of the receiving class.
 * Parameters: zone
 * Return: A new instance of the receiver.
 */

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}


/**
 * Method name: copyWithZone:
 * Description: Returns the receiver.
 * Parameters: zone
 * Return: The receiver.
 */

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark -
#pragma mark === Call WebAPIs ===
#pragma mark -

////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Method name: loginByDeviceQuickPin
 * Description: For calling AuthenticateDeviceQuickPin API
 * Parameters: quickPin
 */

- (void)loginByDeviceQuickPin:(NSString *)quickPin {
    
    if ([quickPin length] == 0) {
        
        self.authenticated = false;
        
        ConfigManager *configManager = [[ConfigManager alloc]init];
        self.errorMessage = configManager.parameterIsEmpty;
        
        return;
    }
    
    @try {
        
        [authenticateDeviceQuickPinAPI authenticateDeviceQuickPin:quickPin];
    }
    @catch (NSException *exception) {
        
        LogManager *logManager = [[LogManager alloc]init];
        [logManager writeToLogFile:exception];
    }
    
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark -
#pragma mark === AuthenticateDeviceQuickPinAPI Delegate ===
#pragma mark -

////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Method name: authenticateDeviceQuickPinFinished
 * Description: Sent from AuthenticateDeviceQuickPinAPI when NetConnection has finished calling successfully.
 * Parameters: dictionary
 */

- (void)onAPIFinished:(NSDictionary *)dictionary{
    
    NSDictionary *resultDictionary = dictionary;
    authenticated = [[[resultDictionary objectForKey:@"AuthenticateDeviceQuickPinJsonResult"]
                      objectForKey:@"Authenticated"]boolValue];
    
    //// Check Authenticated result
    
    // Authenticated : False
    if (!authenticated) {
        
        exceptionMessage = [[resultDictionary objectForKey:@"AuthenticateDeviceQuickPinJsonResult"]
                            objectForKey:@"ExceptionMessage"];
        self.exceptionMessage = exceptionMessage;
        self.authenticated = authenticated;
        
        
        // Authenticated : True
    }else{
        
        userID = [[resultDictionary objectForKey:@"AuthenticateDeviceQuickPinJsonResult"]
                  objectForKey:@"UserID"];
        self.userID = userID;
        self.authenticated = authenticated;
        
    }

    [self.delegate quickPinLoginFinished];
}


/**
 * Method name: authenticateAPIFinished
 * Description: Sent from AuthenticateDeviceQuickPinAPI when NetConnection fails to load successfully.
 * Parameters: error
 */

- (void)onAPIDidFailWithError:(NSError *)error {
    
    self.errorMessage = [error localizedDescription];
    [self.delegate quickPinLoginDidFailWithError];
    
}



@end

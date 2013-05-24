//
//  Login.m
//  MyMart
//


#import "Login.h"

@implementation Login
@synthesize authenticated;
@synthesize exceptionMessage;
@synthesize userID;
@synthesize isDeviceAlreadyRegistered;
@synthesize errorMessage;
@synthesize delegate;


static Login *sharedInstance = nil;


// For UI
- (id)init
{
    self = [super init];
    
    if (self) {
        
        authenticateAPI = [[AuthenticateAPI alloc]init];
        [authenticateAPI setAPICallBackDelegate:self];
    }
    return self;
}

// For unit testing

- (id) init: (id <InterfaceAuthenticateAPI>) api
{
    self = [super init];
    
    if (self) {
        
       authenticateAPI = api;
       [authenticateAPI setAPICallBackDelegate:self];
    }
    return self;
}


+ (Login *)sharedInstance
{
    if (sharedInstance == nil) {
        
        sharedInstance = [[super allocWithZone:NULL]init];
    }
    return sharedInstance;
}


/**
 * Method name: allocWithZone:
 * Description: Returns a new instance of the receiving class.
 * Parameters: zone
 * Return: A new instance of the receiver.
 */

+ (id) allocWithZone:(NSZone *)zone
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
 * Method name: loginWithUsernameAndPassword
 * Description: For Calling authenticate API
 * Parameters: username, password
 */

- (void)loginWithUsernameAndPassword:(NSString *)username :(NSString *)password
{
    
    if ([password length] == 0 || [username length] == 0) {
        
        self.authenticated = false;
        
        ConfigManager *configManager = [[ConfigManager alloc]init];
        self.errorMessage = configManager.parameterIsEmpty;

        return;
    }
    
    @try {
   
        [authenticateAPI authenticate:username :password];
    }
    @catch (NSException *exception) {
        
        LogManager *logManager = [[LogManager alloc]init];
        [logManager writeToLogFile:exception];
    }

}

////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark -
#pragma mark === AuthenticateAPI Delegate ===
#pragma mark -

////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Method name: authenticateAPIFinished
 * Description: Sent from AuthenticateAPI when NetConnection has finished calling successfully.
 * Parameters: dictionary
 */

- (void) onAPIFinished:(NSDictionary *)dictionary {

    NSDictionary *resultDictionary = dictionary;
    authenticated = [[[resultDictionary objectForKey:@"AuthenticateJsonResult"]
                                        objectForKey:@"Authenticated"]boolValue];
    
    // Authenticated : False
    if (!authenticated) {
        
        self.authenticated = authenticated;
        exceptionMessage = [[resultDictionary objectForKey:@"AuthenticateJsonResult"]
                                              objectForKey:@"ExceptionMessage"];
        self.exceptionMessage = [[NSString stringWithString:exceptionMessage] copy];
        
        // Authenticated : True
    }else {
        
        self.authenticated = authenticated;
        userID = [[resultDictionary objectForKey:@"AuthenticateJsonResult"]
                  objectForKey:@"UserID"];
        self.userID = userID;
        
    }

    [self.delegate loginFinished];
    
}


/**
 * Method name: authenticateAPIDidFailWithError
 * Description: Sent from AuthenticateAPI when NetConnection fails to load successfully.
 * Parameters: error
 */

- (void)onAPIDidFailWithError:(NSError *)error {
    
    self.errorMessage = [error localizedDescription];
    [self.delegate loginDidFailWithError];
}



@end

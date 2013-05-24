//
//  RegisterDevice.m
//  MyMart
//


#import "RegisterDevice.h"

@implementation RegisterDevice
@synthesize registerSuccess;
@synthesize alreadyRegistered;
@synthesize exceptionMessage;
@synthesize errorMessage;
@synthesize delegate;

// For UI
- (id)init
{
    self = [super init];
    
    if (self) {
        
        registerDeviceQuickPinAPI = [[RegisterDeviceQuickPinAPI alloc]init];
        [registerDeviceQuickPinAPI setAPICallBackDelegate:self];
        
    }
    return self;
}

// For unit testing
- (id)init:(id<InterfaceRegisterDeviceQuickPinAPI>) api
{
    self = [super init];
    
    if (self) {
        
        registerDeviceQuickPinAPI = api;
        [registerDeviceQuickPinAPI setAPICallBackDelegate:self];
    }
    return self;
}

static RegisterDevice *sharedInstance = nil;

+ (RegisterDevice *)sharedInstance
{
    if (sharedInstance == nil) {
        
        sharedInstance = [[super allocWithZone:NULL]init];
        
    }
    return sharedInstance;
}


/**
 * Method name: allocWithZone:
 * Description: Returns the receiver.
 * Parameters: zone
 * Return: The receiver.
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
 * Method name: registerUserDevice
 * Description: For calling RegisterDeviceQuickPin API
 * Parameters: userID, quickPin, deviceID, isForceRegister
 */

- (void)registerUserDevice:(NSString *)userID :(NSString *)quickPin :(NSString *)deviceID :(BOOL)isForceRegister
{
    
    if ([userID length] == 0 || [quickPin length] == 0 ||[deviceID length] == 0) {
        
        self.registerSuccess = false;
        
        ConfigManager *configManager = [[ConfigManager alloc]init];
        self.errorMessage = configManager.parameterIsEmpty;
        
        return;
    }
    
    
    @try {


        [registerDeviceQuickPinAPI  registerDeviceQuickPin:userID :quickPin :deviceID :isForceRegister];
    }
    @catch (NSException *exception) {
        
        LogManager *logManager = [[LogManager alloc]init];
        [logManager writeToLogFile:exception];
        
    }
    
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark -
#pragma mark === RegisterDeviceQuickPinAPI Delegate ===
#pragma mark -

////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Method name: registerDeviceQuickPinFinished
 * Description: Sent from RegisterDeviceQuickPinAPI when NetConnection has finished calling successfully.
 * Parameters: dictionary
 */

- (void)onAPIFinished:(NSDictionary *)dictionary {
    
    NSDictionary *resultDictionary = dictionary;
    registerSuccess = [[[resultDictionary objectForKey:@"RegisterDeviceQuickPinJsonResult"]
                        objectForKey:@"RegisterSuccess"]boolValue];
    
    //// Check Registered result
    // RegisterSuccess : True
    if (registerSuccess) {
        
        alreadyRegistered = [[[resultDictionary objectForKey:@"RegisterDeviceQuickPinJsonResult"]
                              objectForKey:@"AlreadyRegistered"]boolValue];
        self.alreadyRegistered = alreadyRegistered;
        self.registerSuccess = registerSuccess;
        
        // RegisterSuccess : False
    }else{
        
        alreadyRegistered = [[[resultDictionary objectForKey:@"RegisterDeviceQuickPinJsonResult"]
                              objectForKey:@"AlreadyRegistered"]boolValue];
        self.alreadyRegistered = alreadyRegistered;
        exceptionMessage = [[resultDictionary objectForKey:@"RegisterDeviceQuickPinJsonResult"]
                            objectForKey:@"ExceptionMessage"];
        self.exceptionMessage = exceptionMessage;
        self.registerSuccess = registerSuccess;
        
    }

    [self.delegate registerDeviceFinished];
}


/**
 * Method name: authenticateAPIFinished
 * Description: Sent RegisterDeviceQuickPinAPI when NetConnection fails to load successfully.
 * Parameters: error
 */

- (void)onAPIDidFailWithError:(NSError *)error {
    
    self.errorMessage = [error localizedDescription];
    [self.delegate registerDeviceDidFailWithError];

}

@end

//
//  UnitList.m
//  MyMart
//


#import "UnitList.h"

@implementation UnitList
@synthesize unitListSuccess;
@synthesize userUnitList;
@synthesize exceptionMessage;
@synthesize isUserHasOnlyOneUnit;
@synthesize errorMessage;
@synthesize delegate;


static UnitList *sharedInstance = nil;

// For UI
- (id)init
{
    self = [super init];
    
    if (self) {
        
        getUnitListAPI = [[GetUnitListAPI alloc]init];
        [getUnitListAPI setAPICallBackDelegate:self];
        
    }
    return self;
}

// For unit testing
- (id) init:(id<InterfaceGetUnitListAPI>)api
{
    self = [super init];
    
    if (self) {
        
        getUnitListAPI  = api;
        [getUnitListAPI setAPICallBackDelegate:self];
    }
    return self;
}

+ (UnitList *)sharedInstance {
    
    if (sharedInstance==nil) {
        
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
 * Method name: getUnitList
 * Description: For Calling GetUnitList API
 * Parameters: userID, classID
 */

- (void)getUnitList:(NSString *)userID :(NSString *)classID{
    
    if ([userID length] == 0 || [classID length] == 0) {
  
        self.unitListSuccess = false;
        
        ConfigManager *configManager = [[ConfigManager alloc]init];
        self.errorMessage = configManager.parameterIsEmpty;
        
        return;
    }
    
    @try {
        
        [getUnitListAPI getUnitList:userID :classID];
    }
    @catch (NSException *exception) {
        
        LogManager *logManager = [[LogManager alloc]init];
        [logManager writeToLogFile:exception];
    } 
    
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark -
#pragma mark === GetUnitList Delegate ===
#pragma mark -

////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Method name: getUnitListAPIFinished
 * Description: Sent from GetUnitListAPI when NetConnection has finished calling successfully.
 * Parameters: dictionary
 */

- (void)onAPIFinished:(NSDictionary *)dictionary {
    
    NSDictionary *resultDictionary = dictionary;
    unitListSuccess = [[[resultDictionary objectForKey:@"GetUnitListJsonResult"]
                         objectForKey:@"UnitListSuccess"]boolValue];
    
    if (!unitListSuccess) {
        
        self.unitListSuccess = unitListSuccess;
        exceptionMessage = [[resultDictionary objectForKey:@"GetUnitListJsonResult"]
                            objectForKey:@"ExceptionMessage"];
        self.exceptionMessage = [[NSString stringWithString:exceptionMessage] copy];

    }else{
        
        self.unitListSuccess = unitListSuccess;
        self.userUnitList = [[NSArray alloc]init];
        self.userUnitList = [[resultDictionary objectForKey:@"GetUnitListJsonResult"]
                             objectForKey:@"Units"];
        self.userUnitList = userUnitList;
        self.unitListSuccess = YES;
        
        if ([userUnitList count] == 1) {
            self.isUserHasOnlyOneUnit = YES;
        }
        
    }

    [self.delegate unitListFinished];
}


/**
 * Method name: authenticateAPIFinished
 * Description: Sent from GetUnitListAPI when NetConnection fails to load successfully.
 * Parameters: error
 */

- (void)onAPIDidFailWithError:(NSError *)error {
    
    self.errorMessage = [error localizedDescription];
    [self.delegate unitListDidFailWithError];
}


@end

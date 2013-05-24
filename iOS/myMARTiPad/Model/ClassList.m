//
//  ClassList.m
//  MyMart
//


#import "ClassList.h"

@implementation ClassList
@synthesize classListSuccess;
@synthesize reportingPeriod;
@synthesize userClassList;
@synthesize exceptionMessage;
@synthesize isUserHasOnlyOneClass;
@synthesize errorMessage;
@synthesize delegate;

static ClassList *sharedInstance = nil;


// For UI
- (id)init
{
    self = [super init];
    
    if (self) {
        
        getClassListAPI = [[GetClassListAPI alloc]init];
        [getClassListAPI setAPICallBackDelegate:self];
    }
    return self;
}

// For unit testing
-(id)init:(id<InterfaceGetClassListAPI>)api
{
    self = [super init];
    
    if (self) {
        
        getClassListAPI = api;
        [getClassListAPI setAPICallBackDelegate:self];
        
    }
    return self;
}

+ (ClassList *)sharedInstance
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
 * Method name: getClassList
 * Description: For Calling GetClassList API
 * Parameters: userID
 */

- (void)getClassList:(NSString *)userID{
    
    if ([userID length] == 0) {
        
        self.classListSuccess = false;
        
        ConfigManager *configManager = [[ConfigManager alloc]init];
        self.errorMessage = configManager.parameterIsEmpty;
        
        return;
    
    }
    
    @try {
       
        [getClassListAPI getClassList:userID];
        
    }
    @catch (NSException *exception) {
        
        LogManager *logManager = [[LogManager alloc]init];
        [logManager writeToLogFile:exception];
        
    }
    
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark -
#pragma mark === GetClassList Delegate ===
#pragma mark -

////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Method name: getClassListAPIFinished
 * Description: Sent from GetClassListAPI when NetConnection has finished calling successfully. 
 * Parameters: dictionary
 */

- (void)onAPIFinished:(NSDictionary *)dictionary {
    
    NSDictionary *resultDictionary = dictionary;
    classListSuccess = [[[resultDictionary objectForKey:@"GetClassListJsonResult"]
                         objectForKey:@"ClassListSuccess"]boolValue];
    
    if (!classListSuccess) {
        
        self.classListSuccess = classListSuccess;
        exceptionMessage = [[resultDictionary objectForKey:@"GetClassListJsonResult"]
                            objectForKey:@"ExceptionMessage"];
        self.exceptionMessage = [[NSString stringWithString:exceptionMessage]copy];
        
    }else{
        
        self.userClassList = [[NSArray alloc]init];
        self.userClassList = [[resultDictionary objectForKey:@"GetClassListJsonResult"]
                              objectForKey:@"Classes"];
        self.userClassList = userClassList;
        self.classListSuccess = YES;
        
        if ([userClassList count] == 1) {
            self.isUserHasOnlyOneClass = YES;
        }
    }
   

    [self.delegate classListFinished];
}


/**
 * Method name: authenticateAPIFinished
 * Description: Sent from GetClassListAPI when NetConnection fails to load successfully.
 * Parameters: error
 */

- (void)onAPIDidFailWithError:(NSError *)error {
    
    self.errorMessage = [error localizedDescription];
    [self.delegate classListDidFailWithError];
}


@end

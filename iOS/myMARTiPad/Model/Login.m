//
//  Login.m
//  MyMart
//
//  Created by Komsan Noipitak on 4/23/56 BE.
//  Copyright (c) 2556 Komsan Noipitak. All rights reserved.
//

#import "Login.h"

@implementation Login
@synthesize authenticated;
@synthesize exceptionMessage;
@synthesize userID;
@synthesize isDeviceAlreadyRegistered;
@synthesize errorMessage;

static Login *sharedInstance = nil;

- (id)init {
    
    self = [super init];
    if (self) {
        
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

+ (id) allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

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
    AuthenticateAPI *authenticateAPI = [[AuthenticateAPI alloc]init];
    [authenticateAPI authenticate:username :password];
    
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark -
#pragma mark === Handle Function ===
#pragma mark -

////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Method name: authenticateAPIFinished
 * Description: Sent when authenticateAPI has finished calling successfully.
 * Parameters: -
 */
- (void)authenticateAPIFinished{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"login"
                                                       object:nil];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark -
#pragma mark === Handle Error Function ===
#pragma mark -

////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Method name: authenticateAPIDidFailWithError
 * Description: Sent when authenticateAPI fails to load successfully.
 * Parameters: -
 */
- (void)authenticateAPIDidFailWithError {
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"loginError"
                                                       object:nil];
}



@end

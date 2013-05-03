//
//  QuickPinLogin.m
//  MyMart
//
//  Created by Komsan Noipitak on 4/24/56 BE.
//  Copyright (c) 2556 Komsan Noipitak. All rights reserved.
//

#import "QuickPinLogin.h"

@implementation QuickPinLogin
@synthesize authenticated;
@synthesize exceptionMessage;
@synthesize userID;
@synthesize errorMessage;

static QuickPinLogin *sharedInstance = nil;

+ (QuickPinLogin *)sharedInstance
{
    if (sharedInstance==nil) {
        
        sharedInstance =[[super allocWithZone:NULL]init];
        
    }
    return sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone
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
 * Method name: loginByDeviceQuickPin
 * Description: For calling AuthenticateDeviceQuickPin API
 * Parameters: quickPin
 */

- (void)loginByDeviceQuickPin:(NSString *)quickPin {
    
    AuthenticateDeviceQuickPinAPI *authenticateDeviceQuickPin = [[AuthenticateDeviceQuickPinAPI alloc]init];
    [authenticateDeviceQuickPin authenticateDeviceQuickPin:quickPin];
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark -
#pragma mark === Handle Function ===
#pragma mark -

////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Method name: authenticateDeviceQuickPinFinished
 * Description: Sent when authenticateDeviceQuickPinAPI has finished calling successfully.
 * Parameters: -
 */

- (void)authenticateDeviceQuickPinFinished
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"quickPinLogin"
                                                       object:nil ];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark -
#pragma mark === Handle Error Function ===
#pragma mark -

////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Method name: authenticateAPIFinished
 * Description: Sent when authenticateDeviceQuickPinAPI fails to load successfully.
 * Parameters: -
 */

- (void)authenticateDeviceQuickPinAPIDidFailWithError{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"quickPinLoginError"
                                                       object:nil];
}



@end

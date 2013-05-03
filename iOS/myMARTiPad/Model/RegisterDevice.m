//
//  RegisterDevice.m
//  MyMart
//
//  Created by Komsan Noipitak on 4/23/56 BE.
//  Copyright (c) 2556 Komsan Noipitak. All rights reserved.
//

#import "RegisterDevice.h"

@implementation RegisterDevice
@synthesize registerSuccess;
@synthesize alreadyRegistered;
@synthesize exceptionMessage;
@synthesize errorMessage;


static RegisterDevice *sharedInstance = nil;

+ (RegisterDevice *)sharedInstance
{
    if (sharedInstance == nil) {
        
        sharedInstance = [[super allocWithZone:NULL]init];
        
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
 * Method name: registerUserDevice
 * Description: For Calling RegisterDeviceQuickPin API
 * Parameters: quickPin, deviceID, isForceRegister
 */

- (void)registerUserDevice:(NSString *)quickPin :(NSString *)deviceID :(BOOL)isForceRegister
{
    RegisterDeviceQuickPinAPI *registerDeviceQuickPinAPI = [[RegisterDeviceQuickPinAPI alloc]init];
    [registerDeviceQuickPinAPI registerDeviceQuickPin:quickPin :deviceID :isForceRegister];
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark -
#pragma mark === Handle Function ===
#pragma mark -

////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Method name: registerDeviceQuickPinFinished
 * Description: Sent when RegisterDeviceQuickPinAPI has finished calling successfully.
 * Parameters: -
 */

- (void)registerDeviceQuickPinFinished{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"registerDevice"
                                                       object:nil];

}

////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark -
#pragma mark === Handle Error Function ===
#pragma mark -

////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Method name: authenticateAPIFinished
 * Description: Sent when RegisterDeviceQuickPinAPI fails to load successfully.
 * Parameters: -
 */

- (void)registerDeviceQuickPinAPIDidFailWithError{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"registerDeviceError"
                                                       object:nil];
}


@end

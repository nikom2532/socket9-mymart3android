//
//  ConfigManager.m
//  MyMart
//
//  Created by Komsan Noipitak on 4/23/56 BE.
//  Copyright (c) 2556 Komsan Noipitak. All rights reserved.
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

/**
 * Method name: connection:didReceiveData:
 * Description: Store data
 * Parameters: connection, data
 */
- (id)init
{
    if ( self = [super init] ) {
        
        // Store data for using in application
        privateAES256Key = @"0DB03F0B8D734F339A22E1FCC31D85BC";
        privateSignatureKey = @"C48BC385-25F5-4CAD-BD2C-7EEA72546FF7";
        APIServerURL = @"http://mymart3demo.cloudapp.net/MobileService.svc/json/";
        registerDeviceQuickPinMessage = @"\nThis is a first time you have logged into myMART using this device.\nIf this your personal (trusted) device,\nyou may setup a 'Quick-Pin' for esier future access.\n\nIf this is a shared (public) device, please select 'NO'\n\nThankyou";
        
        forceRegisterDeviceQuickPinMessage = @"";
    }
    return self;
}



@end

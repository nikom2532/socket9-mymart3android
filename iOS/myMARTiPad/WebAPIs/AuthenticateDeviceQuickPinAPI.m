//
//  AuthenticateDeviceQuickPinAPI.m
//  MyMart
//
//  Created by Komsan Noipitak on 4/23/56 BE.
//  Copyright (c) 2556 Komsan Noipitak. All rights reserved.
//

#import "AuthenticateDeviceQuickPinAPI.h"

@implementation AuthenticateDeviceQuickPinAPI
@synthesize resultDictionary;

QuickPinLogin *quickPinLogin;


/**
 * Method name: authenticateDeviceQuickPin
 * Description: Create url for calling API
 * Parameters: quickPin
 */

- (void) authenticateDeviceQuickPin:(NSString *)quickPin {
    
    ConfigManager *configManager = [[ConfigManager alloc]init];
    
    // Get private key for encryption and generate signature
    NSString *privateAES256Key = configManager.privateAES256Key;
    NSString *privateSignatureKey = configManager.privateSignatureKey;

    
    // Get Date/Time
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    [formatter setDateFormat:@"YYYY-MM-dd'T'HH:mm:ss.FFF'Z'"];
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    
    // Encryption Quickpin (AES) and Encoding (Base64)
    NSData *AES256keyData       = [privateAES256Key dataUsingEncoding:NSUTF8StringEncoding];
    NSString *quickPinString    = quickPin;
    NSString *quickPinIV        = [RandomGenerator getNewRandomKey];
    NSData *quickPinIVData      = [quickPinIV convertHexToBytes];
    CocoaSecurityResult *quickPinEncrypted = [CocoaSecurity aesEncrypt:quickPinString
                                                                   key:AES256keyData
                                                                    iv:quickPinIVData];
    NSString *quickPinEncryptedStr = [quickPinEncrypted base64];
    
    // Encryption deviceID (AES) and Encoding (Base64)
    NSString *deviceID      = [DeviceManager getDeviceID];
    NSString *deviceIDIV    = [RandomGenerator getNewRandomKey];
    NSData *deviceIDIVData  = [deviceIDIV convertHexToBytes];
    CocoaSecurityResult *deviceIDEncrypted = [CocoaSecurity aesEncrypt:deviceID
                                                                   key:AES256keyData
                                                                    iv:deviceIDIVData];
    NSString *deviceIDEncryptedStr = [deviceIDEncrypted base64];
    
    
    // Generate signature (HMAC-SHA256)
    NSString *plainText = [NSString stringWithFormat:@"quickpin=%@&deviceid=%@&quickpiniv=%@&deviceidiv=%@&requestdatetime=%@",quickPinEncryptedStr,deviceIDEncryptedStr,quickPinIVData.convertToBase64,deviceIDIVData.convertToBase64,dateString];
    
    CocoaSecurityResult *hmacsha256Result = [CocoaSecurity hmacSha256:plainText hmacKey:privateSignatureKey];
    NSString *hashString = [[[hmacsha256Result hexLower]convertHexToBytes]convertToBase64];
    
    
    // Set URL Format
    NSString *url = [NSString stringWithFormat:@"%@AuthenticateDeviceQuickpin?%@&signature=%@",configManager.APIServerURL,plainText,hashString];

    // Request AuthenticateDeviceQuickpin API using NSURLConection
    NSURLRequest *request   = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NetConnection *netConnection = [[NetConnection alloc]initWithRequest:request tag:@"authenticateDeviceQuickPinAPI"];
    [netConnection start];

}

/**
 * Method name: netConnectionFinished
 * Description: NetConnection did finish
 * Parameters: -
 */

- (void)netConnectionFinished{
    
    quickPinLogin = [[QuickPinLogin alloc]init];
    authenticated = [[[resultDictionary objectForKey:@"AuthenticateDeviceQuickPinJsonResult" ]
                      objectForKey:@"Authenticated"]boolValue];
    
    //// Check Authenticated result
    
    // Authenticated : False
    if (!authenticated) {
        
        exceptionMessage = [[resultDictionary objectForKey:@"AuthenticateDeviceQuickPinJsonResult"]
                            objectForKey:@"ExceptionMessage"];
        quickPinLogin.exceptionMessage = exceptionMessage;
        quickPinLogin.authenticated = authenticated;
        
        
    // Authenticated : True
    }else{
        
        userID = [[resultDictionary objectForKey:@"AuthenticateDeviceQuickPinJsonResult"]
                  objectForKey:@"UserID"];
        quickPinLogin.userID = userID;
        quickPinLogin.authenticated = authenticated;
        
    }
    
    [quickPinLogin authenticateDeviceQuickPinFinished];
    
}


/**
 * Method name: connectionDidFailWithError:
 * Description: NetConnection did fail
 * Parameters: error
 */

- (void)connectionDidFailWithError:(NSError *)error
{
    quickPinLogin.errorMessage = [error localizedDescription];
    [quickPinLogin authenticateDeviceQuickPinAPIDidFailWithError];
}


@end

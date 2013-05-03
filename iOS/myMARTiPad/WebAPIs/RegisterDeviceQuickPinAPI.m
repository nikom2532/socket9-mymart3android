//
//  RegisterDeviceQuickPinAPI.m
//  MyMart
//
//  Created by Komsan Noipitak on 4/23/56 BE.
//  Copyright (c) 2556 Komsan Noipitak. All rights reserved.
//

#import "RegisterDeviceQuickPinAPI.h"

@implementation RegisterDeviceQuickPinAPI
@synthesize resultDictionary;

RegisterDevice *registerDevice;

/**
 * Method name: registerDeviceQuickPin
 * Description: Create url for calling API
 * Parameters: quickPin, deviceID, isForceRegister
 */

- (void)registerDeviceQuickPin:(NSString *)quickPin :(NSString *)deviceID :(BOOL)isForceRegister{
    
    //// Create url to make the request ReqisterDeviceQuickpin API
    ConfigManager *configManager = [[ConfigManager alloc]init];
    Login *login = [[Login alloc]init];
    
    // Get private key for encryption and generate signature
    NSString *privateAES256Key = configManager.privateAES256Key;
    NSString *privateSignatureKey = configManager.privateSignatureKey;
    
    // Get date/time
    NSString *dateString = [Common getRequestDateAndTimeForAPI];
    
    // Encryption Quick-Pin (AES) and Encoding (Base64)
    NSData *AES256keyData   = [privateAES256Key dataUsingEncoding:NSUTF8StringEncoding];
    NSString *quickpin      = quickPin;
    NSString *quickpinIV    = [RandomGenerator getNewRandomKey];
    NSData *quickpinIVData  = [quickpinIV convertHexToBytes];
    CocoaSecurityResult *quickpinEncrypted = [CocoaSecurity aesEncrypt:quickpin
                                                                   key:AES256keyData
                                                                    iv:quickpinIVData];
    NSString *quickpinEncryptedStr = [quickpinEncrypted base64];
    
    // Convert forceoverride from BOOL to NSString
    NSString *forceoverride;
    if (isForceRegister) {
        forceoverride = @"true";
    }else{
        forceoverride = @"false";
    }
    
    // Get deviceID, Encryption(AES), and Encoding(Base64)
    NSString *deviceIDIV = [RandomGenerator getNewRandomKey];
    NSData *deviceIDIVData = [deviceIDIV convertHexToBytes];
    CocoaSecurityResult *deviceIDEncrypted = [CocoaSecurity aesEncrypt:deviceID
                                                                   key:AES256keyData
                                                                    iv:deviceIDIVData];
    NSString *deviceIDEncryptedStr = [deviceIDEncrypted base64];
    
    // Generate signature (HMAC-SHA256)
    NSString *plainText = [NSString stringWithFormat:@"userid=%@&quickpin=%@&deviceid=%@&quickpiniv=%@&deviceidiv=%@&forceoverride=%@&requestdatetime=%@",login.userID,quickpinEncryptedStr,deviceIDEncryptedStr,quickpinIVData.convertToBase64,deviceIDIVData.convertToBase64,forceoverride,dateString];
    NSString *hashString = [SignatureGenerator getSignature:plainText :privateSignatureKey];
    
    // Set URL Format
    NSString *url = [NSString stringWithFormat:@"%@RegisterDeviceQuickPin?%@&signature=%@",configManager.APIServerURL,plainText,hashString];
    NSLog(@"URL %@",url);
    
    // Request RegisterDeviceQuickpin API using NSURLConnection
    NSURLRequest *request       = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NetConnection *netConnection = [[NetConnection alloc]initWithRequest:request tag:@"registerDeviceQuickPinAPI"];
    [netConnection start];
    
}


/**
 * Method name: netConnectionFinished
 * Description: NetConnection did finish
 * Parameters: -
 */

- (void)netConnectionFinished {
    
    registerSuccess = [[[resultDictionary objectForKey:@"RegisterDeviceQuickPinJsonResult"]
                        objectForKey:@"RegisterSuccess"]boolValue];
    
    //// Check Registered result
    // RegisterSuccess : True
    if (registerSuccess) {
        
        alreadyRegistered = [[[resultDictionary objectForKey:@"RegisterDeviceQuickPinJsonResult"]
                              objectForKey:@"AlreadyRegistered"]boolValue];
        registerDevice.alreadyRegistered = alreadyRegistered;
        registerDevice.registerSuccess = registerSuccess;
        
    // RegisterSuccess : False    
    }else{
        
        alreadyRegistered = [[[resultDictionary objectForKey:@"RegisterDeviceQuickPinJsonResult"]
                              objectForKey:@"AlreadyRegistered"]boolValue];
        registerDevice.alreadyRegistered = alreadyRegistered;
        exceptionMessage = [[resultDictionary objectForKey:@"RegisterDeviceQuickPinJsonResult"]
                            objectForKey:@"ExceptionMessage"];
        registerDevice.exceptionMessage = exceptionMessage;
        registerDevice.registerSuccess = registerSuccess;
        
    }
    
    [registerDevice registerDeviceQuickPinFinished];

}


/**
 * Method name: connectionDidFailWithError:
 * Description: NetConnection did fail
 * Parameters: error
 */

- (void)connectionDidFailWithError:(NSError *)error
{
    
    registerDevice.errorMessage = [error localizedDescription];
    [registerDevice registerDeviceQuickPinAPIDidFailWithError];
}


@end

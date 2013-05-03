//
//  AuthenticateAPI.m
//  MyMart
//
//  Created by Komsan Noipitak on 4/23/56 BE.
//  Copyright (c) 2556 Komsan Noipitak. All rights reserved.
//

#import "AuthenticateAPI.h"

@implementation AuthenticateAPI
@synthesize resultDictionary;

Login *login;


/**
 * Method name: authenticate
 * Description: Create url for calling API
 * Parameters: username, password
 */

- (void)authenticate : (NSString *)username : (NSString *)password
{
    
    login = [[Login alloc]init];
    
    // Get private key for encryption and generate signature 
    ConfigManager *configManager = [[ConfigManager alloc]init];
    NSString *privateAES256Key = configManager.privateAES256Key;
    NSString *privateSignatureKey = configManager.privateSignatureKey;
    
    // Get date/time
    NSString *dateString = [Common getRequestDateAndTimeForAPI];
    
    // Encryption Username & Password (AES), Encoding (Base64)
    NSData *AES256keyData   = [privateAES256Key dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *userIV        = [RandomGenerator getNewRandomKey];
    NSData *userIVData      = [userIV convertHexToBytes];
    CocoaSecurityResult *usernameEncrypted = [CocoaSecurity aesEncrypt:username
                                                                   key:AES256keyData
                                                                    iv:userIVData];
    NSString *usernameEncryptedStr = [usernameEncrypted base64];
    
    NSString *passIV    = [RandomGenerator getNewRandomKey];
    NSData *passIVData  = [passIV convertHexToBytes];
    CocoaSecurityResult *passwordEncrypted = [CocoaSecurity aesEncrypt:password
                                                                   key:AES256keyData
                                                                    iv:passIVData];
    NSString *passwordEncryptedStr = [passwordEncrypted base64];
    
    
    // Generate signature (HMAC-SHA256)
    NSString *plainText = [NSString stringWithFormat:@"username=%@&password=%@&useriv=%@&passiv=%@&requestdatetime=%@",usernameEncryptedStr,passwordEncryptedStr,userIVData.convertToBase64,passIVData.convertToBase64,dateString];
    
    NSString *hashString = [SignatureGenerator getSignature:plainText:privateSignatureKey];
    
    // Set URL Format
    NSString *authenticateURL = [NSString stringWithFormat:@"%@Authenticate?%@&signature=%@",configManager.APIServerURL,plainText,hashString];
    
    // Request Authenticate API using NSURLConection
    NSURLRequest *request   = [NSURLRequest requestWithURL:[NSURL URLWithString:authenticateURL]];
    
    NetConnection *netConnection = [[NetConnection alloc]initWithRequest:request tag:@"authenticateAPI"];
    [netConnection start];
    
}



/**
 * Method name: netConnectionFinished
 * Description: NetConnection did finish
 * Parameters: -
 */

- (void)netConnectionFinished{
   
    authenticated = [[[resultDictionary objectForKey:@"AuthenticateJsonResult"]
                      objectForKey:@"Authenticated"]boolValue];
    
    // Authenticated : False
    if (!authenticated) {
        
        login.authenticated = authenticated;
        exceptionMessage = [[resultDictionary objectForKey:@"AuthenticateJsonResult"]
                            objectForKey:@"ExceptionMessage"];
        login.exceptionMessage = [[NSString stringWithString:exceptionMessage] copy];
        
        // Authenticated : True
    }else {
        
        login.authenticated = authenticated;
        userID = [[resultDictionary objectForKey:@"AuthenticateJsonResult"]
                  objectForKey:@"UserID"];
        login.userID = userID;
        
    }
    
    [login authenticateAPIFinished];
}

/**
 * Method name: connectionDidFailWithError:
 * Description: NetConnection did fail
 * Parameters: error
 */

- (void)connectionDidFailWithError:(NSError *)error
{
    login.errorMessage = [error localizedDescription];
    [login authenticateAPIDidFailWithError];
}


@end

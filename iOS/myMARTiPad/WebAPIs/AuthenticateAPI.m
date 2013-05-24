//
//  AuthenticateAPI.m
//  MyMart
//


#import "AuthenticateAPI.h"

@implementation AuthenticateAPI
@synthesize resultDictionary;


/**
 * Method name: authenticate
 * Description: Create URL for calling AutheticateAPI
 * Parameters: username, password
 */

- (void)authenticate : (NSString *)username : (NSString *)password
{
    
    // Get private key for encryption and generate signature
    ConfigManager *configManager = [[ConfigManager alloc]init];
    NSString *privateAES256Key = configManager.privateAES256Key;
    NSString *privateSignatureKey = configManager.privateSignatureKey;
    
    // Get date/time
    NSString *dateString = [Common getRequestDateAndTimeForAPI];
    
    // Encryption Username & Password (AES), Encoding (Base64)
    NSData *AES256keyData   = [privateAES256Key dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *userIV        = [RandomGenerator getNewRandomKey];
    NSString *userIVHexString = [StringToHexConvertor convertStringToHex:userIV];
    NSData *userIVData      = [userIVHexString convertHexToBytes];


    NSLog(@"#### %@ %@ %@",username,AES256keyData,userIVData);
    CocoaSecurityResult *usernameEncrypted = [CocoaSecurity aesEncrypt:username
                                                                   key:AES256keyData
                                                                    iv:userIVData];

    NSString *usernameEncryptedStr = [usernameEncrypted base64];
    NSLog(@"#### %@",usernameEncryptedStr);
    
    NSString *passIV    = [RandomGenerator getNewRandomKey];
    NSString *passIVHexString = [StringToHexConvertor convertStringToHex:passIV];
    NSData *passIVData  = [passIVHexString convertHexToBytes];
    
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
    
    NetConnection *netConnection = [[NetConnection alloc]initWithRequest:request];
    netConnection.delegate = self;
    [netConnection start];
   
}

@end

//
//  RegisterDeviceQuickPinAPI.m
//  MyMart
//


#import "RegisterDeviceQuickPinAPI.h"

@implementation RegisterDeviceQuickPinAPI
@synthesize resultDictionary;

/**
 * Method name: registerDeviceQuickPin
 * Description: Create URL for calling RegisterDeviceQuickPinAPI
 * Parameters: userID, quickPin, deviceID, isForceRegister
 */

- (void)registerDeviceQuickPin:(NSString *)userID :(NSString *)quickPin :(NSString *)deviceID :(BOOL)isForceRegister{
    
    //// Create url to make the request ReqisterDeviceQuickpin API
    ConfigManager *configManager = [[ConfigManager alloc]init];
    
    // Get private key for encryption and generate signature
    NSString *privateAES256Key = configManager.privateAES256Key;
    NSString *privateSignatureKey = configManager.privateSignatureKey;
    
    // Get date/time
    NSString *dateString = [Common getRequestDateAndTimeForAPI];
    
    // Encryption Quick-Pin (AES) and Encoding (Base64)
    NSData *AES256keyData   = [privateAES256Key dataUsingEncoding:NSUTF8StringEncoding];
    NSString *quickpin      = quickPin;
    NSString *quickpinIV    = [RandomGenerator getNewRandomKey];
    NSString *quickpinIVHexString = [StringToHexConvertor convertStringToHex:quickpinIV];
    NSData *quickpinIVData  = [quickpinIVHexString convertHexToBytes];
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
    NSString *deviceIDHexString = [StringToHexConvertor convertStringToHex:deviceIDIV];
    NSData *deviceIDIVData = [deviceIDHexString convertHexToBytes];
    CocoaSecurityResult *deviceIDEncrypted = [CocoaSecurity aesEncrypt:deviceID
                                                                   key:AES256keyData
                                                                    iv:deviceIDIVData];
    NSString *deviceIDEncryptedStr = [deviceIDEncrypted base64];
    
    // Generate signature (HMAC-SHA256)
    NSString *plainText = [NSString stringWithFormat:@"userid=%@&quickpin=%@&deviceid=%@&quickpiniv=%@&deviceidiv=%@&forceoverride=%@&requestdatetime=%@",userID,quickpinEncryptedStr,deviceIDEncryptedStr,quickpinIVData.convertToBase64,deviceIDIVData.convertToBase64,forceoverride,dateString];
    NSString *hashString = [SignatureGenerator getSignature:plainText :privateSignatureKey];
    
    // Set URL Format
    NSString *url = [NSString stringWithFormat:@"%@RegisterDeviceQuickPin?%@&signature=%@",configManager.APIServerURL,plainText,hashString];
    NSLog(@"URL %@",url);
    
    // Request RegisterDeviceQuickpin API using NSURLConnection
    NSURLRequest *request       = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NetConnection *netConnection = [[NetConnection alloc]initWithRequest:request];
    netConnection.delegate = self;
    [netConnection start];
    
}


@end

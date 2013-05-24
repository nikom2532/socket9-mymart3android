//
//  AuthenticateDeviceQuickPinAPI.m
//  MyMart
//


#import "AuthenticateDeviceQuickPinAPI.h"

@implementation AuthenticateDeviceQuickPinAPI
@synthesize resultDictionary;

/**
 * Method name: authenticateDeviceQuickPin
 * Description: Create URL for calling AutheticateDeviceQuickPinAPI
 * Parameters quickPin
 */

- (void) authenticateDeviceQuickPin:(NSString *)quickPin {
    
    ConfigManager *configManager = [[ConfigManager alloc]init];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(netConnectionFinished:)
                                                 name:@"netFinished"
                                               object:nil ];
    
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
    NSString *quickPinIVHexString = [StringToHexConvertor convertStringToHex:quickPinIV];
    NSData *quickPinIVData      = [quickPinIVHexString convertHexToBytes];
    CocoaSecurityResult *quickPinEncrypted = [CocoaSecurity aesEncrypt:quickPinString
                                                                   key:AES256keyData
                                                                    iv:quickPinIVData];
    NSString *quickPinEncryptedStr = [quickPinEncrypted base64];
    
    // Encryption deviceID (AES) and Encoding (Base64)
    NSString *deviceID      = [DeviceManager getDeviceID];
    NSString *deviceIDIV    = [RandomGenerator getNewRandomKey];
    NSString *deviceIDHexString = [StringToHexConvertor convertStringToHex:deviceIDIV];
    NSData *deviceIDIVData  = [deviceIDHexString convertHexToBytes];
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
    NetConnection *netConnection = [[NetConnection alloc]initWithRequest:request];
    netConnection.delegate = self;
    [netConnection start];

}


@end

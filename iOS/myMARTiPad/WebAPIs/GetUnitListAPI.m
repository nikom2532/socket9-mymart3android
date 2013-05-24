//
//  GetUnitListAPI.m
//  MyMart
//

#import "GetUnitListAPI.h"

@implementation GetUnitListAPI
@synthesize resultDictionary;


/**
 * Method name: getUnitList
 * Description: Create URL for calling GetUnitListAPI
 * Parameters: userID, classID
 */

- (void) getUnitList:(NSString *)userID :(NSString *)classID {
    
    ConfigManager *configManager = [[ConfigManager alloc]init];
    
    NSString *privateSignatureKey = configManager.privateSignatureKey;
    
    NSString *dateString = [Common getRequestDateAndTimeForAPI];
    
    
    // Generate signature using HMAC-SHA256
    NSString *plainText = [NSString stringWithFormat:@"userid=%@&classid=%@&requestdatetime=%@",userID,classID,dateString];
    CocoaSecurityResult *hmacsha256Result = [CocoaSecurity hmacSha256:plainText hmacKey:privateSignatureKey];
    NSString *hashString = [[[hmacsha256Result hexLower]convertHexToBytes]convertToBase64];
    
    // Set URL Format
    NSString *url = [NSString stringWithFormat:@"%@GetUnitList?%@&signature=%@",configManager.APIServerURL,plainText,hashString];
    
    // Request GetUnitList API using NSURLConection
    NSURLRequest *request   = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NetConnection *netConnection = [[NetConnection alloc]initWithRequest:request];
    netConnection.delegate = self;
    [netConnection start];
}


@end

//
//  GetClassListAPI.m
//  MyMart
//

#import "GetClassListAPI.h"

@implementation GetClassListAPI
@synthesize resultDictionary;

/**
 * Method name: getClassList
 * Description: Create URL for calling GetClassListAPI
 * Parameters: userID
 */

- (void)getClassList:(NSString *)userID{
    
    ConfigManager *configManager = [[ConfigManager alloc]init];
    NSString *privateSignatureKey = configManager.privateSignatureKey;
    
    // Get date/time
    NSString *dateString = [Common getRequestDateAndTimeForAPI];
    
    // Generate signature using HMAC-SHA256
    NSString *plainText = [NSString stringWithFormat:@"userid=%@&requestdatetime=%@",userID,dateString];
    CocoaSecurityResult *hmacsha256Result = [CocoaSecurity hmacSha256:plainText hmacKey:privateSignatureKey];
    NSString *hashString = [[[hmacsha256Result hexLower]convertHexToBytes]convertToBase64];
    
    // Set URL Format
    NSString *url = [NSString stringWithFormat:@"%@GetClassList?%@&signature=%@",configManager.APIServerURL,plainText,hashString];
    
    // Request GetClassList API using NSURLConection
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NetConnection *netConnection = [[NetConnection alloc]initWithRequest:request];
    netConnection.delegate = self;
    [netConnection start];
}



@end

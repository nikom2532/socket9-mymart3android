//
//  GetClassListAPI.m
//  MyMart
//
//  Created by Komsan Noipitak on 4/23/56 BE.
//  Copyright (c) 2556 Komsan Noipitak. All rights reserved.
//

#import "GetClassListAPI.h"

@implementation GetClassListAPI
@synthesize resultDictionary;

ClassList *classList;

/**
 * Method name: getClassList
 * Description: Create url for calling API
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
    NetConnection *netConnection = [[NetConnection alloc]initWithRequest:request tag:@"getClassListAPI"];
    [netConnection start];
}

/**
 * Method name: netConnectionFinished
 * Description: NetConnection did finish
 * Parameters: -
 */

- (void)netConnectionFinished{
    
    ClassList *classList = [[ClassList alloc]init];
    userClassList = [[NSArray alloc]init];
    userClassList = [[resultDictionary objectForKey:@"GetClassListJsonResult"]
                     objectForKey:@"Classes"];
    classList.userClassList = userClassList;
    classList.classListSuccess = YES;
    
    if ([userClassList count] == 1) {
        classList.isUserHasOnlyOneClass = YES;
    }
    
    [classList getClassListAPIFinished];
}

/**
 * Method name: connectionDidFailWithError:
 * Description: NSURLConnection did fail
 * Parameters: error
 */

- (void)connectionDidFailWithError:(NSError *)error
{
    classList.errorMessage = [error localizedDescription];
    [classList getClassListAPIDidFailWithError];
}


@end

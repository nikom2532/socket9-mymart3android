//
//  GetUnitListAPI.m
//  MyMart
//
//  Created by Komsan Noipitak on 4/23/56 BE.
//  Copyright (c) 2556 Komsan Noipitak. All rights reserved.
//

#import "GetUnitListAPI.h"

@implementation GetUnitListAPI
@synthesize resultDictionary;

UnitList *unitList;


/**
 * Method name: getUnitList
 * Description: Create url for calling API
 * Parameters: userID, classID
 */

- (void) getUnitList:(NSString *)userID :(NSString *)classID {
    
    ConfigManager *configManager = [[ConfigManager alloc]init];
    Login *login = [[Login alloc]init];
    
    NSString *privateSignatureKey = configManager.privateSignatureKey;
    
    NSString *dateString = [Common getRequestDateAndTimeForAPI];
    
    // Get userID 
    userID = login.userID;
    
    // Generate signature using HMAC-SHA256
    NSString *plainText = [NSString stringWithFormat:@"userid=%@&classid=%@&requestdatetime=%@",userID,classID,dateString];
    CocoaSecurityResult *hmacsha256Result = [CocoaSecurity hmacSha256:plainText hmacKey:privateSignatureKey];
    NSString *hashString = [[[hmacsha256Result hexLower]convertHexToBytes]convertToBase64];
    
    // Set URL Format
    NSString *url = [NSString stringWithFormat:@"%@GetUnitList?%@&signature=%@",configManager.APIServerURL,plainText,hashString];
    
    // Request GetUnitList API using NSURLConection
    NSURLRequest *request   = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NetConnection *netConnection = [[NetConnection alloc]initWithRequest:request tag:@"getUnitListAPI"];
    [netConnection start];
}

/**
 * Method name: netConnectionFinished
 * Description: NetConnection did finish
 * Parameters: -
 */

- (void)netConnectionFinished {
    
    unitList = [[UnitList alloc]init];
    userUnitList = [[NSArray alloc]init];
    userUnitList = [[resultDictionary objectForKey:@"GetUnitListJsonResult"]
                    objectForKey:@"Units"];
    unitList.userUnitList = userUnitList;
    unitList.unitListSuccess = YES;
    
    if ([userUnitList count] == 1) {
        unitList.isUserHasOnlyOneUnit = YES;
    }
    
    [unitList getUnitListAPIFinished];
}

/**
 * Method name: connectionDidFailWithError:
 * Description: NSURLConnection did fail
 * Parameters: error
 */

- (void)connectionDidFailWithError:(NSError *)error
{
    unitList.errorMessage = [error localizedDescription];
    [unitList getUnitListAPIDidFailWithError];
}

@end

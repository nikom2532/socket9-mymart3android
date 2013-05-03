//
//  NetConnection.m
//  myMARTiPad
//
//  Created by Komsan Noipitak on 5/3/56 BE.
//  Copyright (c) 2556 Komsan Noipitak. All rights reserved.
//

#import "NetConnection.h"

@implementation NetConnection

- (id)initWithRequest:(NSURLRequest *)request tag:(NSString *)newTag {
    
	if (self = [super init]) {
        
        tag = newTag;
        urlConnection      = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        responseData       = [NSMutableData data];
        
    }
    return self;
}

- (void)start {
    
    [urlConnection start];
}

- (NSString *)tag {
	return tag;
}

/**
 * Method name: connectionDidFinishLoading:
 * Description: Sent as a connection loads data incrementally. (required)
 * Parameters: connection
 */

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
    [responseData appendData:data];

}

/**
 * Method name: connectionDidFinishLoading:
 * Description: Sent when a connection has finished loading successfully. (required)
 * Parameters: connection
 */

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    // Convert AuthenticateJsonResult to NSDictionary
    NSError *error;
    resultDictionary = [NSJSONSerialization JSONObjectWithData:responseData
                                                       options:kNilOptions
                                                         error:&error];
    responseData = nil;
    urlConnection = nil;
    
    if ([self.tag isEqualToString:@"authenticateAPI"]) {
        
		AuthenticateAPI *authenticateAPI = [[AuthenticateAPI alloc]init];
        authenticateAPI.resultDictionary = resultDictionary;
        [authenticateAPI netConnectionFinished];
        
	}else if ([self.tag isEqualToString:@"authenticateDeviceQuickPinAPI"]) {
        
        AuthenticateDeviceQuickPinAPI *authenticateDeviceQuickPinAPI = [[AuthenticateDeviceQuickPinAPI alloc]init];
        authenticateDeviceQuickPinAPI.resultDictionary = resultDictionary;
        [authenticateDeviceQuickPinAPI netConnectionFinished];
        
    }else if ([self.tag isEqualToString:@"registerDeviceQuickPinAPI"]) {
        
        RegisterDeviceQuickPinAPI *registerDeviceQuickPinAPI = [[RegisterDeviceQuickPinAPI alloc]init];
        [registerDeviceQuickPinAPI netConnectionFinished];

        
    }else if ([self.tag isEqualToString:@"getClassListAPI"]) {
        
        GetClassListAPI *getClassListAPI = [[GetClassListAPI alloc]init];
        getClassListAPI.resultDictionary = resultDictionary;
        [getClassListAPI netConnectionFinished];
        
    }else if ([self.tag isEqualToString:@"getUnitListAPI"]) {
        
        GetUnitListAPI *getUnitListAPI = [[GetUnitListAPI alloc]init];
        getUnitListAPI.resultDictionary = resultDictionary;
        [getUnitListAPI netConnectionFinished];
        
    }
    
}

/**
 * Method name: connection:didFailWithError:
 * Description: Sent when a connection fails to load its request successfully.
 * Parameters: connection, error
 */

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
        
    if ([self.tag isEqualToString:@"authenticateAPI"]) {
        
		AuthenticateAPI *authenticateAPI = [[AuthenticateAPI alloc]init];
        [authenticateAPI connectionDidFailWithError:error];
        
	}else if ([self.tag isEqualToString:@"authenticateDeviceQuickPinAPI"]) {
        
        AuthenticateDeviceQuickPinAPI *authenticateDeviceQuickPinAPI = [[AuthenticateDeviceQuickPinAPI alloc]init];
        [authenticateDeviceQuickPinAPI connectionDidFailWithError:error];
        
    }else if ([self.tag isEqualToString:@"registerDeviceQuickPinAPI"]) {
        
        RegisterDeviceQuickPinAPI *registerDeviceQuickPinAPI = [[RegisterDeviceQuickPinAPI alloc]init];
        [registerDeviceQuickPinAPI connectionDidFailWithError:error];
        
        
    }else if ([self.tag isEqualToString:@"getClassListAPI"]) {
        
        GetClassListAPI *getClassListAPI = [[GetClassListAPI alloc]init];
        [getClassListAPI connectionDidFailWithError:error];
        
        
    }else if ([self.tag isEqualToString:@"getUnitListAPI"]) {
        
        GetUnitListAPI *getUntListAPI = [[GetUnitListAPI alloc]init];
        [getUntListAPI connectionDidFailWithError:error];
        
    }

}



@end

//
//  AuthenticateDeviceQuickPinAPI.h
//  MyMart
//
//  Created by Komsan Noipitak on 4/23/56 BE.
//  Copyright (c) 2556 Komsan Noipitak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CocoaSecurity.h"
#import "Common.h"
#import "RandomGenerator.h"
#import "SignatureGenerator.h"
#import "NSString+HexToByteConverter.h"
#import "Login.h"
#import "ConfigManager.h"
#import "QuickPinLogin.h"
#import "DeviceManager.h"
#import "AppDelegate.h"
#import "NetConnection.h"

@interface AuthenticateDeviceQuickPinAPI : NSObject {
    
    BOOL authenticated;
    NSString *exceptionMessage;
    NSString *userID;
    
    NSURLConnection *QPinLoginUrlConnection;
    NSMutableData   *QPinLoginResponseData;
    NSDictionary    *resultDictionary;
        
}

@property (retain, nonatomic) NSDictionary *resultDictionary;

- (void)authenticateDeviceQuickPin :(NSString *)quickPin;
- (void)netConnectionFinished;
- (void)connectionDidFailWithError:(NSError *)error;

@end

//
//  RegisterDeviceQuickPinAPI.h
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
#import "RegisterDevice.h"
#import "NetConnection.h"

@interface RegisterDeviceQuickPinAPI : NSObject < NSURLConnectionDelegate > {
    
    BOOL registerSuccess;
    BOOL alreadyRegistered;
    NSString *exceptionMessage;
    
    NSURLConnection *registerQPinUrlConnection;
    NSMutableData   *registerQPinResponseData;
    NSDictionary *resultDictionary;
    
}

@property (retain, nonatomic) NSDictionary *resultDictionary;

- (void)registerDeviceQuickPin:(NSString *)quickPin :(NSString *)deviceID :(BOOL)isForceRegister;
- (void)netConnectionFinished;
- (void)connectionDidFailWithError:(NSError *)error;


@end

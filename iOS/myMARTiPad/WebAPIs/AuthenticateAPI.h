//
//  AuthenticateAPI.h
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
#import "NetConnection.h"


@interface AuthenticateAPI : NSObject {
    
    BOOL authenticated;
    NSString *exceptionMessage;
    NSString *userID;
    
    NSURLConnection *loginUrlConnection;
    NSMutableData   *loginResponseData;
    NSDictionary    *resultDictionary;

}

@property (retain, nonatomic) NSDictionary *resultDictionary;

- (void)authenticate:(NSString *)username :(NSString *)password;
- (void)netConnectionFinished;
- (void)connectionDidFailWithError:(NSError *)error;

@end


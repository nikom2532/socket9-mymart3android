//
//  QuickPinLogin.h
//  MyMart
//
//  Created by Komsan Noipitak on 4/24/56 BE.
//  Copyright (c) 2556 Komsan Noipitak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AuthenticateDeviceQuickPinAPI.h"

@interface QuickPinLogin : NSObject {
    
    BOOL authenticated;
    NSString *exceptionMessage;
    NSString *userID;
    NSString *errorMessage;
    
}

@property (nonatomic, assign) BOOL authenticated;
@property (nonatomic, retain) NSString *exceptionMessage;
@property (nonatomic, retain)  NSString *userID;
@property (nonatomic, retain) NSString *errorMessage;

- (void) loginByDeviceQuickPin :(NSString *)quickPin;
+ (QuickPinLogin *)sharedInstance;
- (void)authenticateDeviceQuickPinFinished;
- (void)authenticateDeviceQuickPinAPIDidFailWithError;


@end

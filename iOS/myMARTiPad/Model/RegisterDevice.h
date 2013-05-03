//
//  RegisterDevice.h
//  MyMart
//
//  Created by Komsan Noipitak on 4/23/56 BE.
//  Copyright (c) 2556 Komsan Noipitak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegisterDeviceQuickPinAPI.h"

@interface RegisterDevice : NSObject {
    
    BOOL registerSuccess;
    BOOL alreadyRegistered;
    NSString *exceptionMessage;
    NSString *errorMessage;
    
}

@property (nonatomic, assign) BOOL registerSuccess;
@property (nonatomic, assign) BOOL alreadyRegistered;
@property (nonatomic, retain) NSString *exceptionMessage;
@property (nonatomic, retain) NSString *errorMessage;

- (void) registerUserDevice:(NSString *)quickPin :(NSString *)deviceID :(BOOL)isForceRegister;
+ (RegisterDevice *)sharedInstance;
- (void) registerDeviceQuickPinFinished;
- (void)registerDeviceQuickPinAPIDidFailWithError;


@end

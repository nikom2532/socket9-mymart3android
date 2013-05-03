//
//  ConfigManager.h
//  MyMart
//
//  Created by Komsan Noipitak on 4/23/56 BE.
//  Copyright (c) 2556 Komsan Noipitak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConfigManager : NSObject {
    
    NSString *isLogAllowed;
    NSString *logFileName;
    NSString *logFilePath;
    NSString *privateAES256Key;
    NSString *privateSignatureKey;
    NSString *APIServerURL;
    NSString *registerDeviceQuickPinMessage;
    NSString *forceRegisterDeviceQuickPinMessage;
    
}

@property (nonatomic, retain) NSString *isLogAllowed;
@property (nonatomic, retain) NSString *logFileName;
@property (nonatomic, retain) NSString *logFilePath;
@property (nonatomic, retain) NSString *privateAES256Key;
@property (nonatomic, retain) NSString *privateSignatureKey;
@property (nonatomic, retain) NSString *APIServerURL;
@property (nonatomic, retain) NSString *registerDeviceQuickPinMessage;
@property (nonatomic, retain) NSString *forceRegisterDeviceQuickPinMessage;

@end

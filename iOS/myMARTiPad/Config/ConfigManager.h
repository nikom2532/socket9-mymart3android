//
//  ConfigManager.h
//  MyMart
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
    NSString *errorMessage;
    NSString *authenticationFailed;
    NSString *registerDeviceQuickPinFailed;
    NSString *askToRegisterDeviceQuickPin;
    NSString *quickPinNotMatch;
    NSString *registeringQuickPin;
    NSString *insertQuickPin;
    NSString *emptyUsernamePassword;
    
    NSString *parameterIsEmpty;
}

@property (nonatomic, retain) NSString *isLogAllowed;
@property (nonatomic, retain) NSString *logFileName;
@property (nonatomic, retain) NSString *logFilePath;
@property (nonatomic, retain) NSString *privateAES256Key;
@property (nonatomic, retain) NSString *privateSignatureKey;
@property (nonatomic, retain) NSString *APIServerURL;
@property (nonatomic, retain) NSString *registerDeviceQuickPinMessage;
@property (nonatomic, retain) NSString *forceRegisterDeviceQuickPinMessage;
@property (nonatomic, retain) NSString *errorMessage;
@property (nonatomic, retain) NSString *authenticationFailed;
@property (nonatomic, retain) NSString *registerDeviceQuickPinFailed;
@property (nonatomic, retain) NSString *askToRegisterDeviceQuickPin;
@property (nonatomic, retain) NSString *quickPinNotMatch;
@property (nonatomic, retain) NSString *registeringQuickPin;
@property (nonatomic, retain) NSString *insertQuickPin;
@property (nonatomic, retain) NSString *emptyUsernamePassword;

@property (nonatomic, retain) NSString *parameterIsEmpty;

@end

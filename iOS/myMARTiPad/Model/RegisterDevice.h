//
//  RegisterDevice.h
//  MyMart
//


@protocol RegisterDeviceDelegate
- (void) registerDeviceFinished;
- (void) registerDeviceDidFailWithError;
@end

#import <Foundation/Foundation.h>
#import "RegisterDeviceQuickPinAPI.h"
#import "ConfigManager.h"
#import "LogManager.h"

@interface RegisterDevice : NSObject <APICallBackDelegate> {
    
    BOOL registerSuccess;
    BOOL alreadyRegistered;
    NSString *exceptionMessage;
    NSString *errorMessage;
    
    id <RegisterDeviceDelegate> delegate;
    id <InterfaceRegisterDeviceQuickPinAPI> registerDeviceQuickPinAPI;
}

@property (nonatomic, assign) BOOL registerSuccess;
@property (nonatomic, assign) BOOL alreadyRegistered;
@property (nonatomic, retain) NSString *exceptionMessage;
@property (nonatomic, retain) NSString *errorMessage;

@property (nonatomic, retain) id <RegisterDeviceDelegate> delegate;

- (void) registerUserDevice:(NSString *)userID :(NSString *)quickPin :(NSString *)deviceID :(BOOL)isForceRegister;
+ (RegisterDevice *)sharedInstance;
- (id)init:(id <InterfaceRegisterDeviceQuickPinAPI>)api;
@end

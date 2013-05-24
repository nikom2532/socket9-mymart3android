//
//  QuickPinLogin.h
//  MyMart
//


@protocol QuickPinLoginDelegate
- (void) quickPinLoginFinished;
- (void) quickPinLoginDidFailWithError;
@end

#import <Foundation/Foundation.h>
#import "AuthenticateDeviceQuickPinAPI.h"
#import "ConfigManager.h"
#import "LogManager.h"

@interface QuickPinLogin : NSObject <APICallBackDelegate> {
    
    BOOL authenticated;
    NSString *exceptionMessage;
    NSString *userID;
    NSString *errorMessage;
    
    id <QuickPinLoginDelegate> delegate;
    id <InterfaceAuthenticateDeviceQuickPinAPI> authenticateDeviceQuickPinAPI;
    
}

@property (nonatomic, assign) BOOL authenticated;
@property (nonatomic, retain) NSString *exceptionMessage;
@property (nonatomic, retain)  NSString *userID;
@property (nonatomic, retain) NSString *errorMessage;

@property (nonatomic, retain) id <QuickPinLoginDelegate> delegate;


- (void) loginByDeviceQuickPin :(NSString *)quickPin;
+ (QuickPinLogin *)sharedInstance;
- (id)init:(id <InterfaceAuthenticateDeviceQuickPinAPI>)api;

@end

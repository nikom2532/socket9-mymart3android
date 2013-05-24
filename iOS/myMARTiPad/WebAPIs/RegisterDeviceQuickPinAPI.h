//
//  RegisterDeviceQuickPinAPI.h
//  MyMart
//


#import <Foundation/Foundation.h>
#import "CocoaSecurity.h"
#import "Common.h"
#import "RandomGenerator.h"
#import "SignatureGenerator.h"
#import "NSString+HexToByteConverter.h"
#import "ConfigManager.h"
#import "NetConnection.h"
#import "StringToHexConvertor.h"
#import "APICallBack.h"

@protocol InterfaceRegisterDeviceQuickPinAPI
- (void)registerDeviceQuickPin:(NSString *)userID :(NSString *)quickPin :(NSString *)deviceID :(BOOL)isForceRegister;
- (void)setAPICallBackDelegate:(id<APICallBackDelegate>)authenticateAPIDelegate;
@end

@interface RegisterDeviceQuickPinAPI : APICallBack <InterfaceRegisterDeviceQuickPinAPI, NetConnectionDelegate> {
    
    BOOL registerSuccess;
    BOOL alreadyRegistered;
    NSString *exceptionMessage;
    
    NSURLConnection *registerQPinUrlConnection;
    NSMutableData   *registerQPinResponseData;
    NSDictionary *resultDictionary;
    
}

@property (retain, nonatomic) NSDictionary *resultDictionary;

- (void)registerDeviceQuickPin:(NSString *)userID :(NSString *)quickPin :(NSString *)deviceID :(BOOL)isForceRegister;

@end

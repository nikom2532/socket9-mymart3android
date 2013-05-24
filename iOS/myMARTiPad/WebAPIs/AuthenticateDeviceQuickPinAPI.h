//
//  AuthenticateDeviceQuickPinAPI.h
//  MyMart
//

#import <Foundation/Foundation.h>
#import "CocoaSecurity.h"
#import "Common.h"
#import "RandomGenerator.h"
#import "SignatureGenerator.h"
#import "NSString+HexToByteConverter.h"
#import "ConfigManager.h"
#import "DeviceManager.h"
#import "NetConnection.h"
#import "StringToHexConvertor.h"
#import "APICallBack.h"

@protocol InterfaceAuthenticateDeviceQuickPinAPI
- (void)authenticateDeviceQuickPin :(NSString *)quickPin;
- (void)setAPICallBackDelegate:(id<APICallBackDelegate>)authenticateAPIDelegate;
@end

@interface AuthenticateDeviceQuickPinAPI : APICallBack <NetConnectionDelegate, InterfaceAuthenticateDeviceQuickPinAPI>
{
    
    BOOL authenticated;
    NSString *exceptionMessage;
    NSString *userID;
    
    NSURLConnection *QPinLoginUrlConnection;
    NSMutableData   *QPinLoginResponseData;
    NSDictionary    *resultDictionary;

}

@property (retain, nonatomic) NSDictionary *resultDictionary;

- (void)authenticateDeviceQuickPin :(NSString *)quickPin;

@end

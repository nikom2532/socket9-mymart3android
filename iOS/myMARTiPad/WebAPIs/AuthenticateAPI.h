//
//  AuthenticateAPI.h
//  MyMart
//


#import <Foundation/Foundation.h>
#import "CocoaSecurity.h"
#import "Common.h"
#import "RandomGenerator.h"
#import "SignatureGenerator.h"
#import "NSString+HexToByteConverter.h"
#import "ConfigManager.h"
#import "StringToHexConvertor.h"
#import "NetConnection.h"
#import "APICallBack.h"


@protocol InterfaceAuthenticateAPI
- (void)authenticate:(NSString *)username :(NSString *)password;
- (void)setAPICallBackDelegate:(id <APICallBackDelegate>)apiCallBackDelegate;
@end

@interface AuthenticateAPI : APICallBack <InterfaceAuthenticateAPI, NetConnectionDelegate> {
    
    BOOL authenticated;
    NSString *exceptionMessage;
    NSString *userID;
    
    NSURLConnection *loginUrlConnection;
    NSMutableData   *loginResponseData;
    NSDictionary    *resultDictionary;


}

@property (retain, nonatomic) NSDictionary *resultDictionary;

- (void)authenticate:(NSString *)username :(NSString *)password;

@end


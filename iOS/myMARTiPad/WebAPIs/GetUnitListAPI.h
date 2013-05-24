//
//  GetUnitListAPI.h
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
#import "APICallBack.h"

@protocol InterfaceGetUnitListAPI
- (void) getUnitList :(NSString *)userID :(NSString *)classID;
- (void)setAPICallBackDelegate:(id<APICallBackDelegate>)authenticateAPIDelegate;
@end

@interface GetUnitListAPI : APICallBack <InterfaceGetUnitListAPI, NetConnectionDelegate> {
    
    BOOL unitListSuccess;
    NSArray *userUnitList;
    NSString *exceptionMessage;
    
    NSURLConnection *getUnitUrlConnection;
    NSMutableData   *getUnitResponseData;
    NSDictionary *resultDictionary;
    

}

@property (retain, nonatomic) NSDictionary *resultDictionary;

- (void) getUnitList :(NSString *)userID :(NSString *)classID;


@end

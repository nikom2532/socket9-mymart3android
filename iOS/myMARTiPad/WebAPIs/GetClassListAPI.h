
//
//  GetClassListAPI.h
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

@protocol InterfaceGetClassListAPI
- (void) getClassList :(NSString *)userID;
- (void)setAPICallBackDelegate:(id<APICallBackDelegate>)authenticateAPIDelegate;
@end

@interface GetClassListAPI : APICallBack <InterfaceGetClassListAPI, NetConnectionDelegate>{
    
    BOOL classListSuccess;
    BOOL reportingPeriod;
    NSArray *userClassList;
    NSString *exceptionMessage;
    
    NSURLConnection *getClassUrlConnection;
    NSMutableData *getClassResponseData;
    NSDictionary *resultDictionary;

    
}

@property (retain, nonatomic) NSDictionary *resultDictionary;

- (void) getClassList :(NSString *)userID;

@end

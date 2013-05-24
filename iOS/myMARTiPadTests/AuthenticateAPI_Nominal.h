//
//  AuthenticateAPI_Nominal.h
//  myMARTiPad
//

#import <Foundation/Foundation.h>
#import "NetConnection.h"
#import "APICallBack.h"

@interface AuthenticateAPI_Nominal : APICallBack <InterfaceAuthenticateAPI> {
    
    BOOL authenticated;
    NSString *exceptionMessage;
    NSString *userID;
    
    NSDictionary *resultDictionary;
}

@property (retain, nonatomic) NSDictionary *resultDictionary;

- (void)authenticate:(NSString *)username :(NSString *)password;

@end
